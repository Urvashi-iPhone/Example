//
//  Service_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/10/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "Service_ViewController.h"
#import "SWRevealViewController.h"
#import "ProgressHUD.h"
@interface Service_ViewController ()

@end

@implementation Service_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   //  [[UINavigationBar appearance]setFrame:CGRectMake(0, 0,self.view.frame.size.width, 60)];
    
    [ProgressHUD show:@"Please wait..."];
    NSString *urlString = @"http://runmile.com/api/web/v1/page/service";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [_WebViewUrl loadRequest:urlRequest];
     [ProgressHUD dismiss];
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
