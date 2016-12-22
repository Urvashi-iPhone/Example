//
//  HireSearch_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/5/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "HireSearch_ViewController.h"
#import "HireSearch_TableViewCell.h"
#import "HireInquiry_ViewController.h"
#import "httpws.h"
#import "Constant.h"
#import "AppMethod.h"
#import "PostRequestTest_ViewController.h"
#import "PostRequest_Hire_ViewController.h"
#import "SWRevealViewController.h"
#import "HCSStarRatingView.h"
#import "Hire_ViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"

@interface HireSearch_ViewController ()

@end

@implementation HireSearch_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlview.contentSize = contentRect.size;
    
    
    
    
    from_address = _Fromsearch;
    to_address = _Tosearch;
    capacity = @"";
    price = @"";
    start_time = _Datesearch;
    is_gps_enable = @"";
    cargo_type = @"";
    part_load_available = @"";
    
    
    adon_dic = [[NSDictionary alloc]init];
    hireser1 = [[NSMutableArray alloc]init];
    cargo = [[NSMutableArray alloc]init];
  
    
    [self Get_adondata];
    
    vehicle_typelist = [[NSMutableArray alloc]init];
    
     pager=[[NSMutableArray alloc]init];
    _pageno=1;
    [self GetTriplist:_pageno];
    
    _datePicker.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1.0f];
    
    _toolbar.hidden = true;
    _datePicker.hidden = true;
    [_startDateRange setDelegate:self];
    
   
    _post_required_here.layer.cornerRadius = 17;
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    
    
    clickflag=[[NSMutableArray alloc]init];
    
     _view_filter.hidden = YES;
    
    _sliderdic = [[NSDictionary alloc]init];
    [self AllSlider_Value];
    
   
    
    [_IsGPS_checkbtn2 addTarget:self action:@selector(ChkUnChk:) forControlEvents:UIControlEventTouchUpInside];
    [_IsGPS_uncheckbtn addTarget:self action:@selector(ChkUnChk:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didRecognizeTapGesture:)];
    [self.startDateRange.superview addGestureRecognizer:tapGesture];

    
}

- (void)didRecognizeTapGesture:(UITapGestureRecognizer*)gesture
{
    CGPoint point = [gesture locationInView:gesture.view];
    
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        _startDateRange.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datePicker.date]];
        _datePicker.hidden = false;
        _toolbar.hidden = false;
    }
}

- (IBAction)TextfieldClicked:(id)sender
{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
//    _startDateRange.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datePicker.date]];
//    _datePicker.hidden = false;
//    _toolbar.hidden = false;
//
}

- (IBAction)canclebtn:(id)sender
{
    _datePicker.hidden = true;
    _toolbar.hidden = true;
    _startDateRange.text = @"";
}

- (IBAction)Donebtn:(id)sender
{
    _datePicker.hidden = true;
    _toolbar.hidden = true;
    
}
- (IBAction)datePickerChanged:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    _startDateRange.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datePicker.date]];
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}




-(void)Get_adondata
{
    
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
    adon_dic = [dic valueForKey:@"data"];
    [self Get_Currency];
    [self jsonparsing_servicedetail];
    [self jsonparsing_CargoType];
    _cargo_tabledata.hidden = YES;
}


//-(void)datepickerset
//{
//    
//    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
//    [datePicker setDate:[NSDate date]];
//    datePicker.datePickerMode = UIDatePickerModeDate;
//    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
//    [_startDateRange setInputView:datePicker];
//    
//}
//
//-(void) dateTextField:(id)sender
//{
//    UIDatePicker *picker = (UIDatePicker*)_startDateRange.inputView;
//    [picker setMaximumDate:[NSDate date]];
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    NSDate *eventDate = picker.date;
//    [dateFormat setDateFormat:@"dd/MM/yyyy"];
//    NSString *dateString = [dateFormat stringFromDate:eventDate];
//    _startDateRange.text = [NSString stringWithFormat:@"%@",dateString];
//    
//}
//

-(void)jsonparsing_CargoType
{
    
    cargotype=[[NSMutableArray alloc] initWithArray:[adon_dic objectForKey:@"cargo_type"]copyItems:YES];
    
    for (int i=0; i<[cargotype count];i++)
    {
        NSDictionary *dic12 = [cargotype objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [cargo addObject:str1];
    }
    [_cargo_tabledata reloadData];
}

-(void)textFieldDidChange:(UITextField *)textField
{
    _cargo_tabledata.hidden = NO;
    
    [self.cargo_tabledata reloadData];
}

-(void)jsonparsing_servicedetail
{
   
    
 hireser_type=[[NSMutableArray alloc] initWithArray:[adon_dic objectForKey:@"vehicle_type"]copyItems:YES];
  
    
    for (int i=0; i<[hireser_type count];i++)
    {
        NSDictionary *dic12 = [hireser_type objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [hireser1 addObject:str1];
        
    }
    [_Table_VehicleType reloadData];
}

-(void)Get_Currency
{
   
    Currency = [adon_dic objectForKey:@"currency"];
 
}
-(void)AllSlider_Value
{
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_Filter"]];
    _sliderdic = [dic valueForKey:@"data"];
    [self SliderValue_Price];
    [self SliderValue_Capacity];

    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//     [ProgressHUD show:@"Please wait..."];
//    
//    NSDictionary *filterbaseurl = [baseurl stringByAppendingString:Filterurl];
//    
//    [manager GET:filterbaseurl parameters:nil progress:nil success:^(NSURLSessionTask *task, id Sliderresponse)
//     {
//       
//         _sliderdic = [Sliderresponse valueForKey:@"data"];
//         NSLog(@"%@",_sliderdic);
//         [self SliderValue_Price];
//         [self SliderValue_Capacity];
//          [ProgressHUD dismiss];
//         
//     }failure:^(NSURLSessionTask *operation, NSError *error)
//     {
//         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//         [al show];
//          [ProgressHUD dismiss];
//     }];
 
}

-(void)SliderValue_Price
{
         NSDictionary *slidervalue = [[NSDictionary alloc] init];
         slidervalue = [[_sliderdic valueForKey:@"trip"] valueForKey:@"price_range"];
         NSLog(@"%@",slidervalue);
         
        [_PriceSlider setMaximumValue:[[slidervalue valueForKey:@"max"]floatValue]];
        _Pricelbl1.text = [NSString stringWithFormat:@"%@",[slidervalue valueForKey:@"min"]];
        _Pricelbl2.text = [NSString stringWithFormat:@"%@",[slidervalue valueForKey:@"max"]];
         
    
}

-(void)SliderValue_Capacity
{
    
    NSDictionary *slidervalue = [[NSDictionary alloc] init];
    slidervalue = [[_sliderdic valueForKey:@"trip"] valueForKey:@"capacity_range"];
    NSLog(@"%@",slidervalue);
    
    [_CapacitySlider setMaximumValue:[[slidervalue valueForKey:@"max"]floatValue]];
    _Capacitylbl1.text = [NSString stringWithFormat:@"%@",[slidervalue valueForKey:@"min"]];
    _Capacitylbl2.text = [NSString stringWithFormat:@"%@",[slidervalue valueForKey:@"max"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_table_trip)
    {
        return [pager count];
    }
    else if (tableView == _cargo_tabledata)
    {
        return [cargo count];
    }
    else
    {
        return [hireser1 count];
    }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_table_trip)
    {
        static NSString *table = @"cell12";
    
        HireSearch_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
        }
        
        cell.name.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"title"];
        
        cell.from.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"from_address"];
        
        cell.startdate.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"start_time"];
        
        NSString *vehicletype = [[[pager objectAtIndex:indexPath.row]valueForKey:@"vehicle"]valueForKey:@"vehicle_type_id"];
        
        cell.vehicletyp.text=vehicletype;
        
        cell.to.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"to_address"];
    
        NSString *capacity = [NSString stringWithFormat:@"%@",[[[pager objectAtIndex:indexPath.row]valueForKey:@"vehicle"]valueForKey:@"capacity" ]];
    
        cell.capacity.text=capacity;
    
        cell.cargotyp.text=[[pager objectAtIndex:indexPath.row]valueForKey:@"cargo_type_id"];
        
        
        NSString *curr = [NSString stringWithFormat:@"%@ %@",[Currency valueForKey:@"symbol"],[[pager objectAtIndex:indexPath.row]valueForKey:@"price"]];
        
        cell.doller.text = curr;
        
        float abc = [[[[pager objectAtIndex:indexPath.row]valueForKey:@"review"] valueForKey:@"overAll"] floatValue];
        
        
        [cell.rateview setValue:abc];
        
     cell.imagetyp.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[pager objectAtIndex:indexPath.row]valueForKey:@"user"]valueForKey:@"avatar"]]]];
       
        
        
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
    else if (tableView == _cargo_tabledata)
    {
        static NSString *table = @"cell2";
        
        HireSearch_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        cell.cargolbl.text = [cargo objectAtIndex:indexPath.row];
        return cell;
    }
    else
    {
        static NSString *table = @"cell1";
        
        HireSearch_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
        }
        
        cell.vehicleType.text = [hireser1 objectAtIndex:indexPath.row];
        
        cell.uncheckbtn.tag=indexPath.row;
        [cell.uncheckbtn addTarget:self action:@selector(ChkUnChk:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;

    }


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
    if (tableView==_table_trip)
    {
    PostRequestTest_ViewController *test = [self.storyboard instantiateViewControllerWithIdentifier:@"PostRequestTest_ViewController"];
      test.tripdata = [pager objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:test animated:YES];
    }
    else if (tableView == _cargo_tabledata)
    {
        _CargoType.text=[cargo objectAtIndex:indexPath.row];
        
        cargo_type = [[[adon_dic valueForKey:@"cargo_type"]objectAtIndex:indexPath.row] valueForKey:@"id"];
        
        _cargo_tabledata.hidden = YES;
  
    }

}

-(void)myCellButtonPressed:(UIButton *)sender
{
    
    UIButton *senderButton = (UIButton *)sender;
   
    NSDictionary *trip = [pager objectAtIndex:senderButton.tag];
    
    NSDictionary *vehicle = [trip valueForKey:@"vehicle"];
    
    HireInquiry_ViewController *cnumber=[self.storyboard instantiateViewControllerWithIdentifier:@"HireInquiry_ViewController"];
    
    cnumber.tripid=[vehicle valueForKey:@"trip_id"];
    
    [self.navigationController pushViewController:cnumber animated:YES];
    
}
-(void)GetTriplist:(NSInteger)pageno
{
    
    setdic=[[NSMutableDictionary alloc]init];
    [setdic setObject:from_address forKey:@"from_address"];
    [setdic setObject:to_address forKey:@"to_address"];
    [setdic setObject:capacity forKey:@"capacity"];
    [setdic setObject:price forKey:@"price"];
    [setdic setObject:start_time forKey:@"start_time"];
    [setdic setValue:cargo_type forKey:@"cargo_type_id"];
    [setdic setObject:part_load_available forKey:@"part_load_available"];
    [setdic setObject:vehicle_typelist forKey:@"vehicle_type_id"];
    [setdic setObject:is_gps_enable forKey:@"is_gps_enable"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [ProgressHUD show:@"Please wait..."];
    
   [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
    
    NSString *tripurl=[NSString stringWithFormat:@"%@?page=%d",[baseurl stringByAppendingString:hireSearchurl],pageno];
    
  
    
    [manager POST:tripurl parameters:setdic progress:nil success:^(NSURLSessionTask *task, id hireresponse)
     {
    
       _dic1 = [hireresponse valueForKey:@"data"];

         NSMutableArray *pagerlist=[_dic1 valueForKey:@"pager"];
         
         for (int i=0; i<[pagerlist count]; i++)
         {
             [pager addObject:[pagerlist objectAtIndex:i]];
         }
         [_table_trip reloadData];
         [ProgressHUD dismiss];
         
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [al show];
         [ProgressHUD dismiss];
     }];

    
 }

- (IBAction)post_Require_Here:(id)sender
{
    PostRequest_Hire_ViewController *req = [self.storyboard instantiateViewControllerWithIdentifier:@"PostRequest_Hire_ViewController"];
    [self.navigationController pushViewController:req animated:YES];
}

- (IBAction)hire_filter:(id)sender
{
    _view_filter.hidden = NO;
}
- (IBAction)PriceSlider:(UISlider *)sender
{
    int value = (int)sender.value;
    _Pricelbl1.text = [NSString stringWithFormat:@"%d",value];
    
   
}

- (IBAction)CapacitySlider:(UISlider *)sender
{
    int value = (int)sender.value;
    _Capacitylbl1.text = [NSString stringWithFormat:@"%d",value];

}
- (IBAction)dropdown_cargo:(id)sender
{
  _cargo_tabledata.hidden = NO;
}

- (IBAction)clearbtn:(id)sender
{
    
    [pager removeAllObjects];
    
    from_address = @"";
    to_address = @"";
    capacity = @"";
    price = @"";
    start_time = @"";
    is_gps_enable = @"";
    cargo_type = @"";
    part_load_available = @"";
    
    [vehicle_typelist removeAllObjects];
    
    _pageno=1;
    [self GetTriplist:_pageno];
    _view_filter.hidden = YES;
}

- (IBAction)Applybtn:(id)sender
{
    [pager removeAllObjects];
    
    from_address = @"";
    to_address = @"";
    
    capacity = _Capacitylbl1.text;
    price = _Pricelbl1.text;
    start_time = _startDateRange.text;
    part_load_available = _PastLoad.text;
    
    [vehicle_typelist removeAllObjects];
    for (int i=0; i<[clickflag count]; i++)
    {
        [vehicle_typelist addObject:[[[adon_dic valueForKey:@"vehicle_type"] objectAtIndex:[[clickflag objectAtIndex:i] intValue]] valueForKey:@"id"]];
    }
    
    is_gps_enable = @"";
    
    _pageno = 1;
    [self GetTriplist:_pageno];
    _view_filter.hidden = YES;
    
}
- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
