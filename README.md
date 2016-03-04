# iOS添加快捷方式到桌面
====

<strong>iOS添加快捷方式到桌面 | addicontoscreen | addicontohome </strong>
<a href="https://github.com/ldhlfzysys/AddIconToScreen" target="_blank">iOS添加快捷方式到桌面源码</a> 

用户在使用如微博、淘宝、贴吧、百度地图时，有些页面打开频率非常高，甚至某个应用只为了这几个单一的功能，这个时候，可以将对应的功能页面以快捷方式添加到桌面上。

在safari中，有一个功能叫：添加到主屏幕，而我们将使用这个入口去实现这个功能。（暂时没有找到或没有这个功能的开放API）

实现方案一：通过访问外部页面，将外部页面作为快捷页面添加到桌面，通过js对safari当前是否全屏暂时来判断是暂时引导页面还是调用openUrl去打开一个scheme。
优点：实现简单，客户端基本无工作量，页面灵活可随时更改。
缺点：一旦没网，或网络状态不够好或服务器挂了，用户将无法完成操作过程。

实现方案二：通过应用内部启动httpserver，调用safari访问localhost，同时，在主页通过Data URI跳转到新的页面附编码网站：http://software.hixie.ch/utilities/cgi/data/data
优点：不需要服务器，没网也能完成操作。
缺点：实现相对麻烦些。

图标、名字的设置在苹果提供的文档里可以查看：[点击这里你可以链接到苹果官方文档](https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html)<br />

判断safari是否全屏
<pre lang="objc" line="0">
<script>
    if (window.navigator.standalone == true)
    {
        var lnk = document.getElementById("你的带scheme的<a>标签ID").click();
    }
    else
    {
        document.getElementById("msg").innerHTML='<div style="font-size:12px">可以插入引导页</div>';
    }
</script>
</pre>


应用部分截图
 ![image](https://github.com/ldhlfzysys/AddIconToScreen/blob/master/Screenshot/1.png)
 ![image](https://github.com/ldhlfzysys/AddIconToScreen/blob/master/Screenshot/2.png)
 
 
 # Web文件夹说明
 index.html  ---应用内搭建服务器主页
 content.html ---用作主页的跳转页，通过Data URI放在主页中
 webOnServer.html ---方案一服务器端用到的页面
