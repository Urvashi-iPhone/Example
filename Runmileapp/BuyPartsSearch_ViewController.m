//
//  BuyPartsSearch_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/7/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "BuyPartsSearch_ViewController.h"
#import "BuyPartsSearch_TableViewCell.h"
#import "httpws.h"
#import "AppMethod.h"
#import "Constant.h"
#import "BuyParts_Inquiry_ViewController.h"
#import "PostRequest_Parts_ViewController.h"
#import "PostRequest_Test_Parts_ViewController.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "Vehicle_Type_Capacity_New_TableViewCell.h"

@interface BuyPartsSearch_ViewController ()

@end

@implementation BuyPartsSearch_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    part_type =_parttypsearch;
    keyword = _keywordsearch;
    manufacture = _manufacturesearch;
    vehiclemodel = _vehiclemodelpsearch;
    year_manu = _yearmanufacturesearch;
    
    price_rng = @"";
    brand = @"";
    city = @"";
    part_type = @"";
     adon_dic = [[NSDictionary alloc]init];
     citytyp = [[NSMutableArray alloc]init];
      parttyp = [[NSMutableArray alloc]init];
     brandtyp = [[NSMutableArray alloc]init];
    [self Get_adondata];
    
    [self SliderValue];
    
    pager=[[NSMutableArray alloc]init];
    _pageno=1;
    _viewfilter.hidden = YES;
    [self GetTriplist:_pageno];
    
    _PostRequestbtn.layer.cornerRadius = 17.0;
    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    
    _city.enabled = NO;
    _brand.enabled =NO;
   
}

-(void)SliderValue
{
    
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_Filter"]];
    _sliderdic = [[[dic valueForKey:@"data"] valueForKey:@"parts"] valueForKey:@"price_range"];
         [_price setMaximumValue:[[_sliderdic valueForKey:@"max"]floatValue]];
         _pricelbl1.text = [NSString stringWithFormat:@"%@",[_sliderdic valueForKey:@"min"]];
         _pricelbl2.text = [NSString stringWithFormat:@"%@",[_sliderdic valueForKey:@"max"]];
         
}
-(void)Get_adondata
{
    
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
    adon_dic = [dic valueForKey:@"data"];
    
    [self jsonparsing_cityType];
    _city_table.hidden = YES;
    
    
    [self jsonparsing_PartType];
    _table_parttype.hidden = YES;
    
    [self jsonparsing_BrandType];
    _table_brand.hidden = YES;

    
    [self Get_Currency];

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

-(void)jsonparsing_PartType
{
    
    parttypdata=[[NSMutableArray alloc] initWithArray:[adon_dic objectForKey:@"parts_type"]copyItems:YES];
    
    for (int i=0; i<[parttypdata count];i++)
    {
        NSDictionary *dic12 = [parttypdata objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [parttyp addObject:str1];
    }
    [_table_parttype reloadData];
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
-(void)Get_Currency
{
    
    currency = [adon_dic objectForKey:@"currency"];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
    else if (textField == _partsType)
    {
        _table_parttype.hidden = NO;
        
        [self.table_parttype reloadData];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==_city_table)
    {
        return [citytyp count];
    }
    else if(tableView==_table_brand)
    {
        return [brandtyp count];
    }
  else if (tableView==_table_parttype)
    {
        return [parttyp count];
    }

    return [pager count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (tableView==_city_table)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
        }
        cell.citylbl_partsearch.text = [citytyp objectAtIndex:indexPath.row];
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
       cell.brandtyp_partsfilter.text = [brandtyp objectAtIndex:indexPath.row];
       
       return cell;
       
   }
   else if (tableView==_table_parttype)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
        }
        cell.partlbl_partsearch.text = [parttyp objectAtIndex:indexPath.row];
        
        return cell;
        
    }

    else
    {
    static NSString *table = @"cell12";
    
    BuyPartsSearch_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
    
    [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
    if (cell == nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
        
    }
    
    cell.name.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"name"];
    
    cell.partType.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"parts_type"];
    
    cell.Manufacture.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"manufacturer"];
    
    cell.VehicleModel.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"vehicle_model"];
    
    cell.YearofManufacture.text=[NSString stringWithFormat:@"%@",[[pager objectAtIndex:indexPath.row]valueForKey:@"year_of_manufacture"]];
   cell.price.text=[NSString stringWithFormat:@"%@",[[pager objectAtIndex:indexPath.row]valueForKey:@"price"]];

   
   
    cell.PartsDetail.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"parts_detail"];
    
    NSString *curr = [NSString stringWithFormat:@"%@ %@",[currency valueForKey:@"symbol"],[[pager objectAtIndex:indexPath.row]valueForKey:@"price"]];
    
    cell.dollar.text = curr;
    
    if ([[[pager objectAtIndex:indexPath.row]valueForKey:@"images"] count] >0)
    {
        NSString *imgurl = [[[pager objectAtIndex:indexPath.row]valueForKey:@"images"] objectAtIndex:0];
        
        cell.img.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgurl]]];
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
        
        cell.contactbtn.tag=indexPath.row;
        [cell.contactbtn addTarget:self action:@selector(myCellButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (tableView==_city_table)
    {
        _city.text=[citytyp objectAtIndex:indexPath.row];
        city= [[[adon_dic valueForKey:@"city"]objectAtIndex:indexPath.row] valueForKey:@"value"];
        _city_table.hidden = YES;
    }
    else if (tableView==_table_parttype)
    {
        _partsType.text=[parttyp objectAtIndex:indexPath.row];
        part_type= [[[adon_dic valueForKey:@"parts_type"]objectAtIndex:indexPath.row] valueForKey:@"id"];
        _table_parttype.hidden = YES;
    }
    else if (tableView==_table_brand)
    {
        _brand.text=[brandtyp objectAtIndex:indexPath.row];
        brand= [[[adon_dic valueForKey:@"dealer_brand"]objectAtIndex:indexPath.row] valueForKey:@"value"];
        _table_brand.hidden = YES;
    }
    else
    {
   PostRequest_Test_Parts_ViewController *test = [self.storyboard instantiateViewControllerWithIdentifier:@"PostRequest_Test_Parts_ViewController"];

    test.buypartsdata = [pager objectAtIndex:indexPath.row];
  
    [self.navigationController pushViewController:test animated:YES];
    }
    
}

-(void)myCellButtonPressed:(UIButton *)sender
{
        UIButton *senderButton = (UIButton *)sender;
        
        NSDictionary *trip = [pager objectAtIndex:senderButton.tag];
        
        NSDictionary *vehicle = [trip valueForKey:@"contact"];
        
        BuyParts_Inquiry_ViewController *cnumber=[self.storyboard instantiateViewControllerWithIdentifier:@"BuyParts_Inquiry_ViewController"];
        
        cnumber.partid=[vehicle valueForKey:@"id"];
        
        [self.navigationController pushViewController:cnumber animated:YES];
}


-(void)GetTriplist:(NSInteger)pageno
{
    NSString *access_token = [AppMethod getStringDefault:@"default_access_token"];
    
    setdic=[[NSMutableDictionary alloc]init];
    [setdic setObject:part_type forKey:@"parts_type"];
    [setdic setObject:@"" forKey:@"keyword"];
    [setdic setObject:@"" forKey:@"manufacturer"];
    [setdic setObject:year_manu forKey:@"year_of_manufacture"];
    [setdic setObject:@"" forKey:@"vehicle_model"];
    [setdic setObject:@"" forKey:@"parts_type"];
    [setdic setObject:price_rng forKey:@"price"];
    [setdic setObject:city forKey:@"city"];
    [setdic setObject:brand forKey:@"brand"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     [ProgressHUD show:@"Please wait..."];
    
    [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
    
    NSString *partsurl =[NSString stringWithFormat:@"%@?page=%d",[baseurl stringByAppendingString:BuyPartsSearchurl],pageno];
    
    [manager POST:partsurl parameters:setdic progress:nil success:^(NSURLSessionTask *task, id partresponse)
     {
         
         _dic1 = [partresponse valueForKey:@"data"];
         
         NSMutableArray *pagerlist=[_dic1 valueForKey:@"pager"];
         
         for (int i=0; i<[pagerlist count]; i++)
         {
             [pager addObject:[pagerlist objectAtIndex:i]];
         }
         [_table_parts reloadData];
          [ProgressHUD dismiss];
         
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [al show];
          [ProgressHUD dismiss];
     }];

}
- (IBAction)PostRequestbtn:(id)sender
{
    PostRequest_Parts_ViewController *post = [self.storyboard instantiateViewControllerWithIdentifier:@"PostRequest_Parts_ViewController"];
    [self.navigationController pushViewController:post animated:YES];
}


- (IBAction)filter_parts:(id)sender
{
     _viewfilter.hidden = NO;

}


- (IBAction)clearbtn:(id)sender
{
    [pager removeAllObjects];
    part_type = @"";
    year_manu = @"";
    price_rng = @"";
    brand = @"";
    city = @"";
    
    _pageno=1;
    [self GetTriplist:_pageno];
    _viewfilter.hidden = YES;
    
}

- (IBAction)Applybtn:(id)sender
{
   [pager removeAllObjects];
    
    part_type = _partsType.text;
    year_manu = _Yearofmanufacture.text;
    price_rng = _pricelbl1.text;
    brand = _brand.text;
    city = _city.text;
    
    _pageno = 1;
    [self GetTriplist:_pageno];
    _viewfilter.hidden = YES;

    
}

- (IBAction)SlidervalueChange:(UISlider *)sender
{
    NSLog(@"slider value = %f", sender.value);
    int value = (int)sender.value;
    _pricelbl1.text = [NSString stringWithFormat:@"%d",value];
}

- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)dropdown_city:(id)sender
{
    _city_table.hidden = NO;
}
- (IBAction)dropdown_part:(id)sender
{
  _table_parttype.hidden = NO;
}
- (IBAction)dropdown_brand:(id)sender
{
    _table_brand.hidden = NO;
}
@end
