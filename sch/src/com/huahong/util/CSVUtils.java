package com.huahong.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**   
 * 文件规则   
 * Microsoft的格式是最简单的。以逗号分隔的值要么是“纯粹的”（仅仅包含在括号之前），   
 * 要么是在双引号之间（这时数据中的双引号以一对双引号表示）。   
 * Ten Thousand,10000, 2710 ,,"10,000","It's ""10 Grand"", baby",10K   
 * 这一行包含七个字段（fields）：   
 *  Ten Thousand   
 *  10000   
 *   2710    
 *  空字段   
 *  10,000   
 *  It's "10 Grand", baby   
 *  10K   
 * 每条记录占一行   
 * 以逗号为分隔符   
 * 逗号前后的空格会被忽略   
 * 字段中包含有逗号，该字段必须用双引号括起来。如果是全角的没有问题。   
 * 字段中包含有换行符，该字段必须用双引号括起来   
 * 字段前后包含有空格，该字段必须用双引号括起来   
 * 字段中的双引号用两个双引号表示   
 * 字段中如果有双引号，该字段必须用双引号括起来   
 * 第一条记录，可以是字段名   
 */ 
public class CSVUtils {
	/**
	 * 符号，下面用于得到系统路径符号
	 */
	private static final String sysMark = System.getProperty("file.separator");
	
	private static final String sp = System.getProperty("line.separator");

	private static final String SPECIAL_CHAR_A = "[^\",\\n 　]";

	private static final String SPECIAL_CHAR_B = "[^\",\\n]";
	
	/**
	 * 缓冲区读取对象
	 */
	private BufferedReader bufferedreader = null;

	/**
	 * 导出为CVS文件
	 * 
	 * @param exportData传入参数，list中存的是一维数组的集合
	 * @param outPutPath生成文件路径，不包含文件名
	 * 传入的参数一定要注意对逗号，单引号，双引号进行转码，否则会出问题
	 */
	public static String exportCSVFile(List exportData, String outPutPath) {
		File csvFile = null;
		OutputStreamWriter csvFileOutputStream = null;
		Object ret_obj = null;
		String fileName="";
		try {
			csvFile = File.createTempFile("temp", ".csv", new File(outPutPath));
			//导出生成文件的文件名
			 String fileNameTemp=csvFile.toString().replace("\\", "/");
			 fileName=fileNameTemp.split("/")[fileNameTemp.split("/").length-1];
			// GB2312使正确读取分隔符","
			csvFileOutputStream = new OutputStreamWriter(new FileOutputStream(csvFile), "GBK");
			// 写入文件内容
			for(int lc1=0;lc1<exportData.size();lc1++){
				for(int lc2=0;lc2 < ((String[])exportData.get(lc1)).length;lc2++){
					
					ret_obj = ((String[])exportData.get(lc1))[lc2]; 
					
					if(ret_obj!=null){
						csvFileOutputStream.write(ConvertToSaveCell(ret_obj.toString()));
					}else{
						csvFileOutputStream.write("");
					}
					if(lc2<((String[])exportData.get(lc1)).length-1){
						//cell之间用","进行区分
						csvFileOutputStream.write(",");
					}
				}
				//换行
				csvFileOutputStream.write(sp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				csvFileOutputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return fileName;
	}
	/**
	 * 用于处理逗号，双引号，回车换行问题
	 * @param cell
	 * @return
	 */
	 private static String ConvertToSaveCell(String cell)
	  {
	   cell = cell.replace("\"","\"\"");
	  
	   return "\"" + cell + "\"";
	  }
	/**
	 * 导入csv文件
	 * fileName为文件的全路径，包括文件名
	 * @param fileName
	 * @return
	 */
	public List importCSVFile(String fileName) {
		List list = new ArrayList();
		// 实例缓冲读取目标csv文件
		try {
			bufferedreader = new BufferedReader(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		// 获取正则表达式
		String regExp = this.getRegExp();

		// 存放临时读取行对象
		String stemp = null;

		// 单元格字符串
		String str;
		int i = 0;
		// 循环读取文件的每一行
		try {
			while ((stemp = bufferedreader.readLine()) != null) {
				i++;
				// 通过正则表达式得到正则样式对象
				Pattern pattern = Pattern.compile(regExp);
				if (stemp.endsWith(",")) {
					stemp = stemp.substring(0, stemp.length() - 1);
//					str = str.trim();
				}
				// 通过正则样式对象得到每行的matcher对象
				Matcher matcher = pattern.matcher(stemp);
				// 每行记录一个list
				List<String> cells = new ArrayList<String>();
				
				// 读取每个单元格
				while (matcher.find()) {
					// 得到单元格内容
					str = matcher.group();
//					str=str.replace(" ", "\b");
					// 过滤内容中的空格
//					str = str.trim();// 注意这里获取的子字符串是带分隔符的

					// 单元格内容后面包含逗号则需要去掉
					if (str.endsWith(",")) {
						str = str.substring(0, str.length() - 1);
//						str=str.replace(",", "\",\"");
//						str = str.trim();
					}
					/*
					 * 单元格内容前后都包含双引号则需要去掉，前后都需要处理
					 * 注意：如果csv单元格有双引号，则解析时会是3个引号，前后包围中间一个
					 * 过滤掉第一个引号之后还剩下2个引号，则需要替换成需要的内容即可 此处的过滤及替换可以进行要求变更
					 */
					if (str.startsWith("\"") && str.endsWith("\"")) {
						str = str.substring(1, str.length() - 1);
//						if (this.isExisted("\"\"", str)) {
//							str = str.replaceAll("\"\"", "");
//						}
					}
					if(str.endsWith(" ")){
						str = str.substring(0, str.length() - 1);
					}
					if(str.startsWith(" ")){
						str = str.substring(1, str.length());
					}
//					System.out.println("str==="+str);
					cells.add(str);
					// 判断过滤后的单元格内容，非空则添加到行数据集中
//					if (!"".equals(str)) {
//						System.out.print(str + " ");
//					}
				}
				for(int k=0;k<cells.size();k++){
					if(k==cells.size()-1){
						cells.remove(k);
					}
					
				}
//				System.out.println("cells.size()========"+cells.size());
				list.add(cells);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				// 关闭缓冲
				if (bufferedreader != null) {
					bufferedreader.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
//		System.out.println("list=====" + list);
		return list;
	}

	/**
	 * 正则表达式
	 * 
	 * @return String
	 */
	private String getRegExp() {
		// 实例化得到动态字符串对象
		StringBuffer strRegExps = new StringBuffer();

		strRegExps.append("\"((");

		strRegExps.append(SPECIAL_CHAR_A);

		strRegExps.append("*[,\\n 　])*(");

		strRegExps.append(SPECIAL_CHAR_A);

		strRegExps.append("*\"{2})*)*");

		strRegExps.append(SPECIAL_CHAR_A);

		strRegExps.append("*\"[ 　]*,[ 　]*");

		strRegExps.append("|");

		strRegExps.append(SPECIAL_CHAR_B);

		strRegExps.append("*[ 　]*,[ 　]*");

		strRegExps.append("|\"((");

		strRegExps.append(SPECIAL_CHAR_A);

		strRegExps.append("*[,\\n 　])*(");

		strRegExps.append(SPECIAL_CHAR_A);

		strRegExps.append("*\"{2})*)*");

		strRegExps.append(SPECIAL_CHAR_A);

		strRegExps.append("*\"[ 　]*");

		strRegExps.append("|");

		strRegExps.append(SPECIAL_CHAR_B);

		strRegExps.append("*[ 　]*");

		return strRegExps.toString();
	}
	/**
	 * 检索比对
	 * 
	 * @param argChar
	 * @param argStr
	 * @return
	 */
	private boolean isExisted(String argChar, String argStr) {
		// 判断的boolean对象
		boolean blnReturnValue = false;
		// 检索被检索字符串中是否包含检索字符串
		if ((argStr.indexOf(argChar) >= 0)&& (argStr.indexOf(argChar) <= argStr.length())) {
			blnReturnValue = true;
		}
		return blnReturnValue;
	}

	public static void main(String[]args) {
//		 List exportData = new ArrayList<String[]>();
//		 String [] temp= new String [4];
//		 temp[0] = "第一列";
//		 temp[1] = "第二列";
//		 temp[2] = "第三列";
//		 temp[3] = "第四列";
//		 exportData.add(temp);
//		 
//		 temp= new String [4];
//		 temp[0] = "1231";
//		 temp[1] = "";
//		 temp[2] = "1233";
//		 temp[3] = "1234";
//		 exportData.add(temp);
//		 
//		 temp= new String [4];
//		 temp[0] = "1235";
//		 temp[1] = "1236";
//		 temp[2] = "1237";
//		 temp[3] = "1238";
//		 exportData.add(temp);
//		 String fileName = CSVUtils.exportCSVFile(exportData, "c:/");
//		System.out.println( "fileName="+fileName);

//		CSVUtils csv = new CSVUtils();
//		List importData = csv.importCSVFile("c:/" + fileName);
//		System.out.println( "importData="+importData);
//		CSVUtils csv = new CSVUtils();
//		List importData = csv.importCSVFile("c:/temp5936.csv");
//		System.out.println( "importData="+importData);
//		for(int i=0;i<importData.size();i++){
//			List list = (List)importData.get(i);
//			final int size = list.size();
//			String[] temp = (String[])list.toArray(new String[size]);
//			System.out.println("temp====="+temp);
//		}
//		
	}

}
