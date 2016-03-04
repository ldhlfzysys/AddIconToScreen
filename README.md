# iOS添加快捷方式到桌面
====

原理：应用内唤起safari，通过safari的添加到主屏幕功能把带自动打开scheme的html作为快捷方式添加到桌面。<br />

细节：<br />
1、html，通过js判断当前safari是否为全屏去判断是否要打开scheme<br />
2、meta参数在苹果的官方文档   
[点击这里你可以链接到苹果官方文档](https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html)<br />

应用部分截图
 ![image](https://github.com/ldhlfzysys/AddIconToScreen/blob/master/Screenshot/1.png)
 ![image](https://github.com/ldhlfzysys/AddIconToScreen/blob/master/Screenshot/2.png)
