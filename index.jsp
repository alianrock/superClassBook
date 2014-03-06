<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <base href="<%=basePath%>"></base>
        <title>超级同学录</title>
 		<!--装载文件-->
 		<link rel="stylesheet" href="css/style.css" />
        <link href="css/uploadify.css" rel="stylesheet" type="text/css" />
     	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
		<script src="js/jquery.uploadify.js" type="text/javascript"></script>

   <!--ready事件-->
<script type="text/javascript">
       $(document).ready(  
            function() {   
            	$('.loading').hide();
            	$('.down').hide();   
  
                $("#uploadify").uploadify( {//初始化函数  
                'swf'      : 'uploadify.swf',  
                'auto'     : true,//true为自动上传  
                'uploader' : 'Upload',  
                'width'	   :'155',
                'height'   :'60',
                'multi' : false,  
                'buttonText' : '',
                'fileTypeExts':'*.xls;*.xlsx',
                'fileSizeLimit':'1MB',  
                'simUploadLimit' : 8  ,
                 'onUploadStart' : function(file) {
            		$('.down').hide();   
          	  		$('.loading').show(1000);
          	  		 $('.loading span').html("上传中...");
        		 },
                 'onUploadSuccess' : function(file, data, response) {
         		 	//alert('The file ' + file.name + ' was successfully uploaded with a response of ' + response + ':' + data);
	         		 if(response){
	         		 	 $('#uploadify').uploadify('disable', true);
		         		 $('.loading span').html("转换中...");
		         		 $.ajax({
						  type:"post",//请求方式
						  url:"CreateXmlServlet",//发送请求地址
						  data: "savepath="+data,
						  success:function(data,textStatus){	
						     $.ajax({
						  		type:"post",//请求方式
						  		url:"RunServlet",//发送请求地址
						  		data: "savepath="+data,
						  		success:function(data,textStatus){
						  			if(data==-1){
						  				$('.loading span').html("失败了TT，用户过多请稍后再试！");
						  				$('#uploadify').uploadify('disable', false);
						  				
						  			}else{
						  				$('.down').show(1000); 
						  				$('.loading span').html("成功了！");
						  				$(".fliefolder").attr('value',data);
						  				$('#uploadify').uploadify('disable', false);
						  			}
						  		 	
						  		 }		
							 });
						   }
						 });
					}else{
						$('.loading span').html("上传失败！");
					}
        		}
            });  
            
            $('.down_i').click(function(){
        			 
						  		
					
					
        	});
  
        });   
        </script>   
 </head>
    <body>
	<div id="head_wrapper">
		<!-- 导航 -->
		<div id="nav">
			<div class="nav_c">
				<a href="#" class="logo">
				<span class="name">超级同学录</span> 
				<!-- <span class="name_e">Supper Class Book</span> -->
				</a>

				<div class="nav">
					<!-- <a href="#">首页</a>
					<a href="#">关于</a> -->
				</div>
			</div>
		</div>
		<!-- banner -->
		<div id="m-wrap" class="clearfix">
			<div class="content">
				<h1>超级同学录</h1>
				<h2>让沟通跟更简单</h2>
				<p>上传规定的格式EXCEL文件<a href="DownloadServlet?type=2" class="down_i">下载excel模板</a></p>
				<p>一键为你生成班级通讯录</p>
				<p>不再为一个个添加联系人而烦恼</p>
				<div class="sub_download">
					<!-- <a href="#" class="sub_bt"></a> -->
			        <input type="file" name="uploadify" id="uploadify" />  
			        <div class="loading">
			        	<img src="images/loading2.gif" width="30px" height="30px" alt="loading"  />
			        	<span>上传中...</span>
			        </div>
			        <form action="DownloadServlet" method="get" class="down">
			        		<input type="hidden" value="" name="fliefolder" class="fliefolder"/>
			        		<input type="hidden" value="1" name="type" class="type"/>
			        		<input type="submit" class="down_bt" value=""/>
			        </form>   
			       <!--  <p>  
			            <a href="javascript:jQuery('#uploadify').uploadify('upload','*')">开始上传</a>   
			            <a href="javascript:jQuery('#uploadify').uploadify('cancel','*')">取消所有上传</a>  
			        </p> -->
			        <!-- <p>
			        		
			        </p>     --> 
				</div>
			</div>
			<div class="phone">
			</div>
		</div>	
		
	</div>
	<div id="c-wrap" class="clearfix">
		<div class="progress">
			<h1>bete1.0</h1>
			<p>功能:一键打包生成应用；打电话；发短信；保存联系人</p>
		</div>
		<div class="progress">
			<h1 class="h_two">and then</h1>
			<p>接下来：敬请期待...:)</p>
		</div>
		<div class="progress p_3">
			<h1 class="h_third">contact</h1>
			<p>微博：<a href="#">超级同学录</a></a></p>
			<p>QQ：2455281453</p>
			<p>邮箱：2455281453@qq.com</p>
		</div>
	</div>
	<div id="foot">
		Copyright ©2013 Create&Designed by <a href="#">a_lian</a><br/>Nice to see you!
	</div>
         
    </body>
</html>
