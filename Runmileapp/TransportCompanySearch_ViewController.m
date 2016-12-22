//
//  TransportCompany_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/7/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "TransportCompanySearch_ViewController.h"
#import "TransportCompanySearch_TableViewCell.h"
#import "httpws.h"
#import "AppMethod.h"
#import "Constant.h"
#import "PostRequest_Test_Transport_ViewController.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "Vehicle_Type_Capacity_New_TableViewCell.h"
@interface TransportCompanySearch_ViewController ()

@end

@implementation TransportCompanySearch_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //scrollview
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlview.contentSize = contentRect.size;
    
    adon_dic = [[NSDictionary alloc]init];
    service = [[NSMutableArray alloc]init];
    permit = [[NSMutableArray alloc]init];
    citytyp = [[NSMutableArray alloc]init];
    [self Get_adonData];
    
    company_name = _cnamesearch;
    city = _citysearch;
    permit_type = @"";
    transport_type = @"";
    rate = @"";
    run_mile_approve = @"";
    
    transport_typelist = [[NSMutableArray alloc]init];
    
     pager=[[NSMutableArray alloc]init];
     _pageno=1;
     [self GetTriplist:_pageno];
    
    
    _menutbn.target = self.revealViewController;
    _menutbn.action = @selector(revealToggle:);
    _view_filter.hidden = YES;
   
  //  [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    clickflag=[[NSMutableArray alloc]init];
    
    [_Runmile_unCheckbtn addTarget:self action:@selector(ChkUnChk:) forControlEvents:UIControlEventTouchUpInside];
    
    [self RatingBarMethod];
    _city.enabled = NO;
    
   
}


-(void)Get_adonData
{
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
    adon_dic = [dic valueForKey:@"data"];
    [self jsonparsing_servicedetail];
    [self jsonparsing_PermitType];
    _permittype_tabledata.hidden = YES;
    
    [self jsonparsing_cityType];
    _city_table.hidden = YES;

    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    [ProgressHUD show:@"Please wait..."];
//    [manager GET:[baseurl stringByAppendingString:AddOnurl] parameters:nil progress:nil success:^(NSURLSessionTask *task, id hireresponse)
//     {
//         
//         adon_dic = [hireresponse valueForKey:@"data"];
//         
//         [self jsonparsing_servicedetail];
//         [self jsonparsing_PermitType];
//         _permittype_tabledata.hidden = YES;
//         
//         [ProgressHUD dismiss];
//         
//     } failure:^(NSURLSessionTask *operation, NSError *error)
//     {
//         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//         [al show];
//         [ProgressHUD dismiss];
//     }];
//    
    
}

-(void)jsonparsing_cityType
{
    
    citytypdata=[[NSMutableArray alloc] initWithArray:[adon_dic objectForKey:@"city"]copyItems:YES];
    
    for (int i=0; i<[citytypdata count];i++)
    {
        NSDictionary *dic12 = [citytypdata objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [citytyp addObject:str1];
    }
    [_city_table reloadData];
}


-(void)RatingBarMethod

{
    _rateview.maximumValue = 5;
    _rateview.minimumValue = 0;
    _rateview.value = 0.0f;
    _rateview.allowsHalfStars = YES;
    _rateview.emptyStarImage = [[UIImage imageNamed:@"heart-empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _rateview.filledStarImage = [[UIImage imageNamed:@"heart-full"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    
}
- (IBAction)PermitDropdownbtn:(id)sender
{
      _permittype_tabledata.hidden = NO;
}


-(void)jsonparsing_servicedetail
{
    
    servicetype=[[NSMutableArray alloc] initWithArray:[adon_dic objectForKey:@"transporter_service"]copyItems:YES];
    
    for (int i=0; i<[servicetype count];i++)
    {
        NSDictionary *dic12 = [servicetype objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [service addObject:str1];
    }
    [_table_service reloadData];
}
-(void)jsonparsing_PermitType
{
    permittype=[[NSMutableArray alloc] initWithArray:[adon_dic objectForKey:@"permit_type"]copyItems:YES];
    
    for (int i=0; i<[permittype count];i++)
    {
        NSDictionary *dic12 = [permittype objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [permit addObject:str1];
    }
    [_permittype_tabledata reloadData];
}



-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == _city)
    {
        _city_table.hidden = NO;
        
        [self.city_table reloadData];
    }
    else
    {
    _permittype_tabledata.hidden = NO;
    
    [self.permittype_tabledata reloadData];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _table_transport)
    {
        return [pager count];
    }
    else if(tableView == _table_service)
    {
        return [service count];
    }
    else if(tableView==_city_table)
    {
        return [citytyp count];
    }

   else
       
   {
       return [permit count];
   }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _table_transport)
    {
        static NSString *table = @"cell12";
        
        TransportCompanySearch_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        
        cell.name.text=[[[pager objectAtIndex:indexPath.row]valueForKey:@"profile"]valueForKey:@"company_name"];
        
        cell.mobile.text=[[[pager objectAtIndex:indexPath.row]valueForKey:@"profile"]valueForKey:@"mobile"];
        
        cell.email.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"email"];
        cell.website.text=[[[pager objectAtIndex:indexPath.row]valueForKey:@"profile"]valueForKey:@"website"];
        cell.permit.text = [[[pager objectAtIndex:indexPath.row]valueForKey:@"profile"]valueForKey:@"permit"];
        
        
        float abc = [[[[[pager objectAtIndex:indexPath.row]valueForKey:@"profile"] valueForKey:@"review"] valueForKey:@"overAll"] floatValue];
        
        
        [cell.rateview setValue:abc];
        
        NSString *imgurl=[[pager objectAtIndex:indexPath.row]valueForKey:@"avatar"];
        
        if (imgurl == nil || imgurl == (id)[NSNull null])
        {
            
        }
        else
        {
            cell.img.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[pager objectAtIndex:indexPath.row]valueForKey:@"avatar"]]]];
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
        
        UITapGestureRecognizer *tapGestureRecognizeremail = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didRecognizeTapGesturemobileemail:)];
        tapGestureRecognizeremail.numberOfTapsRequired = 1;
        [cell.email addGestureRecognizer:tapGestureRecognizeremail];
        cell.email.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didRecognizeTapGesture:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [cell.website addGestureRecognizer:tapGestureRecognizer];
        cell.website.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGestureRecognizermobile = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didRecognizeTapGesturemobile:)];
        tapGestureRecognizermobile.numberOfTapsRequired = 1;
        [cell.mobile addGestureRecognizer:tapGestureRecognizermobile];
        cell.mobile.userInteractionEnabled = YES;

        

        return cell;

    }
    else if(tableView == _table_service)
    {
        static NSString *table = @"cell12";
        
        TransportCompanySearch_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        
       cell.transporttype.text = [service objectAtIndex:indexPath.row];
        
        cell.uncheckbtn.tag=indexPath.row;
        [cell.uncheckbtn addTarget:self action:@selector(ChkUnChk:) forControlEvents:UIControlEventTouchUpInside];

        return cell;

    }
    else if (tableView==_city_table)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
        }
        cell.citylbl_transportsearch.text = [citytyp objectAtIndex:indexPath.row];
        return cell;
        
    }

    else
    {
        static NSString *table = @"cell3";
        
        TransportCompanySearch_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        cell.permitlbl.text = [permit objectAtIndex:indexPath.row];

        
        return cell;
    }

}

- (void)didRecognizeTapGesturemobileemail:(UITapGestureRecognizer*)gesture
{
    UILabel *emailurl = [gesture view];
    MFMailComposeViewController *mailcontroler = [[MFMailComposeViewController alloc] init];
    [mailcontroler setMailComposeDelegate:self];
    NSArray *emailarray = [[NSArray alloc] initWithObjects:[emailurl text], nil];
    [mailcontroler setToRecipients:emailarray];
   // [mailcontroler setSubject:@"helo"];
    
    [self presentViewController:mailcontroler animated:YES completion:nil];
    NSLog(@"%@",[emailurl text]);
    
}

- (void)didRecognizeTapGesture:(UITapGestureRecognizer*)gesture
{
    CBAutoScrollLabel *websiteurl = [gesture view];
    
    
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"mailto:"]];
    
    NSLog(@"%@",[websiteurl text]);
    NSURL *url = [NSURL URLWithString:[websiteurl text]];
    
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[emailtxt text]]];
}

- (void)didRecognizeTapGesturemobile:(UITapGestureRecognizer*)gesture
{
    UILabel *mobileurl = [gesture view];
    
    NSLog(@"%@",[mobileurl text]);
    
    
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Runmile"
                                 message:[NSString stringWithFormat:@"%@ %@", @"Do you want to call to",[mobileurl text]]
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Call"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[mobileurl text]]]];
                                    
                                    
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancle"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)ChkUnChk:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
    NSString *Str=[NSString stringWithFormat:@"%d",btn.tag];
    
    BOOL flag=   [clickflag containsObject:Str];
    
    if (flag==YES)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"uncheck.png"]forState:UIControlStateNormal];
        [clickflag removeObject:Str];
    }
    else
    {
        [clickflag addObject:Str];
        [btn setBackgroundImage:[UIImage imageNamed:@"check.png"]forState:UIControlStateNormal];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _table_transport)
    {
        PostRequest_Test_Transport_ViewController *test = [self.storyboard instantiateViewControllerWithIdentifier:@"PostRequest_Test_Transport_ViewController"];
        
        test.transportdata = [pager objectAtIndex:indexPath.row];
        
        
        [self.navigationController pushViewController:test animated:YES];
    }
    else if (tableView==_city_table)
    {
        _city.text=[citytyp objectAtIndex:indexPath.row];
        city= [[[adon_dic valueForKey:@"city"]objectAtIndex:indexPath.row] valueForKey:@"value"];
        _city_table.hidden = YES;
    }
    else if (tableView == _permittype_tabledata)
    {
       _permitType.text=[permit objectAtIndex:indexPath.row];
        permit_type = [[[adon_dic valueForKey:@"transporter_service"]objectAtIndex:indexPath.row]valueForKey:@"id"];
        _permittype_tabledata.hidden = YES;
    }
}


-(void)GetTriplist:(NSInteger)pageno
{
    NSString *access_token = [AppMethod getStringDefault:@"default_access_token"];
    
    setdic=[[NSMutableDictionary alloc]init];
    [setdic setObject:company_name forKey:@"company_name"];
    [setdic setObject:city forKey:@"city"];
    [setdic setObject:permit_type forKey:@"permit_type"];
    [setdic setObject:transport_typelist forKey:@"transporter_type"];
    [setdic setObject:rate forKey:@"rate"];
    [setdic setObject:run_mile_approve forKey:@"run_mile_approve"];
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     [ProgressHUD show:@"Please wait..."];
    
    [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
    
    NSString *transporturl =[NSString stringWithFormat:@"%@?page=%d",[baseurl stringByAppendingString:TransportSearchurl],pageno];
    
    [manager POST:transporturl parameters:setdic progress:nil success:^(NSURLSessionTask *task, id transportresponse)
     {
         
         _dic1 = [transportresponse valueForKey:@"data"];
         
         NSMutableArray *pagerlist=[_dic1 valueForKey:@"pager"];
         
         for (int i=0; i<[pagerlist count]; i++)
         {
             [pager addObject:[pagerlist objectAtIndex:i]];
         }
         [_table_transport reloadData];
          [ProgressHUD dismiss];
         
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [al show];
          [ProgressHUD dismiss];
     }];
}

- (IBAction)Transport_filter:(id)sender
{
    _view_filter.hidden = NO;

}
- (IBAction)clearbtn:(id)sender
{
    [pager removeAllObjects];
    
    company_name = @"";
    city = @"";
    permit_type = @"";
    transport_type = @"";
    rate = @"";
    run_mile_approve = @"";
    
    [transport_typelist removeAllObjects];
    _pageno=1;
    [self GetTriplist:_pageno];
    _view_filter.hidden = YES;

}

- (IBAction)applybtn:(id)sender
{
    [pager removeAllObjects];
    
    company_name = @"";
    city = _city.text;
    
    
    [transport_typelist removeAllObjects];
    for (int i=0; i<[clickflag count]; i++)
    {
        [transport_typelist addObject:[[[adon_dic valueForKey:@"transporter_service"] objectAtIndex:[[clickflag objectAtIndex:i] intValue]] valueForKey:@"id"]];
    }
    
    rate = [[NSNumber numberWithFloat:_rateview.value] stringValue];
    
    _pageno = 1;
    [self GetTriplist:_pageno];
    _view_filter.hidden = YES;

 }
- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)dropdown_city:(id)sender
{
    _city_table.hidden = NO;
}
@end
