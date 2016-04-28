
#iOS添加快捷方式到桌面#

#####涉及：OpenUrl、iOS shceme、Data URI Scheme、JS、Socket#
#####功能：将应用的某一个页面或某一个功能以快捷方式形式添加到桌面，用户点击桌面图标，可以唤起应用并打开对应页面或功能。
>欢迎转载分享 微博@刘东寰 
<a href="http://www.jianshu.com/p/86a5e35ef2ab" target="_blank">我的博客</a> 

---
###背景
用户在使用如微博、淘宝、贴吧、百度地图时，有些页面打开频率非常高，甚至某个应用只为了这几个单一的功能，这个时候，可以考虑将对应的功能页面以快捷方式添加到桌面上。

---
###实现这个功能的基础
因为没有找到或没有这个功能的开放API，因此只能借助Safari，在Safari中，有一个功能叫：添加到主屏幕，而我们将使用这个入口去实现这个功能。
>Safari中添加到主屏幕，就是把当前页面的url以图标的形式添加到桌面，点击该图标，还是打开Safari并打开对应的url，和我们想要的效果不一样，继续看下去。

---
###iOS之OpenUrl
>OpenUrl(开放链接)

例如：

	[[UIApplication sharedApplication] openURL:[NSURLURLWithString:@"tel://xxx"]];
在iOS中，如果我们要在应用里唤起拨号应用，会使用这么一种方式，"tel://" 就是拨号应用在程序里注册的scheme，所有应用都可以在程序里注册scheme，这种scheme在整个手机里是通用的，第三方的分享也是依赖这种方式通过openURL:scheme的方式唤起自己的应用。

那么如何注册自己应用的scheme？网上关于这方面非常多，就贴个链接吧[here](http://www.cocoachina.com/industry/20140522/8514.html).

OpenUrl在这个功能的利用就是：

1. 通过OpenUrl唤起Safari，让Safari访问一个指定页面。
2. Safari保存到桌面的图标，在点击时通过OpenUrl唤起我们的应用。（你可以在Safari地址栏输入tel://xxx）

---

###Safari打开怎么样的页面？

通过OpenUrl，我们可以让应用打开Safari并访问一个页面。我们知道Safari添加到桌面是把当前的URL添加到桌面，那么，当我们点击图标的时候也是访问这个页面。而这个页面在第一次被打开的时候需要显示一些引导页之类的，而在桌面被打开的时候却需要调用一个scheme。这似乎不太可能，我们接着往下看。

---

###JS
>对JS不是太熟悉，以下方法来自网络

	<script>
    if (window.navigator.standalone == true)
    {
        var lnk = document.getElementById("你的带scheme的<a>标签ID").click();
        //通过你所知道的方式打开一个scheme，上面这句话的链接标签如：<a href="tel://xxx">
    }
    else
    {
        document.getElementById("msg").innerHTML='<div style="font-size:12px">
        可以插入引导页</div>';
        //这里你可以去加载你的引导页
    }
	</script>

你可以试试通过Safari保存一个页面到桌面，再打开这个页面，你会发现，前者是非全屏状态，而通过快捷方式打开的Safari是全屏的。这正是一个突破口。

	if (window.navigator.standalone == true)
判断当前页面是否全屏，如果非全屏，那么我们显示引导页，如果是全屏，我们就打开一个链接。到这里，上一个问题就被解决了。

---

###已经可以实现这个功能了
现在你可以在服务器部署一个网页实现这个功能了。但是，还是有缺点的，每次点击快捷方式我们都需要访问这个页面，如果网络状态不好，那么是很大的延时，（比如xx贴吧目前的状况）。

###进一步优化之利用Data URI Scheme

>我们希望这个页面不依赖网络。在这个过程中试验了多种方案，这里只贴我认为最妥的一种。

做过前端的小伙伴可能说到这就明白了，Data URI Scheme（DATA－URI 是指可以在Web 页面中包含图片但无需任何额外的HTTP 请求的一类URI.）比如网页里需要放一张图片，这张图片会有一个地址，而图片的获取是需要访问网络的。但是通过DataURI，我们可以把图片进行base64编码直接存储在页面中。

	<img src="http://xxxx/xx.png">
	->
	<img src="data:image/png;base64,xxxx" />

这里，我们就要通过这种方式，把我们的网页存储在地址栏，首先，我们将做好的页面（含引导页和跳转scheme）通过base64编码成DataURIScheme，接着，我们放入这样一个新页面的<meta>标签。这个新页面的作用就是作为一个中间物，所以其他可以不写。

	<meta http-equiv="refresh" content="0;URL= ‘your datauri’>

这个新页面你需要部署到服务器，接着应用就打开这个页面，这个时候，页面会自动刷新一次，你会发现，你编码过的网页就出现在了地址栏，是不是很神奇。然后你把这个页面添加快捷方式到桌面。断开网络，再试试打开这个快捷方式吧。

---

该项目的Demo: [iOS添加快捷方式到桌面](https://github.com/ldhlfzysys/AddIconToScreen)

微博：@刘东寰




应用部分截图
 ![image](https://github.com/ldhlfzysys/AddIconToScreen/blob/master/Screenshot/1.png)
 ![image](https://github.com/ldhlfzysys/AddIconToScreen/blob/master/Screenshot/2.png)
 
 
 # Web文件夹说明<br>
 index.html  ---应用内搭建服务器主页<br>
 content.html ---用作主页的跳转页，通过Data URI放在主页中<br>
 webOnServer.html ---方案一服务器端用到的页面<br>
