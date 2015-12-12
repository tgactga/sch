package com.huahong.erp.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import nl.justobjects.pushlet.core.Dispatcher;
import nl.justobjects.pushlet.core.Event;

public class send {

	public static String MSG_TYPE = "";

	public static String MSG_TEXT_TYPE = "";

	public static String MSG_TITLE = "";

	public static String MSG_URL = "";

	public static String MSG_ACCEPT_ID = "";

	public static String CHECK_TAG = "";

	public static java.util.Date MSG_TIME = null;

	public static String MSG_REGISTER = "";

	public static String OBJECT_NAME = "";

	public static String OBJECT_ID = "";

	protected static Object serialRealtime = new Object();

	public static void pushAlarm(HashMap map, String operType) {
		map.put("operType", operType);
		Event event = Event.createDataEvent("/alarm", map);
//		 System.out.println("event="+event);
		Dispatcher d = Dispatcher.getInstance();
		d.multicast(event);
	}

}
