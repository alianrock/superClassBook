package com.alian.mytxl;

//import android.app.Activity;


import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import android.content.ContentValues;
import android.content.Intent;

import android.net.Uri;
import android.provider.ContactsContract.CommonDataKinds.Im;
import android.provider.ContactsContract.Data;
import android.webkit.WebView;
import org.apache.cordova.DroidGap;

//import android.widget.Toast;

public class PluginMethod  {
    private WebView webView;
    private DroidGap droidGap;

    public PluginMethod(DroidGap gap, WebView view) {
        webView = view;
        droidGap = gap;
    }

    
    
    public String readXml() throws IOException {  
    	String str = null;  
    	InputStream abpath = getClass().getResourceAsStream("/assets/data.xml");
    	
    		 SAXParserFactory factory = SAXParserFactory.newInstance();  
    		 try {  
    			 SAXParser sp = factory.newSAXParser();  
    			 XmlHandler handler = new XmlHandler();  
    			 sp.parse(abpath, handler);  
    			 str = handler.getString();  
    		 } catch(Exception e) {  
    			 e.printStackTrace();  
    		 
    	 }
    	 return str;  
    }
    
 
	
	

}