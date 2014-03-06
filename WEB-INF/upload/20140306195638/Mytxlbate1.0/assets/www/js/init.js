// JavaScript Document
 if (!((window.DocumentTouch && document instanceof DocumentTouch) || 'ontouchstart' in window)) {
        var script = document.createElement("script");
        script.src = "plugins/af.desktopBrowsers.js";
        var tag = $("head").append(script);
  }
 var webRoot = "./";
        $.ui.autoLaunch = false; //By default, it is set to true and you're app will run right away.  We set it to false to show a splashscreen
        /* This function runs when the body is loaded.*/
        var init = function () {
                $.ui.backButtonText = "Back";// We override the back button text to always say "Back"
                window.setTimeout(function () {
                    $.ui.launch();
                }, 1500);//We wait 1.5 seconds to call $.ui.launch after DOMContentLoaded fires
        };
        document.addEventListener("DOMContentLoaded", init, false);
        $.ui.ready(function () {
            //This function will get executed when $.ui.launch has completed
			
        });
 
 
        /* This code is used for native apps */
        var onDeviceReady = function () {
                AppMobi.device.setRotateOrientation("portrait");
                AppMobi.device.setAutoRotate(false);
                webRoot = AppMobi.webRoot + "/";
                //hide splash screen
                AppMobi.device.hideSplashScreen();
 
        };
        document.addEventListener("appMobi.device.ready", onDeviceReady, false);
	
		$(function(){

			//设置头部高度
			 window.onload=function(){ 
				var width=$("body").width();
				//$("body").width();
				//alert(width);
				if(width!=0){
				$('#head_wrapper').height(parseInt(width/1.44));
				}
	
			} 
			
			//加载联系人数据
			$('#main .list').append(window.SM.readXml());
			
			//获取点击的联系人信息
			document.on('click','#main .list li',function(){
				var name=$(this).find('ul .name').html();
				var phone=$(this).find('ul .phone').html();
				var location=$(this).find('ul .location').html();
				var qq=$(this).find('ul .qq').html();
				var weibo=$(this).find('ul .weibo').html();
				
				$('#people .list').find('span.name').html(name);
				$('#people .list').find('span.phone').html(phone);
				$('#people .list').find('span.location').html(location);
				$('#people .list').find('span.chat').html(qq);
				$('#people .list').find('span.weibo').html(weibo);
				
				$('#people .bt_g').find('.call').attr('href','tel:+86'+phone);
				$('#people .bt_g').find('.msg').attr('href','sms:+86'+phone);
					
			});
						
			//等待phonegap 加载完成
			 document.addEventListener('deviceready',onDeviceReady,false);
			//保存联系人
			 function onDeviceReady() {  
					
				var onSuccess=function(contacts) { 
					$.ui.hideMask() 
					alert('保存成功');
				}
					
				var onError=function(contactError) {  
							
					$.ui.hideMask();
					alert("保存失败，联系人可能已经存在");
				}
					
				$('#people  .save').on('click',function(){
							
					$.ui.showMask();
	
					var contact = navigator.contacts.create();
					contact.displayName=$('#people .list').find('span.name').text();
							
					var name = new ContactName();
					name.familyName =$('#people .list').find('span.name').text();
					contact.name=name;
							
					var phoneNumbers = [];
					phoneNumbers[0] = new ContactField('mobile',$('#people .list').find('span.phone').text(), true);
					contact.phoneNumbers = phoneNumbers;	
							
					var address =[];
					address[0]=new ContactAddress(false,'formatted',$('#people .list').find('span.location').text());
					contact.addresses=address;
							
					var organization=new ContactOrganization();
					organization.name=$('#people .list').find('span.location').text();
					contact.organizations=organization;
							
					var urls = [];
					urls[0] = new ContactField('weibo', $('#people .list').find('span.weibo').text(), false);
					contact.urls=urls;
							
					var ims = [];
					ims[0] = new ContactField('qq',$('#people .list').find('span.chat').text(), false);
					contact.ims=ims;
							 
					contact.save(onSuccess,onError);  
					});
					
				 // 注册回退按钮事件监听器
					document.addEventListener("backbutton", onBackKeyDown, false); //返回键	
			}
			
			//设置返回按键
			function onConfirm(button) {
				if(button==1) navigator.app.exitApp();//选择了确定才执行退出
			 }  
			 
			function onBackKeyDown() {
				if($($.ui.activeDiv).attr("id")=="main" ){ 			
					if($('#search_box').is(':focus')){
						$('#search_box').blur();
					}else{
							navigator.notification.confirm(
							'按确定退出程序!',  // message
							 onConfirm,              // callback to invoke with index of button pressed
							 '确定要退出程序吗??',            // title
							 '确定,取消'          // buttonLabels
							);
					}
				} else { 
						navigator.app.backHistory();
				} 
			
			}
			
			//搜索框隐藏
			$('#search_box').on('focus',function(){
					
				$("#head_wrapper").hide();
				//document.removeEventListener("backbutton", onBackKeyDown, false);
				//document.addEventListener("backbutton", function(e){}, false);
			
			});
			$('#search_box').on('blur',function(e) {
				
				$("#head_wrapper").show();	   
				//document.addEventListener("backbutton", onBackKeyDown, false);
			
			});
				
			//搜索
			$('#search_box').keyup(function(){
			
				var searchval=$('#search_box').val();
			
				var list=$('#main .text_wrapper h4');
				
				$('#main .list li').hide();
			
				for(var i=0;i<list.length;i++){
					
					if(list.get(i).innerHTML.indexOf(searchval)>=0){
							
							$('#list>li').get(i).style.display="";
							//alert($('#main .list li:eq('+i+')').html());
					}
				}
				
			});
		});