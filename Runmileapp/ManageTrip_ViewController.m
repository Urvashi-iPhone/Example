//
//  ManageTrip_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/24/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "ManageTrip_ViewController.h"
#import "ManageTrip_TableViewCell.h"
#import "SWRevealViewController.h"
#import "httpws.h"
#import "AppMethod.h"
#import "Constant.h"
#import "PostRequestTest_ViewController.h"
#import "Edit_Trip_ViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"


@interface ManageTrip_ViewController ()

@end

@implementation ManageTrip_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    pager=[[NSMutableArray alloc]init];
    
    _pageno=1;
    
    [self GetTriplist:_pageno];
    // Do any additional setup after loading the view.
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
    
    ManageTrip_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
    
    [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
    if (cell == nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
        
    }
    
    cell.Tripid.text=[NSString stringWithFormat:@"%@",[[pager objectAtIndex:indexPath.row]valueForKey:@"id"]];
    cell.fromAdd.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"from_address"];
    cell.ToAdd.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"to_address"];
    cell.StartTim.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"start_time"];
    cell.EndTime.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"end_time"];
    cell.Price.text=[NSString stringWithFormat:@"$%@",[[pager objectAtIndex:indexPath.row]valueForKey:@"price"]];
    cell.Status.text=[NSString stringWithFormat:@"%@",[[pager objectAtIndex:indexPath.row]valueForKey:@"status"]];
    
    
    if ([[NSString stringWithFormat:@"%@",[[pager objectAtIndex:indexPath.row]valueForKey:@"status"]] isEqualToString:@"1"])
    {
         cell.Status.text = @"Inactive";
    }
    else
    {
         cell.Status.text = @"Active";
    }

    
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
    
    NSString *managetrip=[NSString stringWithFormat:@"%@?page=%d",[baseurl stringByAppendingString:ManageTripurl],pageno];
    
    
    [manager POST:managetrip parameters:setdic progress:nil success:^(NSURLSessionTask *task, id tripedit)
     {
         
         _dic1 = [tripedit valueForKey:@"data"];
         
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
    
    
    PostRequestTest_ViewController *cnumber=[self.storyboard instantiateViewControllerWithIdentifier:@"PostRequestTest_ViewController"];
    
    cnumber.tripdata = [pager objectAtIndex:senderButton.tag];
    
    [self.navigationController pushViewController:cnumber animated:YES];
    
}
-(void)myCellButtonPressededit:(UIButton *)sender
{
    UIButton *senderButton = (UIButton *)sender;
    
    
    Edit_Trip_ViewController *cnumber=[self.storyboard instantiateViewControllerWithIdentifier:@"Edit_Trip_ViewController"];
   
   cnumber.Tripedit = [pager objectAtIndex:senderButton.tag];
    
    
    [self.navigationController pushViewController:cnumber animated:YES];
    
}
-(void)myCellButtonPresseddelete:(UIButton *)sender
{
    NSMutableDictionary *deletetrip = [[NSMutableDictionary alloc]init];
    
    UIButton *senderButton = (UIButton *)sender;
    
    [deletetrip setObject:[[pager objectAtIndex:senderButton.tag]valueForKey:@"id"]forKey:@"id"];
    
    NSMutableDictionary *dicpass1 = [httpws httpDeletewithauth :[baseurl stringByAppendingString:DeleteTripurl] :deletetrip :[AppMethod getStringDefault:@"default_access_token"]];
    
    NSDictionary *dicpass = [[NSDictionary alloc]initWithDictionary:[dicpass1 objectForKey:@"data"]copyItems:YES];
    BOOL boolean = [[dicpass1 valueForKey:@"status"]boolValue];
    if (boolean)
    {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[dicpass1 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [al show];
        
    }

//    NSMutableDictionary *deletetrip = [[NSMutableDictionary alloc]init];
//    
//    UIButton *senderButton = (UIButton *)sender;
//    
//    [deletetrip setObject:[[pager objectAtIndex:senderButton.tag] valueForKey:@"id"]forKey:@"id"];
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    NSLog(@"%@",[AppMethod getStringDefault:@"default_access_token"] );
//    [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
//    [manager DELETE:[baseurl stringByAppendingString:DeleteTripurl] parameters:setdic success:^(NSURLSessionTask *task, id dicpass1)
//     {
//         BOOL boolean = [[dicpass1 valueForKey:@"status"]boolValue];
//         if (boolean)
//         {
//             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[dicpass1 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//             [al show];
//             
//         }
//     }failure:^(NSURLSessionTask *operation, NSError *error)
//     {
//         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
//         [al show];
//     }];
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
