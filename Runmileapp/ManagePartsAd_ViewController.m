//
//  ManagePartsAd_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/26/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "ManagePartsAd_ViewController.h"
#import "ManagePartsAd_TableViewCell.h"
#import "SWRevealViewController.h"
#import "httpws.h"
#import "AppMethod.h"
#import "Constant.h"
#import "PostRequest_Test_Parts_ViewController.h"
#import "Sell_AutoParts_ViewController.h"
#import "Edit_Parts_ViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"


@interface ManagePartsAd_ViewController ()

@end

@implementation ManagePartsAd_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // [[UINavigationBar appearance]setFrame:CGRectMake(0, 0,self.view.frame.size.width, 60)];
    
    
    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    pager=[[NSMutableArray alloc]init];
    
    _pageno=1;
    
    [self GetTriplist:_pageno];
    adon_dic = [[NSDictionary alloc]init];
    [self Get_adondata];
    
    
    // Do any additional setup after loading the view.
}
-(void)Get_adondata
{
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
    adon_dic = [dic valueForKey:@"data"];
    [self Get_Currency];
    
}
-(void)Get_Currency
{
    
    Currency = [adon_dic objectForKey:@"currency"];
    
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
    
    ManagePartsAd_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
    
    [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
    if (cell == nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
        
        
    }
    
    cell.name.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"name"];
    cell.vehicle_model.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"vehicle_model"];
    cell.modelno.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"model_no"];

    
    NSString *curr = [NSString stringWithFormat:@"%@ %@",[Currency valueForKey:@"symbol"],[[pager objectAtIndex:indexPath.row]valueForKey:@"price"]];
    
    cell.price.text = curr;

   
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

    
    NSString *managepatrs=[NSString stringWithFormat:@"%@?page=%d",[baseurl stringByAppendingString:ManagePartsurl],pageno];
    
    
    [manager POST:managepatrs parameters:setdic progress:nil success:^(NSURLSessionTask *task, id parteedit)
     {
         
         _dic1 = [parteedit valueForKey:@"data"];
         
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
    
    
    PostRequest_Test_Parts_ViewController *cnumber=[self.storyboard instantiateViewControllerWithIdentifier:@"PostRequest_Test_Parts_ViewController"];
    
      cnumber.buypartsdata = [pager objectAtIndex:senderButton.tag];
    [self.navigationController pushViewController:cnumber animated:YES];
    
}
-(void)myCellButtonPressededit:(UIButton *)sender
{
    UIButton *senderButton = (UIButton *)sender;
    
    
    Edit_Parts_ViewController *cnumber=[self.storyboard instantiateViewControllerWithIdentifier:@"Edit_Parts_ViewController"];
    
    cnumber.EditPartsdata = [pager objectAtIndex:senderButton.tag];
    
    [self.navigationController pushViewController:cnumber animated:YES];
    
}

-(void)myCellButtonPresseddelete:(UIButton *)sender
{
    NSMutableDictionary *deleteparts = [[NSMutableDictionary alloc]init];
    
    UIButton *senderButton = (UIButton *)sender;
    
    [deleteparts setObject:[[pager objectAtIndex:senderButton.tag] valueForKey:@"id"]forKey:@"id"];
    
    NSMutableDictionary *dicpass1 = [httpws httpDeletewithauth :[baseurl stringByAppendingString:DeletePartsurl] :deleteparts :[AppMethod getStringDefault:@"default_access_token"]];
    
    NSDictionary *dicpass = [[NSDictionary alloc]initWithDictionary:[dicpass1 objectForKey:@"data"]copyItems:YES];
    BOOL boolean = [[dicpass1 valueForKey:@"status"]boolValue];
    if (boolean)
    {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[dicpass1 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [al show];
        
    }
    
//    
//    NSMutableDictionary *deleteparts = [[NSMutableDictionary alloc]init];
//
//    UIButton *senderButton = (UIButton *)sender;
//   
//    [deleteparts setObject:[[pager objectAtIndex:senderButton.tag] valueForKey:@"id"]forKey:@"id"];
//    
//    NSLog(@"%@",deleteparts);
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//   
//    [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
//    
//    //manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    //manager.responseSerializer = [AFJSONResponseSerializer
//     //                             serializerWithReadingOptions:NSJSONReadingAllowFragments];
//    NSDictionary *parameter = @{@"id": @"18"};
//    [manager DELETE:[baseurl stringByAppendingString:DeletePartsurl] parameters:parameter success:^(NSURLSessionTask *task, id dicpass1)
//   
//    {
//         NSDictionary *dicpass = [[NSDictionary alloc]initWithDictionary:[dicpass1 objectForKey:@"data"]copyItems:YES];
//       
//         BOOL boolean = [[dicpass valueForKey:@"status"]boolValue];
//         if (boolean)
//         {
//             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:[dicpass1 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//             [al show];
//         }
//        else
//        {
//            NSLog(@"%@",[dicpass1 valueForKey:@"message"]);
//        }
//     }failure:^(NSURLSessionTask *operation, NSError *error)
//     {
//         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
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
