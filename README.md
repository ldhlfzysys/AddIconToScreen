# iOS添加快捷方式到桌面
====

原理：应用内唤起safari，通过safari的添加到主屏幕功能把带自动打开scheme的html作为快捷方式添加到桌面。<br />

细节：<br />
1、html，通过js判断当前safari是否为全屏去判断是否要打开scheme<br />
2、meta参数在苹果的官方文档   
[点击这里你可以链接到www.google.com](https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html)<br />
PS：也可以在应用内搭建小型的httpServer服务，利用safari打开localhost去访问应用内数据，原理相同，只是html页放本地或放服务器。
