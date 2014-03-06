package com.alian.mytxl;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.view.Window;
import android.view.WindowManager;

import org.apache.cordova.*;

public class MainActivity extends DroidGap {

	@SuppressLint("SetJavaScriptEnabled")
	@Override
	public void onCreate(Bundle savedInstanceState) {
		
		super.onCreate(savedInstanceState);

		this.setFullscreen();
		super.init();
		appView.getSettings().setJavaScriptEnabled(true);
	    appView.addJavascriptInterface(new PluginMethod(this, appView), "SM"); 
	    super.setIntegerProperty("splashscreen", R.drawable.bg);
		super.loadUrl("file:///android_asset/www/index.html",4000);
	}
	
	public void setFullscreen() {  
		getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FORCE_NOT_FULLSCREEN);
	    requestWindowFeature(Window.FEATURE_NO_TITLE);  
	    getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,  
	    WindowManager.LayoutParams.FLAG_FULLSCREEN);  
	} 
	/*@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}*/

}
