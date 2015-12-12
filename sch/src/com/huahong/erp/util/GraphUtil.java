package com.huahong.erp.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.GradientPaint;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.AxisLocation;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PiePlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.CategoryDataset;
import org.jfree.chart.renderer.category.LayeredBarRenderer;
import org.jfree.chart.servlet.ChartDeleter;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.util.SortOrder;

import com.neusoft.util.StringUtils;

public class GraphUtil {
	private static String graphPath="";
	private static String partitionName="";

	public static String getGraphPath() {
		return graphPath;
	}
	public static void setGraphPath(String graphPath) {
		GraphUtil.graphPath = graphPath;
	}
	
	/**
	 * 生成饼图
	 * 
	 * @param dir
	 * @param days
	 * @param date
	 * @return boolean
	 * @throws IOException
	 */
	public static String generatePic(DefaultPieDataset dataset,String title,int width, int height,
			HttpServletRequest request){
		JFreeChart chart = ChartFactory.createPieChart3D(title, dataset, true, true, false);
		setImpProperties(chart);
		PiePlot plot = (PiePlot) chart.getPlot();
		plot.setSectionOutlinesVisible(false);
        plot.setLabelFont(new Font("SansSerif", Font.PLAIN, 12));
        plot.setNoDataMessage("未查询到数据！");
        plot.setCircular(false);
        plot.setLabelGap(0.02);
	    String filename="";
	    try{
	    	filename = saveChartAsJPEG(chart, width, height,request.getSession());
	    }catch(Exception e){
	    	e.printStackTrace();
	    }
		return filename;
	
	}
	
	/**
	 * 生成组柱图
	 * 
	 * @param categorydataset
	 * @param width
	 * @param height
	 * @param yName
	 * @param color  
	 * @return String
	 * @throws Exception
	 */
	public static String LayeredBarChart(CategoryDataset categorydataset,int width,int height,
			HttpServletRequest request,String yName,Color color){
		JFreeChart localJFreeChart = ChartFactory.createBarChart("", "", yName, categorydataset, PlotOrientation.VERTICAL, true, true, false);
	    CategoryPlot localCategoryPlot = (CategoryPlot)localJFreeChart.getPlot();
	    localCategoryPlot.setBackgroundPaint(color);
	    localCategoryPlot.setDomainAxisLocation(AxisLocation.BOTTOM_OR_LEFT);
	    localCategoryPlot.setWeight(12);
	    localCategoryPlot.setRangeAxisLocation(AxisLocation.TOP_OR_LEFT);
	    
	    localCategoryPlot.setDomainGridlinesVisible(true);
//	    localCategoryPlot.setRangePannable(true);
//	    localCategoryPlot.setRangeZeroBaselineVisible(true);
	    
	    NumberAxis localNumberAxis = (NumberAxis)localCategoryPlot.getRangeAxis();
	    localNumberAxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
	    LayeredBarRenderer localLayeredBarRenderer = new LayeredBarRenderer();
	    localLayeredBarRenderer.setDrawBarOutline(false);
	    localLayeredBarRenderer.setBaseItemLabelsVisible(true);
	    localLayeredBarRenderer.setMaximumBarWidth(0.1D);
	    
	    localCategoryPlot.setRenderer(localLayeredBarRenderer);
	    localCategoryPlot.setRowRenderingOrder(SortOrder.DESCENDING);
	    GradientPaint localGradientPaint1 = new GradientPaint(0.0F, 0.0F, Color.blue, 0.0F, 0.0F, new Color(0, 0, 64));
	    GradientPaint localGradientPaint2 = new GradientPaint(0.0F, 0.0F, Color.green, 0.0F, 0.0F, new Color(0, 64, 0));
	    GradientPaint localGradientPaint3 = new GradientPaint(0.0F, 0.0F, Color.red, 0.0F, 0.0F, new Color(64, 0, 0));
	    GradientPaint localGradientPaint4 = new GradientPaint(0.0F, 0.0F, Color.yellow, 0.0F, 0.0F, new Color(64, 64, 0));
	    localLayeredBarRenderer.setSeriesPaint(0, localGradientPaint1);
	    localLayeredBarRenderer.setSeriesPaint(1, localGradientPaint2);
	    localLayeredBarRenderer.setSeriesPaint(2, localGradientPaint3);
	    localLayeredBarRenderer.setSeriesPaint(3, localGradientPaint4);
		String filename="";
	    try{
	    	filename = saveChartAsJPEG(localJFreeChart, width, height,request.getSession());
	    }catch(Exception e){
	    	e.printStackTrace();
	    }
		return filename;
	}
	
	/**
	 * 设置jfreechart饼图背景色
	 * 
	 * @param chart
	 */
	private static void setImpProperties(JFreeChart chart){
		int red = 222;
		int green = 242;
		int blue = 246;
		Color color = new Color(red, green, blue);
		chart.setBackgroundPaint(color);
	}
	
	/**
	 * 保存jfreeChart图
	 * 
	 * @param chart
	 * @param width
	 * @param height
	 * @param session
	 * @return String 图片路径
	 */
	public static String saveChartAsJPEG(JFreeChart chart,int width,int height,HttpSession session){
		try{
			if(chart == null)
	            throw new IllegalArgumentException("Null 'chart' argument.");
	        String prefix = "jfreechart-";
	        if(session == null)
	            prefix = "jfreechart-oneTime";
	        File tempFile = File.createTempFile(prefix, ".jpeg", new File(graphPath));
	        ChartUtilities.saveChartAsJPEG(tempFile, chart, width, height, null);
	        
	        if(session != null)
	        {
	            ChartDeleter chartDeleter = (ChartDeleter)session.getAttribute("JFreeChart_Deleter");
	            if(chartDeleter == null)
	            {
	                chartDeleter = new ChartDeleter();
	                session.setAttribute("JFreeChart_Deleter", chartDeleter);
	            }
	            chartDeleter.addChart(tempFile.getName());
	        } else
	        {
	            System.out.println("Session is null - chart will not be deleted");
	        }
	        return tempFile.getName();
		}catch(Exception e){
			e.printStackTrace();
		}
        return null;
		
	}
	
	/**
	 * }����ĳ�����
	 * @param main
	 * @param sub
	 * @param scale
	 * @return
	 */
	public static double divide(double main, double sub, int scale){
		if(scale < 0)
			return 0;
		try{
			BigDecimal b_main = new BigDecimal(main);
			BigDecimal b_sub = new BigDecimal(sub);
			return b_main.divide(b_sub, scale, BigDecimal.ROUND_HALF_UP).doubleValue();
			
		}catch(Exception e){
			return -1;
		}
	}
	
	/**
	 * �˷�����
	 * @param main
	 * @param sub
	 * @return
	 */
	public static double multiply(double main, double sub){
		try{
			BigDecimal b_main = new BigDecimal(main);
			BigDecimal b_sub = new BigDecimal(sub);
			double d_result = b_main.multiply(b_sub).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			b_sub = null;
			b_main = null;
			return d_result;
			
		}catch(Exception e){
			return -1;
		}
	}
	
	public static void main(String[] args) {
		DefaultPieDataset dataset = new DefaultPieDataset();
		try{

			int pic1 = 10;//Integer.parseInt((String)map.get("pic1"));
			int pic2 = 20;
			int pic3 = 55;
			int total = pic1 + pic2 + pic3;
			if(total < 1){
				total = 1;
			}
			dataset.setValue("第一个pic" + multiply(divide(pic1, total, 2), 100) + "%", pic1);
			dataset.setValue("��ݿ�第二个pic" + multiply(divide(pic2, total, 2), 100) + "%", pic2);
			dataset.setValue("�����第三个pic" + multiply(divide(pic3, total, 2), 100) + "%", pic3);
		}catch(Exception e){
			e.printStackTrace();
		}
		//generatePic("统计图", dataset,300,300, response);
		String result = GraphUtil.generatePic(dataset,"统计图", 300,300, null);
		System.out.println("picture===="+result);
	}
}
