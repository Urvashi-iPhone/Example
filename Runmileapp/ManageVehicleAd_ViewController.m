//
//  ManageVehicleAd_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/26/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "ManageVehicleAd_ViewController.h"
#import "ManageVehicleAd_TableViewCell.h"
#import "SWRevealViewController.h"
#import "httpws.h"
#import "AppMethod.h"
#import "Constant.h"
#import "PostRequest_Test_BuyVehicle_ViewController.h"
#import "sell_vehicle_ViewController.h"
#import "Edit_Vehicle_ViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"


@interface ManageVehicleAd_ViewController ()

@end

@implementation ManageVehicleAd_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   //  [[UINavigationBar appearance]setFrame:CGRectMake(0, 0,self.view.frame.size.width, 60)];
    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    pager=[[NSMutableArray alloc]init];
    
    _pageno=1;

    [self GetTriplist:_pageno];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pager count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *table = @"cell12";
    
    ManageVehicleAd_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
    
    [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
    if (cell == nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];

    }

    cell.brand.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"brand"];
    cell.version.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"version"];
  cell.kmdriven.text = [NSString stringWithFormat:@"%@",[[pager objectAtIndex:indexPath.row]valueForKey:@"km_driven"]];
    cell.registerRTO.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"rigister_rto"];
    
    if (indexPath.row==[pager count]-1)
    {
        NSString *nextlink = [[_dic1 valueForKey:@"_links"]valueForKey:@"next"];
        if (![nextlink isEqualToString:@""])
        {
            _pageno++;
            [self GetTriplist:_pageno];
        }
    }
    
   cell.showbtn.tag=indexPath.row;
   [cell.showbtn addTarget:self action:@selector(myCellButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.editbtn.tag=indexPath.row;
    [cell.editbtn addTarget:self action:@selector(myCellButtonPressededit:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.deletebtn.tag=indexPath.row;
    [cell.deletebtn addTarget:self action:@selector(myCellButtonPresseddelete:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
-(void)GetTriplist:(NSInteger)pageno
{
    NSString *access_token = [AppMethod getStringDefault:@"default_access_token"];
    
    setdic=[[NSMutableDictionary alloc]init];
    
    [setdic setObject:[AppMethod getStringDefault:@"default_id"] forKey:@"user_id"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     [ProgressHUD show:@"Please wait..."];
    
    [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
    
    NSString *managepatrs=[NSString stringWithFormat:@"%@?page=%d",[baseurl stringByAppendingString:ManageVehicleurl],pageno];
    
    
    [manager POST:managepatrs parameters:setdic progress:nil success:^(NSURLSessionTask *task, id vehicleedit)
     {
         
         _dic1 = [vehicleedit valueForKey:@"data"];
         
         NSMutableArray *pagerlist=[_dic1 valueForKey:@"pager"];
         
         for (int i=0; i<[pagerlist count]; i++)
         {
             [pager addObject:[pagerlist objectAtIndex:i]];
         }
         [_table_data reloadData];
          [ProgressHUD dismiss];
         
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [al show];
          [ProgressHUD dismiss];
     }];
    
}
-(void)myCellButtonPressed:(UIButton *)sender
{
    UIButton *senderButton = (UIButton *)sender;
    
    
    PostRequest_Test_BuyVehicle_ViewController *cnumber=[self.storyboard instantiateViewControllerWithIdentifier:@"PostRequest_Test_BuyVehicle_ViewController"];
    
     cnumber.vehicledata = [pager objectAtIndex:senderButton.tag];

    [self.navigationController pushViewController:cnumber animated:YES];
    
}

-(void)myCellButtonPressededit:(UIButton *)sender
{
    UIButton *senderButton = (UIButton *)sender;
    
    
    Edit_Vehicle_ViewController *cnumber=[self.storyboard instantiateViewControllerWithIdentifier:@"Edit_Vehicle_ViewController"];
    
    cnumber.vehicleedit = [pager objectAtIndex:senderButton.tag];
    
    
    [self.navigationController pushViewController:cnumber animated:YES];
    
}
-(void)myCellButtonPresseddelete:(UIButton *)sender
{
    
    NSMutableDictionary *deletevehicle = [[NSMutableDictionary alloc]init];
    
    UIButton *senderButton = (UIButton *)sender;
    
    [deletevehicle setObject:[[pager objectAtIndex:senderButton.tag]valueForKey:@"id"]forKey:@"id"];
    
    NSMutableDictionary *dicpass1 = [httpws httpDeletewithauth :[baseurl stringByAppendingString:DeleteVehicleurl] :deletevehicle :[AppMethod getStringDefault:@"default_access_token"]];
    
    NSDictionary *dicpass = [[NSDictionary alloc]initWithDictionary:[dicpass1 objectForKey:@"data"]copyItems:YES];
    BOOL boolean = [[dicpass1 valueForKey:@"status"]boolValue];
    if (boolean)
    {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[dicpass1 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [al show];
        
    }

//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//        [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
//   
//    NSString *deletevehicleurl = [baseurl stringByAppendingString:DeleteVehicleurl];
//    
//    NSMutableDictionary *deletevehicledic = [[NSMutableDictionary alloc]init];
//    
//    deletevehicledic = [[pager objectAtIndex:senderButton.tag]valueForKey:@"id"];
//    
//    [manager DELETE:deletevehicleurl parameters:deletevehicledic success:^(NSURLSessionTask *task, id deletevehicle)
//     
//          {
//              BOOL boolean = [[deletevehicle valueForKey:@"status"]boolValue];
//              if (boolean)
//              {
//                  UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:[deletevehicle valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//                  [al show];
//                  
//              }
//          }failure:^(NSURLSessionTask *operation, NSError *error)
//                {
//                    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
//                    [al show];
//                }];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController presentationController];
        
    }
}
- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
