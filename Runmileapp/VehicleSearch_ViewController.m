//
//  VehicleSearch_ViewController.m
//  Runmileapp

//  Created by Tecksky Techonologies on 9/7/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "VehicleSearch_ViewController.h"
#import "VehicleSearch_TableViewCell.h"
#import "VehicleInquiry_ViewController.h"
#import "httpws.h"
#import "Constant.h"
#import "AppMethod.h"
#import "PostRequest_Vehicle_ViewController.h"
#import "PostRequest_Test_BuyVehicle_ViewController.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "Vehicle_Type_Capacity_New_TableViewCell.h"
@interface VehicleSearch_ViewController ()

@end

@implementation VehicleSearch_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController]setNavigationBarHidden:YES animated:YES];
    
    _PostRequireHere.layer.cornerRadius = 17;
    
    fualtyp = [[NSMutableArray alloc]init];
    Owner_typelist = [[NSMutableArray alloc]init];
    
    filter_dic = [[NSDictionary alloc]init];
     ownerlist = [[NSMutableArray alloc]init];
    [self Get_Filterdata];
    
    
    fual = @"";
    noofown = @"";
    price = @"";
    kmdriv = @"";
    brand = @"";
    capaci = @"";
    city = _locationsearch;
    
     adon_dic = [[NSMutableDictionary alloc]init];
     citytyp = [[NSMutableArray alloc]init];
     brandtyp = [[NSMutableArray alloc]init];
    [self Get_adondata];
    

     pager=[[NSMutableArray alloc]init];
    _pageno=1;
    [self GetTriplist:_pageno];
    
  
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    _view_filter.hidden= YES;
    
    //scrollview
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlview.contentSize = contentRect.size;
    
    clickflag=[[NSMutableArray alloc]init];
    
    
    _FualType_tabledata.hidden = YES;
    fualtyp=[[NSArray alloc]initWithObjects:@"Petrol",@"Diesel",nil];
    
    _city.enabled = NO;
    _brand.enabled =NO;
   
    
}

-(void)Get_adondata
{
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
     adon_dic = [dic valueForKey:@"data"];
     [self Get_Currency];
    
    [self jsonparsing_cityType];
    _city_table.hidden = YES;
    
    [self jsonparsing_BrandType];
    _table_brand.hidden = YES;
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    [ProgressHUD show:@"Please wait..."];
//    [manager GET:[baseurl stringByAppendingString:AddOnurl] parameters:nil progress:nil success:^(NSURLSessionTask *task, id hireresponse)
//     {
//         
//         adon_dic = [hireresponse valueForKey:@"data"];
//         [self Get_Currency];
//         
//         [ProgressHUD dismiss];
//         
//     } failure:^(NSURLSessionTask *operation, NSError *error)
//     {
//         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//         [al show];
//         [ProgressHUD dismiss];
//     }];

}
-(void)jsonparsing_BrandType
{
    
    brandtypedata=[[NSMutableArray alloc] initWithArray:[adon_dic objectForKey:@"dealer_brand"]copyItems:YES];
    
    for (int i=0; i<[brandtypedata count];i++)
    {
        NSDictionary *dic12 = [brandtypedata objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [brandtyp addObject:str1];
    }
    [_table_brand reloadData];
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
-(void)Get_Filterdata
{
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_Filter"]];
    filter_dic = [dic valueForKey:@"data"];
    [self SliderValue_Price];
    [self SliderValue_Capacity];
    [self SliderValue_KmDriven];
    [self noOf_Owner];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [ProgressHUD show:@"Please wait..."];
//    NSDictionary *filterbaseurl = [baseurl stringByAppendingString:Filterurl];
//    
//    [manager GET:filterbaseurl parameters:nil progress:nil success:^(NSURLSessionTask *task, id Sliderresponse)
//     {
//         
//         filter_dic = [Sliderresponse valueForKey:@"data"];
//        
//         [self SliderValue_Price];
//         [self SliderValue_Capacity];
//         [self SliderValue_KmDriven];
//         [self noOf_Owner];
//         
//          [ProgressHUD dismiss];
//         
//     }failure:^(NSURLSessionTask *operation, NSError *error)
//     {
//         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//         [al show];
//          [ProgressHUD dismiss];
//     }];

}

-(void)Get_Currency
{
    
    Currency = [adon_dic objectForKey:@"currency"];
    
}
-(void)SliderValue_Price
{
    
    NSDictionary *price_range = [[NSDictionary alloc] init];
    price_range = [[filter_dic valueForKey:@"vehicle"] valueForKey:@"price_range"];
    
    [_price_slider setMaximumValue:[[price_range valueForKey:@"max"]floatValue]];
    _pricelbl1.text = [NSString stringWithFormat:@"%@",[price_range valueForKey:@"min"]];
    _pricelbl2.text = [NSString stringWithFormat:@"%@",[price_range valueForKey:@"max"]];
    
}
-(void)SliderValue_KmDriven
{
    
    NSDictionary *kmDriven = [[NSDictionary alloc] init];
    kmDriven = [[filter_dic valueForKey:@"vehicle"] valueForKey:@"km_driven"];

    [_kmDriven_Slider setMaximumValue:[[kmDriven valueForKey:@"max"]floatValue]];
    _kmDrivenlbl1.text = [NSString stringWithFormat:@"%@",[kmDriven valueForKey:@"min"]];
    _kmDrivenlbl2.text = [NSString stringWithFormat:@"%@",[kmDriven valueForKey:@"max"]];
    
}
-(void)SliderValue_Capacity
{
    NSDictionary *capacity = [[NSDictionary alloc] init];
    capacity = [[filter_dic valueForKey:@"vehicle"] valueForKey:@"capacity_range"];

    [_capacitySlider setMaximumValue:[[capacity valueForKey:@"max"]floatValue]];
    _capacitylbl1.text = [NSString stringWithFormat:@"%@",[capacity valueForKey:@"min"]];
    _capacitylbl2.text = [NSString stringWithFormat:@"%@",[capacity valueForKey:@"max"]];
    
}
-(void)noOf_Owner
{
    NSDictionary *vehicle_owner = [[NSDictionary alloc] init];
    vehicle_owner = [[filter_dic valueForKey:@"vehicle"] valueForKey:@"no_of_owner"];
    
    for (int i = [[vehicle_owner valueForKey:@"min"] intValue]; i<=[[vehicle_owner valueForKey:@"max"] intValue]; i++) {
        [ownerlist addObject:[NSNumber numberWithInt:i]];
    }
    [_table_noofOwner reloadData];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == _city)
    {
        _city_table.hidden = NO;
        
        [self.city_table reloadData];
    }
    else if (textField == _brand)
    {
        _table_brand.hidden = NO;
        
        [self.table_brand reloadData];
    }
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    if (tableView == _table_vehicle)
    {
         return [pager count];
    }
    else if (tableView == _FualType_tabledata)
    {
        return [fualtyp count];
    }
    else if(tableView==_table_brand)
    {
        return [brandtyp count];
    }
    else if(tableView==_city_table)
    {
        return [citytyp count];
    }
    else
    {
        return [ownerlist count];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _table_vehicle)
    {
        static NSString *table = @"cell12";
        
        VehicleSearch_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        cell.name.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"name"];
        
        cell.kms.text = [NSString stringWithFormat:@"%@",[[pager objectAtIndex:indexPath.row]valueForKey:@"km_driven"]];
        
        
        cell.NoofOwners.text=[NSString stringWithFormat:@"%@",[[pager objectAtIndex:indexPath.row]valueForKey:@"no_of_owners"]];
        
        cell.city.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"city"];
        
        cell.FualType.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"fuel_type"];
        
        NSString *capacity = [NSString stringWithFormat:@"%@",[[pager objectAtIndex:indexPath.row]valueForKey:@"capacity" ]];
        
        cell.Capacity.text=capacity;
        
        cell.Color.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"color"];
        
        
        NSString *curr = [NSString stringWithFormat:@"%@ %@",[Currency valueForKey:@"symbol"],[[pager objectAtIndex:indexPath.row]valueForKey:@"price"]];
        
        cell.Price.text = curr;
        
        if ([[[pager objectAtIndex:indexPath.row]valueForKey:@"images"] count] >0) {
            NSString *imgurl = [[[pager objectAtIndex:indexPath.row]valueForKey:@"images"] objectAtIndex:0];
            
            cell.img.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgurl]]];
        }
        NSLog(@"linlks-%@",[_dic1 valueForKey:@"_links"]);
        
        
        if (indexPath.row==[pager count]-1)
        {
            NSString *nextlink = [[_dic1 valueForKey:@"_links"]valueForKey:@"next"];
            if (![nextlink isEqualToString:@""])
            {
                _pageno++;
                [self GetTriplist:_pageno];
            }
        }
        cell.Contactbtn.tag=indexPath.row;
        [cell.Contactbtn addTarget:self action:@selector(myCellButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
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
        cell.citylbl_vehiclesearch.text = [citytyp objectAtIndex:indexPath.row];
        return cell;
        
    }
    else if (tableView==_table_brand)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
        }
        cell.brandlbl_vehiclefilter.text = [brandtyp objectAtIndex:indexPath.row];
        
        return cell;
        
    }


    else if(tableView == _table_noofOwner)
    {
        static NSString *table = @"cell1";
        
        VehicleSearch_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        
       cell.noofowner.text = [NSString stringWithFormat:@"%@",[ownerlist objectAtIndex:indexPath.row]];

        cell.uncheckbtn.tag=indexPath.row;
        [cell.uncheckbtn addTarget:self action:@selector(ChkUnChk:) forControlEvents:UIControlEventTouchUpInside];
        return cell;

    }
    else
    {
        static NSString *table = @"cell1";
        
        VehicleSearch_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        
        cell.Fualtypelbl.text = [fualtyp objectAtIndex:indexPath.row];
        cell.uncheck_fual.tag=indexPath.row;
        [cell.uncheck_fual addTarget:self action:@selector(ChkUnChk:) forControlEvents:UIControlEventTouchUpInside];
        return cell;

    }
    return nil;
}
-(void)myCellButtonPressed:(UIButton *)sender
{
    UIButton *senderButton = (UIButton *)sender;
    
    NSDictionary *vehicledic = [pager objectAtIndex:senderButton.tag];
    
    NSDictionary *vehicle = [vehicledic valueForKey:@"vehicle_type_id"];
    
    VehicleInquiry_ViewController *cnumber=[self.storyboard instantiateViewControllerWithIdentifier:@"VehicleInquiry_ViewController"];
    
    cnumber.vehicleid=[vehicledic valueForKey:@"id"];
    
    [self.navigationController pushViewController:cnumber animated:YES];
    
}

-(void)GetTriplist:(NSInteger)pageno
{
    
    
    NSString *access_token = [AppMethod getStringDefault:@"default_access_token"];
    
    setdic=[[NSMutableDictionary alloc]init];
    [setdic setObject:fual forKey:@"fuel_type"];
    [setdic setObject:Owner_typelist forKey:@"no_of_owners"];
    [setdic setObject:price forKey:@"price"];
    [setdic setObject:kmdriv forKey:@"km_driven"];
    [setdic setObject:brand forKey:@"brand"];
    [setdic setValue:capaci forKey:@"capacity"];
    [setdic setObject:city forKey:@"city"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [ProgressHUD show:@"Please wait..."];
    
    [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
    
    NSString *vehicleurl =[NSString stringWithFormat:@"%@?page=%d",[baseurl stringByAppendingString:VehicleSearchurl],pageno];
    
    [manager POST:vehicleurl parameters:setdic progress:nil success:^(NSURLSessionTask *task, id vehicleresponse)
     {
         
         _dic1 = [vehicleresponse valueForKey:@"data"];
         
         NSMutableArray *pagerlist=[_dic1 valueForKey:@"pager"];
         
         for (int i=0; i<[pagerlist count]; i++)
         {
             [pager addObject:[pagerlist objectAtIndex:i]];
         }
         [_table_vehicle reloadData];
         [ProgressHUD dismiss];
         
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [al show];
         [ProgressHUD dismiss];
     }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _FualType_tabledata)
    {
        _fual_type.text=[fualtyp objectAtIndex:indexPath.row];
        
        
        _FualType_tabledata.hidden = YES;
    }
    else if (tableView==_city_table)
    {
        _city.text=[citytyp objectAtIndex:indexPath.row];
        city= [[[adon_dic valueForKey:@"city"]objectAtIndex:indexPath.row] valueForKey:@"value"];
        _city_table.hidden = YES;
    }
    else if (tableView==_table_brand)
    {
        _brand.text=[brandtyp objectAtIndex:indexPath.row];
        brand= [[[adon_dic valueForKey:@"dealer_brand"]objectAtIndex:indexPath.row] valueForKey:@"value"];
        _table_brand.hidden = YES;
    }
    else
    {
    PostRequest_Test_BuyVehicle_ViewController *test = [self.storyboard instantiateViewControllerWithIdentifier:@"PostRequest_Test_BuyVehicle_ViewController"];
    
    test.vehicledata = [pager objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:test animated:YES];
    }
}

- (IBAction)PostRequireHere:(id)sender
{
    PostRequest_Vehicle_ViewController *test = [self.storyboard instantiateViewControllerWithIdentifier:@"PostRequest_Vehicle_ViewController"];
     [self.navigationController pushViewController:test animated:YES];
}

- (IBAction)vehicle_filter:(id)sender
{
    _view_filter.hidden= NO;

}
- (IBAction)dropdown_fualType:(id)sender
{
    _FualType_tabledata.hidden = NO;
}

- (IBAction)price_Slider:(UISlider *)sender
{
    int value = (int)sender.value;
    _pricelbl1.text = [NSString stringWithFormat:@"%d",value];
}
- (IBAction)kmDriven_Slider:(UISlider *)sender
{
    int value = (int)sender.value;
    _kmDrivenlbl1.text = [NSString stringWithFormat:@"%d",value];
}
- (IBAction)capacitySlider:(UISlider *)sender
{
    int value = (int)sender.value;
    _capacitylbl1.text = [NSString stringWithFormat:@"%d",value];
}
- (IBAction)clearbtn:(id)sender
{
    [pager removeAllObjects];
    
    fual = @"";
    price = @"";
    kmdriv = @"";
    brand = @"";
    capaci = @"";
    city = @"";
    
    
    [Owner_typelist removeAllObjects];
    _pageno=1;
    [self GetTriplist:_pageno];
    _view_filter.hidden = YES;
 
}

- (IBAction)Applybtn:(id)sender
{
    [pager removeAllObjects];
    
    price = _pricelbl1.text;
    kmdriv = _kmDrivenlbl1.text;
    capacity = _capacitylbl1.text;
    brand = _brand.text;
    city = _city.text;
    fual = _fual_type.text;
   
    [Owner_typelist removeAllObjects];
    
    
    for (int i=0; i<[clickflag count]; i++)
    {
        int noofowner = [[clickflag objectAtIndex:i] intValue]+1;
        [Owner_typelist addObject:[NSString stringWithFormat:@"%d",noofowner]];
    }

  
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
- (IBAction)dropdown_brand:(id)sender
{
    _table_brand.hidden = NO;
}

@end
