package com.huahong.util;


import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;


public class ExcelUtil {
	
	public HSSFWorkbook ToExcel(List<HashMap<String,String>> list,String sheetName)
	{
		HSSFWorkbook book = new HSSFWorkbook();
		AddSheet(book,list,sheetName);
		return book;
	}
	
	public HSSFWorkbook  AddSheet(HSSFWorkbook book,List<HashMap<String, String>> list , String sheetName)
	{
		if(book==null) book = new HSSFWorkbook();
		HSSFSheet sheet = book.createSheet(sheetName);
		for(int i=0;i<list.size();i++)
		{
			HashMap<String,String> map = list.get(i);
			Set<String> keys = map.keySet();
			AddHeader(sheet, keys);
            AddRow(sheet,map);
			
		}
		return book;
		
	}
	
	
	public HSSFSheet AddRow(HSSFSheet sheet, HashMap<String, String> map) 
	{
		
		int rowsnum = sheet.getLastRowNum();
		HSSFRow row = sheet.createRow(++rowsnum);
		Collection<String> values = map.values();
		Iterator<String> ator = values.iterator();
		int i = values.size()-1;

		while(ator.hasNext())
		{
			HSSFCell cell =row.createCell((short) i--);
			cell.setCellValue((String)ator.next());
		}
	
		
		return sheet;
	}

	public HSSFSheet AddHeader(HSSFSheet sheet,Set<String> keys)
	{
		HSSFRow row =sheet.createRow(0);
		Iterator<String> ator =keys.iterator();
		int i=keys.size()-1;
	
		while(ator.hasNext()){
			HSSFCell cell =row.createCell((short) i--);
			row.createCell((short) 9);
			cell.setCellValue((String)ator.next());
		}
		
		return sheet;
		
	}
	
	public HSSFSheet AddHeader(HSSFSheet sheet,HashMap<String, String> headermap)
	{
		
		HSSFRow row = sheet.createRow(0);
		Collection<String> values = headermap.values();
		Iterator<String> ator = values.iterator();
		int i = values.size()-1;

		while(ator.hasNext())
		{
			HSSFCell cell =row.createCell((short) i--);
			cell.setCellValue((String)ator.next());
		}
	
		
		return sheet;
		
	}
	
	public HSSFSheet AddHeader(HSSFSheet sheet,String[] headers)
	{
		HSSFRow row = sheet.createRow(0);
		for(int i=0;i<headers.length;i++)
		{
			HSSFCell cell=row.createCell((short) i);
			cell.setCellValue(headers[i]);
		}
		
		return sheet;
	}
	
	public HashMap<String,List<HashMap<String, String>>> ToList(HSSFWorkbook book)
	{
		HashMap<String,List<HashMap<String, String>>> list = new HashMap<String,List<HashMap<String, String>>>();
		int sheetsnum = book.getNumberOfSheets();
		for(int i=0;i<sheetsnum;i++)
		{
			list.put(book.getSheetName(i), ReadSheet(book.getSheet(book.getSheetName(i))));
		}
		
		return list;
	}
	
	public List<HashMap<String, String>> ReadSheet(HSSFSheet sheet)
	{
		List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		int rowsnum = sheet.getLastRowNum();
		for(int i=1;i<=rowsnum;i++)
		{
			list.add(ReadRow(ReadHeader(sheet), sheet.getRow(i)));
		}
		return list;
	}
	
	public Set<String> ReadHeader(HSSFSheet sheet)
	{
		Set<String> keys = new HashSet<String>();
		HSSFRow row = sheet.getRow(0);
		int sellsnum = row.getLastCellNum()-1;
		for(int i=0;i<=sellsnum;i++)
		{
			HSSFCell cell =row.getCell((short) i);
			keys.add(cell.getStringCellValue());
		}
		return keys;
	}
	
	
	public void SetReadHeadermap(HashMap<String, String> headermap)
	{
		
	}
	
	public HashMap<String, String> ReadRow(Set<String> keys,HSSFRow row)
	{
		String[] keylist= keys.toArray(new String[0]);
		HashMap<String, String> readmap = new HashMap<String, String>();
		int sellsnum =row.getLastCellNum()-1;
			for(int j =0;j<=sellsnum;j++)
			{
				HSSFCell cell =row.getCell((short) j);
				readmap.put(keylist[sellsnum-j], cell.getStringCellValue());
			}
		return readmap;
	}
	
	public void SaveExcel(HSSFWorkbook book,String Path,String filename) throws IOException
	{
		FileOutputStream fileOut;
		fileOut = new FileOutputStream(Path + filename + ".xls");
		book.write(fileOut);
		fileOut.close();
	}
	
	public HSSFWorkbook CreateExcelFromFile(String filepath) throws IOException
	{
		InputStream inp;
		HSSFWorkbook book = null;
		inp = new FileInputStream(filepath);
		book = new HSSFWorkbook(new POIFSFileSystem(inp));
		return book;

	}
	
	public HSSFSheet GetSheet(HSSFWorkbook book,String key)
	{
		return book.getSheet(key);
	}
	
	public HSSFSheet GetSheet(HSSFWorkbook book,int index)
	{
		return book.getSheetAt(index);
	}
	
	
	
	
}
