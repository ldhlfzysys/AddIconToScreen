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

@interface ViewController ()
{
    HTTPServer *httpServer;
}
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
}

- (void)shareClick
{
    //以下url替换成index.html所在服务器，下面地址是我的临时测试地址，随时报销。
    NSURL* url = [[ NSURL alloc ] initWithString :@"http://1.ldhtest.applinzi.com"];
    [[UIApplication sharedApplication ] openURL: url];
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
