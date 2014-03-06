package com.alian.mytxl;


import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class XmlHandler extends DefaultHandler {
	
	private String _name = null, _phone = null,_location = null,_weibo=null,_qq=null;
	private int _flag = 0; 
	
	private String _str = "";	
	public String getString() {
		return _str;
	}

	@Override
	
	public void startDocument() throws SAXException {
	   	super.startDocument();
	}
		
	@Override
	
	public void startElement(String uri, String localName, String name, Attributes attributes) throws SAXException {		
	   	if(localName.equalsIgnoreCase("name"))
	   	{
	   		_flag = 1;
	   	}
	   	else if(localName.equalsIgnoreCase("phone"))
	   		_flag = 2;
	   	else if(localName.equalsIgnoreCase("location"))
	   		_flag = 3;
	   	else if(localName.equalsIgnoreCase("weibo"))
	   		_flag = 4;
	   	else if(localName.equalsIgnoreCase("qq"))
	   		_flag = 5;
	}  
    
	@Override
	
	public void characters(char[] ch, int start, int length) throws SAXException {
		String tmp = new String(ch, start, length);
		if(_flag == 1)		_name = tmp;
		else if(_flag == 2)		_phone = tmp;
		else if(_flag == 3)		_location = tmp;
		else if(_flag == 4)		_weibo = tmp;
		else if(_flag == 5)		_qq = tmp;
		_flag = 0;
		super.characters(ch, start, length);
	}  
	      
	@Override
	
	public void endElement(String uri, String localName, String name) 
	   		throws SAXException {
		if(localName.equalsIgnoreCase("data"))
		{
			this._str +=" <li ><a href='#people'><img src='images/photo_2.png' class='photo'>";
			this._str +="<div class='text_wrapper'><h4>"+this._name+"</h4></div></a>";
			this._str +="<ul><li class='name'>"+this._name+"</li>";
			this._str +="<li class='phone'>"+this._phone+"</li>";
			this._str +="<li class='location'>"+this._location+"</li>";
			this._str +="<li class='qq'>"+this._qq+"</li>";
			this._str +="<li class='weibo'>"+this._weibo+"</li> </ul></li> ";
		}
	   	super.endElement(uri, localName, name);
	} 
	
	@Override
	
	public void endDocument() throws SAXException {
		super.endDocument();
	}
}
