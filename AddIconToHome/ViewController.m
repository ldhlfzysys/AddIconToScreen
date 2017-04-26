//
//  ViewController.m
//  AddIconToHome
//
//  Created by liudonghuan on 16/2/24.
//  Copyright © 2016年 Dwight. All rights reserved.
//

#import "ViewController.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "WBSMacroHeader.h"

@interface ViewController ()
{
    HTTPServer *httpServer;
}
@property (nonatomic, strong) UIImageView *imageView;  //!< <#属性注释#>
@end

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *shareIcon = [[UIButton alloc]initWithFrame:CGRectMake(10, 50, 150, 50)];
    [shareIcon setTitle:@"web在服务器" forState:UIControlStateNormal];
    [shareIcon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:shareIcon];
    [shareIcon addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareIconLocal = [[UIButton alloc]initWithFrame:CGRectMake(170, 50, 150, 50)];
    [shareIconLocal setTitle:@"web在本地" forState:UIControlStateNormal];
    [shareIconLocal setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:shareIconLocal];
    [shareIconLocal addTarget:self action:@selector(shareLocalClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *imageECode = [[UIButton alloc]initWithFrame:CGRectMake(80, 120, 150, 50)];
    [imageECode setTitle:@"图片编码" forState:UIControlStateNormal];
    [imageECode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:imageECode];
    [imageECode addTarget:self action:@selector(encoderimage) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *imageNOECode = [[UIButton alloc]initWithFrame:CGRectMake(80, 200, 150, 50)];
    [imageNOECode setTitle:@"图片解码" forState:UIControlStateNormal];
    [imageNOECode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:imageNOECode];
    [imageNOECode addTarget:self action:@selector(noEncoderimage) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(80, 250, 100, 100)];
    imageV.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:imageV];
    self.imageView = imageV;
    
}

- (void)shareClick
{
    //以下url替换成index.html所在服务器，下面地址是我的临时测试地址，随时报销。
    NSURL* url = [[ NSURL alloc ] initWithString :@"http://github.weberson.com.cn/ios"];
    [[UIApplication sharedApplication ] openURL: url];
}

// 编码
- (void)encoderimage
{
    NSString * imagepath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web/timg.jpeg"];;
    NSData  * imageData = [[NSData dataWithContentsOfFile:imagepath] base64EncodedDataWithOptions:0];
    
    NSString *imageStr = [[NSString alloc]initWithData:imageData encoding:NSUTF8StringEncoding];
    NSLog(@"图片编码后是:-------    %@  -----------",imageStr);
}

// 解码
-(void)noEncoderimage{
    
    NSData *imageData = [imageCode dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *ttdata = [imageData initWithBase64EncodedData:imageData options:0];
    
    UIImage *tempimg = [UIImage imageWithData:ttdata];
    
    self.imageView.image = tempimg;
    
}

- (void)shareLocalClick
{
    // Configure our logging framework.
    // To keep things simple and fast, we're just going to log to the Xcode console.
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // Create server using our custom MyHTTPServer class
    httpServer = [[HTTPServer alloc] init];
    
    // Tell the server to broadcast its presence via Bonjour.
    // This allows browsers such as Safari to automatically discover our service.
    [httpServer setType:@"_http._tcp."];
    
    // Normally there's no need to run our server on any specific port.
    // Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
    // However, for easy testing you may want force a certain port so you can just hit the refresh button.
    [httpServer setPort:12345];
    
    // Serve files from our embedded Web folder
    NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
    DDLogInfo(@"Setting document root: %@", webPath);
    
    [httpServer setDocumentRoot:webPath];
    
    [self startServer];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://127.0.0.1:12345"]];
}

- (void)startServer
{
    NSError *error;
    if([httpServer start:&error])
    {
        DDLogInfo(@"Started HTTP Server on port %hu", [httpServer listeningPort]);
    }
    else
    {
        DDLogError(@"Error starting HTTP Server: %@", error);
    }
}

@end
