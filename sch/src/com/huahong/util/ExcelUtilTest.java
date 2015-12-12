package com.huahong.util;

import junit.framework.TestCase;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;


public class ExcelUtilTest extends TestCase {

	public void testToExcel() {
		ExcelUtil excelUtil = new ExcelUtil();
		HashMap<String,String> map1 = new HashMap<String,String>();
		map1.put("ID", "1");
		map1.put("UserName", "laotie");
		map1.put("PassWord", "123456");
		HashMap<String,String> map2 = new HashMap<String,String>();
		map2.put("ID", "2");
		map2.put("UserName", "shiyu");
		map2.put("PassWord", "123456");
		
		List<HashMap<String,String>> list = new ArrayList<HashMap<String, String>>();
		list.add(map1);
		list.add(map2);
		
		HSSFWorkbook book = new HSSFWorkbook();
		excelUtil.AddSheet(book, list, "Test");
        HSSFSheet sheet = book.getSheet("Test");
		
		assertEquals(2,sheet.getLastRowNum());
		
		assertEquals("ID", sheet.getRow(0).getCell((short)0).getStringCellValue());
		assertEquals("UserName", sheet.getRow(0).getCell((short)1).getStringCellValue());
		assertEquals("PassWord", sheet.getRow(0).getCell((short)2).getStringCellValue());
		
		assertEquals("1", sheet.getRow(1).getCell((short)0).getStringCellValue());
		assertEquals("laotie", sheet.getRow(1).getCell((short)1).getStringCellValue());
		assertEquals("123456", sheet.getRow(1).getCell((short)2).getStringCellValue());
		
		assertEquals("2", sheet.getRow(2).getCell((short)0).getStringCellValue());
		assertEquals("shiyu", sheet.getRow(2).getCell((short)1).getStringCellValue());
		assertEquals("123456", sheet.getRow(2).getCell((short)2).getStringCellValue());
		
		//excelUtil.SaveExcel(book, "C:", "test1");
	}

	public void testAddSheet() {
		ExcelUtil excelUtil = new ExcelUtil();
		HashMap<String,String> map1 = new HashMap<String,String>();
		map1.put("ID", "1");
		map1.put("UserName", "laotie");
		map1.put("PassWord", "123456");
		HashMap<String,String> map2 = new HashMap<String,String>();
		map2.put("ID", "2");
		map2.put("UserName", "shiyu");
		map2.put("PassWord", "123456");
		
		List<HashMap<String,String>> list = new ArrayList<HashMap<String, String>>();
		list.add(map1);
		list.add(map2);
		
		HSSFWorkbook book = new HSSFWorkbook();
		excelUtil.AddSheet(book, list, "Test1");
		excelUtil.AddSheet(book, list, "Test2");
        HSSFSheet sheet1 = book.getSheet("Test1");
        HSSFSheet sheet2 = book.getSheet("Test2");
		assertEquals(2,sheet1.getLastRowNum());
		
		assertEquals("ID", sheet1.getRow(0).getCell((short)0).getStringCellValue());
		assertEquals("UserName", sheet1.getRow(0).getCell((short)1).getStringCellValue());
		assertEquals("PassWord", sheet1.getRow(0).getCell((short)2).getStringCellValue());
		
		assertEquals("1", sheet1.getRow(1).getCell((short)0).getStringCellValue());
		assertEquals("laotie", sheet1.getRow(1).getCell((short)1).getStringCellValue());
		assertEquals("123456", sheet1.getRow(1).getCell((short)2).getStringCellValue());
		
		assertEquals("2", sheet1.getRow(2).getCell((short)0).getStringCellValue());
		assertEquals("shiyu", sheet1.getRow(2).getCell((short)1).getStringCellValue());
		assertEquals("123456", sheet1.getRow(2).getCell((short)2).getStringCellValue());
		
		
		assertEquals(2,sheet2.getLastRowNum());
		
		assertEquals("ID", sheet2.getRow(0).getCell((short)0).getStringCellValue());
		assertEquals("UserName", sheet2.getRow(0).getCell((short)1).getStringCellValue());
		assertEquals("PassWord", sheet2.getRow(0).getCell((short)2).getStringCellValue());
		
		assertEquals("1", sheet2.getRow(1).getCell((short)0).getStringCellValue());
		assertEquals("laotie", sheet2.getRow(1).getCell((short)1).getStringCellValue());
		assertEquals("123456", sheet2.getRow(1).getCell((short)2).getStringCellValue());
		
		assertEquals("2", sheet2.getRow(2).getCell((short)0).getStringCellValue());
		assertEquals("shiyu", sheet2.getRow(2).getCell((short)1).getStringCellValue());
		assertEquals("123456", sheet2.getRow(2).getCell((short)2).getStringCellValue());
		//excelUtil.SaveExcel(book, "C:/", "test2");
	}
	
	
	public void testAddHeader()	{
		HSSFWorkbook book = new HSSFWorkbook();
		HSSFSheet sheet = book.createSheet("Test");
		ExcelUtil excelUtil = new ExcelUtil();
		Set<String> keys =null;
		
		HashMap<String,String> map1 = new HashMap<String,String>();
		map1.put("ID", "1");
		map1.put("UserName", "laotie");
		map1.put("PassWord", "123456");
		
		keys = map1.keySet();
		
		excelUtil.AddHeader(sheet, keys);
		
		assertEquals(0, sheet.getLastRowNum());
		assertEquals(2, sheet.getRow(0).getLastCellNum());
		
		assertEquals("ID", sheet.getRow(0).getCell((short)0).getStringCellValue());
		assertEquals("UserName", sheet.getRow(0).getCell((short)1).getStringCellValue());
		assertEquals("PassWord", sheet.getRow(0).getCell((short)2).getStringCellValue());
		
	}
	
	
	public void testAddRow()
	{
		ExcelUtil excelUtil = new ExcelUtil();
		HSSFWorkbook book = new HSSFWorkbook();
		HSSFSheet sheet = book.createSheet("Test");
		HashMap<String,String> map1 = new HashMap<String,String>();
		map1.put("ID", "1");
		map1.put("UserName", "laotie");
		map1.put("PassWord", "123456");
		excelUtil.AddHeader(sheet, map1.keySet());
		excelUtil.AddRow(sheet, map1);
		
		assertEquals("ID", sheet.getRow(0).getCell((short)0).getStringCellValue());
		assertEquals("UserName", sheet.getRow(0).getCell((short)1).getStringCellValue());
		assertEquals("PassWord", sheet.getRow(0).getCell((short)2).getStringCellValue());
		
		assertEquals(1, sheet.getLastRowNum());
		
		assertEquals("1", sheet.getRow(1).getCell((short)0).getStringCellValue());
		assertEquals("laotie", sheet.getRow(1).getCell((short)1).getStringCellValue());
		assertEquals("123456", sheet.getRow(1).getCell((short)2).getStringCellValue());
		
	}
	
	
	public void testReadHeader()
	{
		HSSFWorkbook book = new HSSFWorkbook();
		HSSFSheet sheet = book.createSheet("Test");
		ExcelUtil excelUtil = new ExcelUtil();
		Set<String> keys =null;
		
		HashMap<String,String> map1 = new HashMap<String,String>();
		map1.put("ID", "1");
		map1.put("UserName", "laotie");
		map1.put("PassWord", "123456");
		
		keys = map1.keySet();
		
		excelUtil.AddHeader(sheet, keys);
		
		assertEquals(0, sheet.getLastRowNum());
		assertEquals(2, sheet.getRow(0).getLastCellNum());
		
		assertEquals("ID", sheet.getRow(0).getCell((short)0).getStringCellValue());
		assertEquals("UserName", sheet.getRow(0).getCell((short)1).getStringCellValue());
		assertEquals("PassWord", sheet.getRow(0).getCell((short)2).getStringCellValue());
		
		
		Set<String> header = excelUtil.ReadHeader(sheet);
		
		assertEquals(keys,header);
		
	}
	
	public void testReadRow()
	{
		HSSFWorkbook book = new HSSFWorkbook();
		HSSFSheet sheet = book.createSheet("Test");
		ExcelUtil excelUtil = new ExcelUtil();
		Set<String> keys =null;
		
		HashMap<String,String> map1 = new HashMap<String,String>();
		map1.put("ID", "1");
		map1.put("UserName", "laotie");
		map1.put("PassWord", "123456");
		
		keys = map1.keySet();
		
		excelUtil.AddHeader(sheet, keys);
		excelUtil.AddRow(sheet, map1);
		assertEquals(1, sheet.getLastRowNum());
		assertEquals(2, sheet.getRow(0).getLastCellNum());
		
		assertEquals("ID", sheet.getRow(0).getCell((short)0).getStringCellValue());
		assertEquals("UserName", sheet.getRow(0).getCell((short)1).getStringCellValue());
		assertEquals("PassWord", sheet.getRow(0).getCell((short)2).getStringCellValue());
		
		
		Set<String> header = excelUtil.ReadHeader(sheet);
		
		assertEquals(keys,header);
		
		HashMap<String, String> readmap = excelUtil.ReadRow(keys,sheet.getRow(1));
		
		assertEquals(map1, readmap);
	}
	
	public void testReadSheet() throws IOException
	{

		ExcelUtil excelUtil = new ExcelUtil();
		HashMap<String,String> map1 = new HashMap<String,String>();
		map1.put("编号", "1");
		map1.put("UserName", "老铁");
		map1.put("PassWord", "123456");
		HashMap<String,String> map2 = new HashMap<String,String>();
		map2.put("编号", "2");
		map2.put("UserName", "shiyu");
		map2.put("PassWord", "123456");
		
		List<HashMap<String,String>> list = new ArrayList<HashMap<String, String>>();
		list.add(map1);
		list.add(map2);
		HSSFWorkbook book = new HSSFWorkbook();
		
		excelUtil.AddSheet(book, list, "Test1");
		excelUtil.AddSheet(book, list, "Test2");
        HSSFSheet sheet1 = book.getSheet("Test1");
        HSSFSheet sheet2 = book.getSheet("Test2");
		/*assertEquals(2,sheet1.getLastRowNum());
		
		assertEquals("编号", sheet1.getRow(0).getCell((short)0).getStringCellValue());
		assertEquals("UserName", sheet1.getRow(0).getCell((short)1).getStringCellValue());
		assertEquals("PassWord", sheet1.getRow(0).getCell((short)2).getStringCellValue());
		
		assertEquals("1", sheet1.getRow(1).getCell((short)0).getStringCellValue());
		assertEquals("老铁", sheet1.getRow(1).getCell((short)1).getStringCellValue());
		assertEquals("123456", sheet1.getRow(1).getCell((short)2).getStringCellValue());
		
		assertEquals("2", sheet1.getRow(2).getCell((short)0).getStringCellValue());
		assertEquals("shiyu", sheet1.getRow(2).getCell((short)1).getStringCellValue());
		assertEquals("123456", sheet1.getRow(2).getCell((short)2).getStringCellValue());
		
		
		assertEquals(2,sheet2.getLastRowNum());
		
		assertEquals("编号", sheet2.getRow(0).getCell((short)0).getStringCellValue());
		assertEquals("UserName", sheet2.getRow(0).getCell((short)1).getStringCellValue());
		assertEquals("PassWord", sheet2.getRow(0).getCell((short)2).getStringCellValue());
		
		assertEquals("1", sheet2.getRow(1).getCell((short)0).getStringCellValue());
		assertEquals("老铁", sheet2.getRow(1).getCell((short)1).getStringCellValue());
		assertEquals("123456", sheet2.getRow(1).getCell((short)2).getStringCellValue());
		
		assertEquals("2", sheet2.getRow(2).getCell((short)0).getStringCellValue());
		assertEquals("shiyu", sheet2.getRow(2).getCell((short)1).getStringCellValue());
		assertEquals("123456", sheet2.getRow(2).getCell((short)2).getStringCellValue());
		
		List<HashMap<String, String>> readlist1= excelUtil.ReadSheet(sheet1);
		List<HashMap<String, String>> readlist2= excelUtil.ReadSheet(sheet2);
		
		assertEquals(list, readlist1);
		assertEquals(list, readlist2); */
		excelUtil.SaveExcel(book, "C:/", "test1");
	}
	
	public void testToList()
	{
		HashMap<String,List<HashMap<String, String>>> booklist = new HashMap<String,List<HashMap<String, String>>>();
		ExcelUtil excelUtil = new ExcelUtil();
		HashMap<String,String> map1 = new HashMap<String,String>();
		map1.put("编号", "1");
		map1.put("UserName", "老铁");
		map1.put("PassWord", "123456");
		HashMap<String,String> map2 = new HashMap<String,String>();
		map2.put("编号", "2");
		map2.put("UserName", "shiyu");
		map2.put("PassWord", "123456");
		
		List<HashMap<String,String>> list = new ArrayList<HashMap<String, String>>();
		list.add(map1);
		list.add(map2);
		
		booklist.put("Test1", list);
		booklist.put("Test2", list);
		InputStream inp;
		HSSFWorkbook book = null;
		try {
			inp = new FileInputStream("C:/test1.xls");
			book = new HSSFWorkbook(new POIFSFileSystem(inp));
		} catch (FileNotFoundException e) {
			
			e.printStackTrace();
		}
		 catch (IOException e) {
			
			e.printStackTrace();
		}

		
		HashMap<String,List<HashMap<String, String>>> readbooklist = excelUtil.ToList(book);
		
		
		assertEquals(booklist, readbooklist);
		
	}

}
