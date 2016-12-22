//
//  Edit_Trip_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/24/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "Edit_Trip_ViewController.h"
#import "SWRevealViewController.h"
#import "Constant.h"
#import "AppMethod.h"
#import "httpws.h"
#import "Vehicle_Type_Capacity_New_TableViewCell.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"

@interface Edit_Trip_ViewController ()

@end
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
@implementation Edit_Trip_ViewController


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
    
    
     _viewFilter.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];
    
    _viewFilter.layer.borderWidth= 1.0f;
    _viewFilter.layer.cornerRadius = 15.0;
    _camerabtn.layer.cornerRadius = 17.0;
    _galarybtn.layer.cornerRadius = 17.0;

    
    _border1.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];
    _border1.layer.borderWidth= 1.0f;
    _border1.layer.cornerRadius = 15.0;
    
    _border2.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _border2.layer.borderWidth= 1.0f;
    _border2.layer.cornerRadius = 15.0;
    _border3.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _border3.layer.borderWidth= 1.0f;
    _border3.layer.cornerRadius = 15.0;
    
    _updatebtn.layer.cornerRadius = 19.0;
    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    adondata = [[NSDictionary alloc]init];
    vtype = [[NSMutableArray alloc]init];
    capacitytyp = [[NSMutableArray alloc]init];
    cargo = [[NSMutableArray alloc]init];
    permit = [[NSMutableArray alloc]init];
    
    vehicle_type = @"";
    cargo_type = @"";
    permitt = @"";
    
    [self Get_adondata];
   
    _isGPS_table.hidden = YES;
    isGPStyp=[[NSArray alloc]initWithObjects:@"Enable",@"Disable",nil];
    
    _statustyp_table.hidden = YES;
    statustyp=[[NSArray alloc]initWithObjects:@"Active",@"Inactive",nil];
    
    
    _Description.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _Description.layer.borderWidth = 1.0f;
    _Description.layer.cornerRadius = 5;
    
    _loadAddress.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _loadAddress.layer.borderWidth = 1.0f;
    _loadAddress.layer.cornerRadius = 5;
    
    _UnloadingAdd.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _UnloadingAdd.layer.borderWidth = 1.0f;
    _UnloadingAdd.layer.cornerRadius = 5;
    
    _Description.text = @"Description";
    _Description.delegate = self;
    _Description.textColor = [UIColor lightGrayColor];
    
     _loadAddress.text = @"Loading Address";
    _loadAddress.delegate = self;
    _loadAddress.textColor = [UIColor lightGrayColor];
    
     _UnloadingAdd.text = @"Unloading Address";
    _UnloadingAdd.delegate = self;
    _UnloadingAdd.textColor = [UIColor lightGrayColor];
    
    
    [self EditTripDataGet];
    _viewFilter.hidden = YES;
    
    _datepicker.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1.0f];
    _toolbar.hidden = true;
    _datepicker.hidden = true;
    
    [_starttime setDelegate:self];
    [_endtime setDelegate:self];
    _starttime.tag = 1;
    _endtime.tag = 2;
    
    [self setupAlerts];
    [self Validation_Delegate];

    
    // Do any additional setup after loading the view.
}
-(void)Validation_Delegate
{
    _Title.delegate=self;
    _Title.presentInView=self.view;
    
    _fromAdd.delegate=self;
    _fromAdd.presentInView=self.view;
    
    _ToAdd.delegate=self;
    _ToAdd.presentInView=self.view;
    
    _approxDist.delegate=self;
    _approxDist.presentInView=self.view;
    
    _price.delegate=self;
    _price.presentInView=self.view;
    
    _partLoad.delegate=self;
    _partLoad.presentInView=self.view;
    
    _brand.delegate=self;
    _brand.presentInView=self.view;
    
    _model.delegate=self;
    _model.presentInView=self.view;
    
    _capacity.delegate=self;
    _capacity.presentInView=self.view;
    
    _vehicleNO.delegate=self;
    _vehicleNO.presentInView=self.view;
    
//    _descriptionTxt.delegate=self;
//    _descriptionTxt.presentInView=self.view;
//    
//    _lodingTxt.delegate=self;
//    _lodingTxt.presentInView=self.view;
//    
//    _UnlodingTxt.delegate=self;
//    _UnlodingTxt.presentInView=self.view;
    
    
}

-(void)setupAlerts
{
    
    [_Title addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Title can not be blank."];
    
    [_fromAdd addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"From Address can not be blank."];
    
    [_ToAdd addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"To Address can not be blank."];
    
    [_approxDist addRegx:REGEX_FLOAT withMsg:@"Approx Distance can not be blank."];
    
    [_price addRegx:REGEX_FLOAT withMsg:@"Price can not be blank."];
    
    [_partLoad addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Part Load can not be blank."];
    
    [_brand addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Brand can not be blank."];
    
    [_model addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Model can not be blank."];
    
    [_capacity addRegx:REGEX_FLOAT withMsg:@"Capacity can not be blank."];
    
    [_vehicleNO addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Vehicle Number can not be blank."];
    
//    [_descriptionTxt addRegx:REGEX_TEXTVIEW withMsg:@"Description can not be blank."];
//    
//    [_lodingTxt addRegx:REGEX_TEXTVIEW withMsg:@"Loading Address can not be blank."];
//    
//    [_UnlodingTxt addRegx:REGEX_TEXTVIEW withMsg:@"Unloading Address can not be blank."];
    
}



- (IBAction)Start_click:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    _donebtn.tag = 1;
    _cancelbtn.tag = 1;
    
    [_datepicker setDate:[AppMethod getDateFromString:@"dd-MM-yyyy" :_starttime.text]];
    
    _starttime.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datepicker.date]];
    _datepicker.hidden = false;
    _toolbar.hidden = false;
    _starttime.enabled = NO;
    
}

- (IBAction)End_click:(id)sender
{
    _endtime.enabled = NO;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    _donebtn.tag = 2;
    _cancelbtn.tag = 2;
    
    [_datepicker setDate:[AppMethod getDateFromString:@"dd-MM-yyyy" :_endtime.text]];
    
    _endtime.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datepicker.date]];
    _datepicker.hidden = false;
    _toolbar.hidden = false;
    
}

- (IBAction)cancelbtn:(id)sender
{
    UIButton *cancle = (UIButton *)sender;
    
    if (cancle.tag == 1)
    {
        _datepicker.hidden = true;
        _toolbar.hidden = true;
        //_starttime.text = @"";
        _endtime.enabled = YES;
    }
    else
    {
        _datepicker.hidden = true;
        _toolbar.hidden = true;
        //_starttime.text = @"";
        _endtime.enabled = YES;
    }
    
}

- (IBAction)donebtn:(id)sender
{
    UIButton *done = (UIButton*)sender;
    
    if (done.tag == 1)
    {
        _datepicker.hidden = true;
        _toolbar.hidden = true;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        _starttime.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datepicker.date]];
        _starttime.enabled = YES;
    }
    else
    {
        _datepicker.hidden = true;
        _toolbar.hidden = true;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        _endtime.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datepicker.date]];
        _endtime.enabled = YES;
    }
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    UITextField *txt = (UITextField *)textField;
    
    if (txt.tag == 1 || txt.tag == 2)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView == _Description)
    {
        _Description.text = @"";
        _Description.textColor = [UIColor blackColor];
        return YES;
        
    }
    else if (textView == _loadAddress)
    {
        _loadAddress.text = @"";
        _loadAddress.textColor = [UIColor blackColor];
        return YES;
    }
    else
    {
        _UnloadingAdd.text = @"";
        _UnloadingAdd.textColor = [UIColor blackColor];
        return YES;
    }
    return nil;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if (textView == _Description)
    {
        if(_Description.text.length == 0)
        {
            _Description.textColor = [UIColor lightGrayColor];
            _Description.text = @"Description";
            [_Description resignFirstResponder];
        }
        
    }
    else if (textView == _loadAddress)
    {
        if(_loadAddress.text.length == 0)
        {
            _loadAddress.textColor = [UIColor lightGrayColor];
            _loadAddress.text = @"Loading Address";
            [_loadAddress resignFirstResponder];
        }
        
    }
    else
    {
        if(_UnloadingAdd.text.length == 0)
        {
            _UnloadingAdd.textColor = [UIColor lightGrayColor];
            _UnloadingAdd.text = @"Unloading Address";
            [_UnloadingAdd resignFirstResponder];
        }
    }
}

-(void)EditTripDataGet
{
    NSDictionary *tripdata = _Tripedit;
    
    _Title.text=[tripdata valueForKey:@"title"];
    _fromAdd.text=[tripdata valueForKey:@"from_address"];
    _ToAdd.text=[tripdata valueForKey:@"to_address"];
    
    NSDate *startDate = [AppMethod getDateFromString:@"MMM dd, yyyy" :[tripdata valueForKey:@"start_time"]];
    
    _starttime.text=[AppMethod getDateInFormate:startDate :@"dd-MM-yyyy"];
    
    NSDate *endDate = [AppMethod getDateFromString:@"MMM dd, yyyy" :[tripdata valueForKey:@"end_time"]];
    
    _endtime.text=[AppMethod getDateInFormate:endDate :@"dd-MM-yyyy"];
    _approxDist.text=[NSString stringWithFormat:@"%@",[tripdata valueForKey:@"apprx_distance"]];
    _price.text=[NSString stringWithFormat:@"%@",[tripdata valueForKey:@"price"]];
    _partLoad.text=[tripdata valueForKey:@"part_load_available"];
    
    if ([[NSString stringWithFormat:@"%@",[tripdata valueForKey:@"status"]] isEqualToString:@"1"])
    {
        _status.text = @"Inactive";
    }
    else
    {
        _status.text = @"Active";
    }

    
    _cargotyp.text=[tripdata valueForKey:@"cargo_type_id"];
    _Description.text=[tripdata valueForKey:@"description"];
    _loadAddress.text=[tripdata valueForKey:@"loading_adddress"];
    _UnloadingAdd.text=[tripdata valueForKey:@"unloading_address"];
    
    _brand.text = [[tripdata valueForKey:@"vehicle"] valueForKey:@"brand"];
    _model.text = [[tripdata valueForKey:@"vehicle"] valueForKey:@"model"];
    _capacity.text = [NSString stringWithFormat:@"%@",[[tripdata valueForKey:@"vehicle"]valueForKey:@"capacity"]];
    _capacity_unit.text = [[tripdata valueForKey:@"vehicle"] valueForKey:@"capacity_unit"];
    
    int y = [NSString stringWithFormat:@"%@",[[tripdata valueForKey:@"vehicle"] valueForKey:@"permit"]];
    
    NSString *strY=[NSString stringWithFormat:@"%d",y];
    

    _permittyp.text = [NSString stringWithFormat:@"%@",[[tripdata valueForKey:@"vehicle"] valueForKey:@"permit"]];
    
    if ([[[tripdata valueForKey:@"vehicle"] valueForKey:@"permit"] isEqualToString:@"0"])
    {
        _permittyp.text = @"All India Permit";
    }
    else
    {
        _permittyp.text = @"State Permit";
 
    }
    _vehicleType.text = [[tripdata valueForKey:@"vehicle"] valueForKey:@"vehicle_type_id"];
    _isGPS.text = [[tripdata valueForKey:@"vehicle"] valueForKey:@"is_gps_enable"];
    _vehicleNO.text = [[tripdata valueForKey:@"vehicle"] valueForKey:@"vehicle_no"];
    
        NSURL *url = [NSURL URLWithString:[[tripdata valueForKey:@"vehicle"] valueForKey:@"image"]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        _img.image = img;
  
 }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)Get_adondata
{
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];;
      adondata = [dic valueForKey:@"data"];
    
    [self jsonparsing_VehicleType];
    _VehicleType_table.hidden = YES;
    
    [self jsonparsing_capacityUnitType];
    _Capacity_Unit_table.hidden = YES;
    
    
    [self jsonparsing_CargoType];
    _cargoType_table.hidden = YES;
    
    
    [self jsonparsing_PermitType];
    _Permittype_table.hidden = YES;
}
-(void)jsonparsing_PermitType
{
    permittype=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"permit_type"]copyItems:YES];
    
    for (int i=0; i<[permittype count];i++)
    {
        NSDictionary *dic12 = [permittype objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [permit addObject:str1];
    }
    [_Permittype_table reloadData];
}

-(void)jsonparsing_VehicleType
{
    vtypedata=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"vehicle_type"]copyItems:YES];
    
    for (int i=0; i<[vtypedata count];i++)
    {
        NSDictionary *dic12 = [vtypedata objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [vtype addObject:str1];
    }
    [_VehicleType_table reloadData];
}
-(void)jsonparsing_capacityUnitType
{
    capacityUnittype=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"capacity_unit"]copyItems:YES];
    
    for (int i=0; i<[capacityUnittype count];i++)
    {
        NSDictionary *dic12 = [capacityUnittype objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [capacitytyp addObject:str1];
    }
    [_Capacity_Unit_table reloadData];
}
-(void)jsonparsing_CargoType
{
    cargotyp=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"cargo_type"]copyItems:YES];
    
    for (int i=0; i<[cargotyp count];i++)
    {
        NSDictionary *dic12 = [cargotyp objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [cargo addObject:str1];
    }
    [_cargoType_table reloadData];
}


-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == _vehicleType)
    {
        _VehicleType_table.hidden = NO;
        
        [self.VehicleType_table reloadData];
        
    }
    else if (textField == _status)
    {
        _statustyp_table.hidden = NO;
        
        [self.statustyp_table reloadData];
    }
    else if (textField == _cargotyp)
    {
        _cargoType_table.hidden = NO;
        
        [self.cargoType_table reloadData];
    }
    else if (textField == _permittyp)
    {
        _Permittype_table.hidden = NO;
        
        [self.Permittype_table reloadData];
    }
    else if (textField == _isGPS)
    {
        _isGPS_table.hidden = NO;
        
        [self.isGPS_table reloadData];
    }
    else
    {
        _Capacity_Unit_table.hidden = NO;
        
        [self.Capacity_Unit_table reloadData];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_VehicleType_table)
    {
        return [vtype count];
    }
    else if(tableView==_Capacity_Unit_table)
    {
        return [capacitytyp count];
    }
    else if(tableView==_statustyp_table)
    {
        return [statustyp count];
    }
    else if(tableView==_cargoType_table)
    {
        return [cargo count];
    }
    else if(tableView==_Permittype_table)
    {
        return [permit count];
    }
    
    else
    {
        return [isGPStyp count];
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_VehicleType_table)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
        }
        cell.vehicletypelbl_editTrip.text = [vtype objectAtIndex:indexPath.row];
        
        return cell;
        
    }
    else if (tableView == _Capacity_Unit_table)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        
        cell.capacitylbl_editTrip.text = [capacitytyp objectAtIndex:indexPath.row];
        return cell;
    }
    
    else if (tableView == _cargoType_table)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        
        cell.cargolbl_editTrip.text = [cargo objectAtIndex:indexPath.row];
        return cell;
    }
    else if (tableView == _statustyp_table)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        
        cell.statuslbl_editTrip.text = [statustyp objectAtIndex:indexPath.row];
        return cell;
    }
    else if (tableView == _Permittype_table)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        
        cell.permitlbl_editTrip.text = [permit objectAtIndex:indexPath.row];
        return cell;
    }
    else
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        
        cell.isGpslbl_editTrip.text = [isGPStyp objectAtIndex:indexPath.row];
        return cell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_VehicleType_table)
    {
        _vehicleType.text=[vtype objectAtIndex:indexPath.row];
        vehicle_type = [[[adondata valueForKey:@"vehicle_type"]objectAtIndex:indexPath.row] valueForKey:@"id"];
        _VehicleType_table.hidden = YES;
    }
    else if (tableView == _Capacity_Unit_table)
    {
        _capacity_unit.text=[capacitytyp objectAtIndex:indexPath.row];
        _Capacity_Unit_table.hidden = YES;
    }
    else if (tableView == _cargoType_table)
    {
        _cargotyp.text=[cargo objectAtIndex:indexPath.row];
         cargo_type = [[[adondata valueForKey:@"cargo_type"]objectAtIndex:indexPath.row] valueForKey:@"id"];
        _cargoType_table.hidden = YES;
    }
    
    else if (tableView == _statustyp_table)
    {
        _status.text=[statustyp objectAtIndex:indexPath.row];
        _statustyp_table.hidden = YES;
    }
    else if (tableView == _Permittype_table)
    {
        _permittyp.text=[permit objectAtIndex:indexPath.row];
        _Permittype_table.hidden = YES;
    }
    else if (tableView == _isGPS_table)
    {
        _isGPS.text=[isGPStyp objectAtIndex:indexPath.row];
        _isGPS_table.hidden = YES;
    }

}


- (IBAction)Updatebtn:(id)sender
{
    title=_Title.text;
    from_add=_fromAdd.text;
    to_add=_ToAdd.text;
    start_time=_starttime.text;
    end_time=_endtime.text;
    approx_dist=_approxDist.text;
    price=_price.text;
    parts_load=_partLoad.text;
    status=_status.text;
   
    descri=_Description.text;
    load_add=_loadAddress.text;
    unload_add=_UnloadingAdd.text;
    brand=_brand.text;
    model=_model.text;
    capacity=_capacity.text;
    capacity_unit=_capacity_unit.text;
    permit=_permittyp.text;
    gps=_isGPS.text;
    vehicle_no=_vehicleNO.text;

    if([_Title validate] & [_fromAdd validate] & [_ToAdd validate] & [_approxDist validate] & [_price validate] & [_partLoad validate] & [_brand validate] & [_model validate] & [_capacity validate] & [_vehicleNO validate])
    {

        setdic=[[NSMutableDictionary alloc]init];
    
        [setdic setValue:[_Tripedit valueForKey:@"id"] forKey:@"id"];
        
        [setdic setObject:title forKey:@"title"];
    
        [setdic setObject:from_add forKey:@"from_address"];
        [setdic setObject:to_add forKey:@"to_address"];
        [setdic setObject:start_time forKey:@"start_time"];
        [setdic setObject:end_time forKey:@"end_time"];
        [setdic setObject:approx_dist forKey:@"apprx_distance"];
        [setdic setObject:price forKey:@"price"];
        [setdic setObject:parts_load forKey:@"part_load_available"];
    
    if ([status isEqualToString:@"Active"])
    {
        [setdic setObject:@"1" forKey:@"status"];
    }
    else
    {
        [setdic setObject:@"0" forKey:@"status"];
        
    }
    

    if ([cargo_type isEqualToString:@""])
    {
        [setdic setObject:[[[adondata valueForKey:@"cargo_type"]objectAtIndex:0] valueForKey:@"id"] forKey:@"cargo_type_id"];
    }
    else
    {
        [setdic setObject:cargo_type forKey:@"cargo_type_id"];
    }

    
        [setdic setObject:descri forKey:@"description"];
        [setdic setObject:load_add forKey:@"loading_adddress"];
        [setdic setObject:unload_add forKey:@"unloading_address"];
        [setdic setObject:brand forKey:@"brand"];
        [setdic setObject:model forKey:@"model"];
        [setdic setObject:capacity forKey:@"capacity"];
    
    if ([capacity_unit isEqualToString:@""])
    {
        [setdic setObject:[capacitytyp objectAtIndex:0] forKey:@"capacity_unit"];
    }
    else
    {
        [setdic setObject:capacity_unit forKey:@"capacity_unit"];
    }
    
    
    if ([permitt isEqualToString:@""])
    {
        [setdic setObject:[[[adondata valueForKey:@"permit_type"]objectAtIndex:0]valueForKey:@"id"] forKey:@"permit"];
    }
    else
    {
        [setdic setObject:permitt forKey:@"permit"];
    }

    
    if ([vehicle_type isEqualToString:@""])
    {
        [setdic setObject:[[[adondata valueForKey:@"vehicle_type"] objectAtIndex:0]valueForKey:@"id"] forKey:@"vehicle_type_id"];
        
    }
    else
    {
        [setdic setObject:vehicle_type forKey:@"vehicle_type_id"];
        
    }

    
    if ([gps isEqualToString:@"Enable"])
    {
        [setdic setObject:@"1" forKey:@"is_gps_enable"];
    }
    else
    {
        [setdic setObject:@"2" forKey:@"is_gps_enable"];
    }

    
        [setdic setObject:vehicle_no forKey:@"vehicle_no"];
    
        [setdic setObject:[self imageToNSString:_img.image] forKey:@"image"];
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [ProgressHUD show:@"Please wait..."];
   
    [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
    [manager PUT:[baseurl stringByAppendingString:EditTripurl] parameters:setdic success:^(NSURLSessionTask *task, id dic12)
     {
         
         BOOL boolean = [[dic12 valueForKey:@"status"] boolValue];
         if (boolean)
         {
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:[dic12 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
             [al show];
             
         }
         [ProgressHUD dismiss];

     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
         [al show];
         [ProgressHUD dismiss];

     }];
    }
}
- (NSString *)imageToNSString:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
        SWRevealViewController *inq = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        [self.navigationController pushViewController:inq animated:YES];
        
        
    }
}
- (IBAction)dropdown_status:(id)sender
{
    _statustyp_table.hidden = NO;
}
- (IBAction)dropdown_cargo:(id)sender
{
    _cargoType_table.hidden = NO;
}
- (IBAction)dropdown_vehicleTyp:(id)sender
{
    _VehicleType_table.hidden = NO;
}
- (IBAction)dropdown_isGPS:(id)sender
{
    _isGPS_table.hidden = NO;
}
- (IBAction)dropdown_permit:(id)sender
{
    _Permittype_table.hidden = NO;
}
- (IBAction)dropdown_capacity:(id)sender
{
    _Capacity_Unit_table.hidden = NO;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"%@",text);
    
    if([text length] == 0)
    {
        if([textView.text length] != 0)
        {
            return YES;
        }
    }
    else if([[textView text] length] > 139)
    {
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}



- (IBAction)camerabtn:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    _viewFilter.hidden = YES;
 
}
- (IBAction)galarybtn:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    _viewFilter.hidden = YES;
  
}

- (IBAction)takeImagebtn:(id)sender
{
    _viewFilter.hidden = NO;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.img.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
}
- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)closebtn:(id)sender
{
    _viewFilter.hidden = YES;
}
@end
