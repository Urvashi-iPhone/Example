//
//  SplashScreenViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/9/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "httpws.h"
#import "Constant.h"
#import "LoginViewController.h"
#import "AppMethod.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>



@interface SplashScreenViewController ()
@property(nonatomic)int Ws_flag;

@end

@implementation SplashScreenViewController
{
    NSDictionary *dic;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
   [[self navigationController]setNavigationBarHidden:YES animated:YES];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    _Ws_flag = 0;
    [self GetAdon_data];
    [self GetFilter_Data];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)GetAdon_data
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[baseurl stringByAppendingString:AddOnurl] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        dic = responseObject;
        BOOL boolean = [[dic valueForKey:@"status"]boolValue];
        
        if (boolean)
        {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
            
            [AppMethod  setStringDefault:@"default_adon" :[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
            
            _Ws_flag++;
            if (_Ws_flag == 2)
            {
                
            
            NSString *userid = [AppMethod getStringDefault:@"default_id"];
                
            if (userid==nil || [userid isEqualToString:@""])
            {
                LoginViewController *cnumber=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                
                [self.navigationController pushViewController:cnumber animated:YES];
            }
            else
            {
                SWRevealViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                [self.navigationController pushViewController:tab animated:YES];
            }
            
            
        }
    }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [al show];
        
    }];

}

-(void)GetFilter_Data
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[baseurl stringByAppendingString:Filterurl] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        dic = responseObject;
        BOOL boolean = [[dic valueForKey:@"status"]boolValue];
        
        if (boolean)
        {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
            
            [AppMethod  setStringDefault:@"default_Filter" :[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
            _Ws_flag++;
            if (_Ws_flag == 2)
            {
                NSString *userid= [AppMethod getStringDefault:@"default_id"];
                if (userid==nil || [userid isEqualToString:@""])
                {
                    LoginViewController *cnumber=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                    
                    [self.navigationController pushViewController:cnumber animated:YES];
                }
                else
                {
                    SWRevealViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                    [self.navigationController pushViewController:tab animated:YES];
                }
            }
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [al show];
        
    }];

}



@end
