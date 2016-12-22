//
//  sell_vehicle_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/24/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "sell_vehicle_ViewController.h"
#import "SWRevealViewController.h"
#import "httpws.h"
#import "Constant.h"
#import "LoginViewController.h"
#import "AppMethod.h"
#import "Sell_Vehicle_TableViewCell.h"
#import "Vehicle_Type_Capacity_New_TableViewCell.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
@interface sell_vehicle_ViewController ()<UITextFieldDelegate>


@end
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@implementation sell_vehicle_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //scrlview
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    
    self.scrview.contentSize = contentRect.size;
       //[[UINavigationBar appearance]setFrame:CGRectMake(0, 0,self.view.frame.size.width, 60)];
    
    _viewGallary.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];
    _viewGallary.layer.borderWidth= 1.0f;
    _viewGallary.layer.cornerRadius = 15.0;
    _camerabtn.layer.cornerRadius = 17.0;
    _gallarybtn.layer.cornerRadius = 17.0;
    
      _imagelist = [[NSMutableArray alloc]init];
      _viewborder1.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];
    _viewborder1.layer.borderWidth= 1.0f;
    _viewborder1.layer.cornerRadius = 15.0;
    
      _viewborder2.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _viewborder2.layer.borderWidth= 1.0f;
    _viewborder2.layer.cornerRadius = 15.0;
    _createbtn.layer.cornerRadius = 19.0;
    _AddImage.layer.cornerRadius = 19.0;
    
    [self.navigationItem setTitle:@"Sell Vehicle"];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    adondata = [[NSDictionary alloc]init];
    vtype = [[NSMutableArray alloc]init];
    citytyp = [[NSMutableArray alloc]init];
    capacityUnit = [[NSMutableArray alloc]init];
    brandtyp = [[NSMutableArray alloc]init];
    [self Get_Adondata];
    
    
   
    
    
    _fual_tabledata.hidden = YES;
    fualtyp=[[NSArray alloc]initWithObjects:@"Petrol",@"Diesel",nil];
    
    _isnew_tabledata.hidden = YES;
    isnewtyp=[[NSArray alloc]initWithObjects:@"New",@"Old",nil];
    
    _status_tabledata.hidden = YES;
    statustype=[[NSArray alloc]initWithObjects:@"Active",@"Inactive",nil];
    
    _AddInfo.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _AddInfo.layer.borderWidth = 1.0f;
    _AddInfo.layer.cornerRadius = 5;
    
//    _AddInfo.text = @"Additional Info";
//    _AddInfo.textColor = [UIColor lightGrayColor];
//    _AddInfo.delegate = self;
    
    _viewGallary.hidden = YES;
     city = @"";
     motor_vehi = @"";
    fual_type = @"";
    brand = @"";
    capacity_unit = @"";
    
    
    [self setupAlerts];
    [self Validation_Delegate];
    

    _City.enabled = NO;
    _Brand.enabled =NO;
    
}


-(void)Validation_Delegate
{
    _Fname.delegate=self;
    _Fname.presentInView=self.view;
    
    _Lname.delegate=self;
    _Lname.presentInView=self.view;
    
    _Name.delegate=self;
    _Name.presentInView=self.view;
    
    _Email.delegate=self;
    _Email.presentInView=self.view;
    
    _Brand.delegate=self;
    _Brand.presentInView=self.view;
    
    _Version.delegate=self;
    _Version.presentInView=self.view;

    _Color.delegate=self;
    _Color.presentInView=self.view;

    _NoofOwner.delegate=self;
    _NoofOwner.presentInView=self.view;
    
    _KmDriven.delegate=self;
    _KmDriven.presentInView=self.view;
    
    _City.delegate=self;
    _City.presentInView=self.view;
    
    _PUC.delegate=self;
    _PUC.presentInView=self.view;
    
    _Registration_RTO.delegate=self;
    _Registration_RTO.presentInView=self.view;
    
    _Insurance_Valid.delegate=self;
    _Insurance_Valid.presentInView=self.view;
    
    _Price.delegate=self;
    _Price.presentInView=self.view;
    
    _Capacity.delegate=self;
    _Capacity.presentInView=self.view;
    
    _Addinfotxt.delegate=self;
    _Addinfotxt.presentInView=self.view;
    
    
}


-(void)setupAlerts
{
    
    [_Fname addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Firstname can not be blank."];
     
    [_Lname addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Lastname can not be blank."];
    
    [_Name addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Name can not be blank."];
    
    [_Email addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    
    [_Brand addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Brand can not be blank."];
      
    [_Version addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Version can not be blank."];
      
    [_Color addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Color can not be blank."];
    
    [_NoofOwner addRegx:REGEX_NUMBER withMsg:@"No Of Owners can not be blank."];
      
    [_KmDriven addRegx:REGEX_FLOAT withMsg:@"Km Driven can not be blank."];
   
    [_PUC addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Puc can not be blank."];
    
    [_Registration_RTO addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Rigister Rto can not be blank."];
    
    [_Price addRegx:REGEX_FLOAT withMsg:@"Price can not be blank."];
    [_Capacity addRegx:REGEX_FLOAT withMsg:@"Capacity can not be blank."];
    
    [_Addinfotxt addRegx:REGEX_TEXTVIEW withMsg:@"Additional Info can not be blank."];
    
  }
//       
//- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
//{
//    _AddInfo.text = @"";
//    _AddInfo.textColor = [UIColor blackColor];
//    return YES;
//}
//
//-(void) textViewDidChange:(UITextView *)textView
//{
//    if(_AddInfo.text.length == 0)
//    {
//        _AddInfo.textColor = [UIColor lightGrayColor];
//        _AddInfo.text = @"Additional Info";
//        [_AddInfo resignFirstResponder];
//    }
//}
-(void)Get_Adondata
{
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
     adondata = [dic valueForKey:@"data"];
    
    [self jsonparsing_VehicleType];
    _type_tabledata.hidden = YES;

    [self jsonparsing_capacityUnitType];
    _capacityUnit_tabledata.hidden = YES;
    
    [self jsonparsing_BrandType];
    _brand_table.hidden = YES;
    
    [self jsonparsing_cityType];
    _city_table.hidden = YES;

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
    [_type_tabledata reloadData];
}

-(void)jsonparsing_BrandType
{
    
    brandtypedata=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"dealer_brand"]copyItems:YES];
    
    for (int i=0; i<[brandtypedata count];i++)
    {
        NSDictionary *dic12 = [brandtypedata objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [brandtyp addObject:str1];
    }
    [_brand_table reloadData];
}
-(void)jsonparsing_cityType
{
    
    citytypdata=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"city"]copyItems:YES];
    
    for (int i=0; i<[citytypdata count];i++)
    {
        NSDictionary *dic12 = [citytypdata objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [citytyp addObject:str1];
    }
    [_city_table reloadData];
}
-(void)jsonparsing_capacityUnitType
{
    
    
    capacityUnittype=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"capacity_unit"]copyItems:YES];
    
    for (int i=0; i<[capacityUnittype count];i++)
    {
        NSDictionary *dic12 = [capacityUnittype objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [capacityUnit addObject:str1];
    }
    [_capacityUnit_tabledata reloadData];
}

-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == _Type)
    {
        _type_tabledata.hidden = NO;
        
        [self.type_tabledata reloadData];
        
    }
    else if (textField == _Brand)
    {
        _brand_table.hidden = NO;
        
        [self.brand_table reloadData];
    }
    else if (textField == _City)
    {
        _city_table.hidden = NO;
        
        [self.city_table reloadData];
    }
    else
    {
        _capacityUnit_tabledata.hidden = NO;
        
        [self.capacityUnit_tabledata reloadData];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_type_tabledata)
    {
        return [vtype count];
    }
    else if(tableView==_capacityUnit_tabledata)
    {
        return [capacityUnit count];
    }
    else if(tableView==_brand_table)
    {
        return [brandtyp count];
    }
    else if(tableView==_city_table)
    {
        return [citytyp count];
    }
    else if(tableView==_status_tabledata)
    {
        return [statustype count];
    }
    else if(tableView==_isnew_tabledata)
    {
        return [isnewtyp count];
    }
    else if(tableView==_fual_tabledata)
    {
        return [fualtyp count];
    }

    else
    {
        return _imagelist.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_type_tabledata)
    {
        static NSString *table = @"cell4";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
        }
        cell.typelbl_sellVehicle.text = [vtype objectAtIndex:indexPath.row];
        
        return cell;
        
    }
    else if (tableView == _capacityUnit_tabledata)
    {
        static NSString *table = @"cell3";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        
        cell.capacityUnitlbl_sellVehicle.text = [capacityUnit objectAtIndex:indexPath.row];
        return cell;
    }
    else if (tableView==_brand_table)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
        }
        cell.brandtyp_sellvehicle.text = [brandtyp objectAtIndex:indexPath.row];
        
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
          cell.citylbl_sellvehicle.text = [citytyp objectAtIndex:indexPath.row];
          return cell;
        
    }
    else if (tableView == _isnew_tabledata)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        
        cell.isnewlbl_sellvehicle.text = [isnewtyp objectAtIndex:indexPath.row];
        return cell;
    }
    else if (tableView == _status_tabledata)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        
        cell.statuslbl_sellvehicle.text = [statustype objectAtIndex:indexPath.row];
        return cell;
    }
    else if (tableView == _fual_tabledata)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        
        cell.fualtypelbl_sellvehicle.text = [fualtyp objectAtIndex:indexPath.row];
        return cell;
    }
    

    
    else
        {
            static NSString *table = @"cell12";
            Sell_Vehicle_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
            
            cell.deletebtn.tag=indexPath.row;
            cell.Takeimagebtn.tag = indexPath.row;
            
            cell.Vehicleimg.image=[_imagelist objectAtIndex:indexPath.row];
            
      
            [cell.deletebtn addTarget:self action:@selector(myDeleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

            [cell.Takeimagebtn addTarget:self action:@selector(myCellButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

            return cell;
        }
    
}


-(void)myCellButtonPressed:(UIButton *)sender
{
    _viewGallary.hidden = NO;
    UIButton *senderButton = (UIButton *)sender;
    _vehicleimg_position = senderButton.tag;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_type_tabledata)
    {
        _Type.text=[vtype objectAtIndex:indexPath.row];
        motor_vehi= [[[adondata valueForKey:@"vehicle_type"]objectAtIndex:indexPath.row] valueForKey:@"id"];
        _type_tabledata.hidden = YES;
    }
    else if (tableView == _capacityUnit_tabledata)
    {
        capacity_unit = [capacityUnit objectAtIndex:indexPath.row];
        _CapacityUnit.text=[capacityUnit objectAtIndex:indexPath.row];
        _capacityUnit_tabledata.hidden = YES;
    }
   else if (tableView==_brand_table)
    {
        _Brand.text=[brandtyp objectAtIndex:indexPath.row];
        brand= [[[adondata valueForKey:@"dealer_brand"]objectAtIndex:indexPath.row] valueForKey:@"value"];
        _brand_table.hidden = YES;
    }
   else if (tableView==_city_table)
   {
       _City.text=[citytyp objectAtIndex:indexPath.row];
        city= [[[adondata valueForKey:@"city"]objectAtIndex:indexPath.row] valueForKey:@"value"];
       _city_table.hidden = YES;
   }

    else if (tableView == _isnew_tabledata)
    {
        _IsNew.text=[isnewtyp objectAtIndex:indexPath.row];
        _isnew_tabledata.hidden = YES;
    }

    else if (tableView == _status_tabledata)
    {
        _Status.text=[statustype objectAtIndex:indexPath.row];
        _status_tabledata.hidden = YES;
    }
    else if (tableView == _fual_tabledata)
    {
        fual_type = [fualtyp objectAtIndex:indexPath.row];
        _FualType.text=[fualtyp objectAtIndex:indexPath.row];
        _fual_tabledata.hidden = YES;
    }
}

 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)createbtn:(id)sender
{
    c_name=_CompanyName.text;
    fname=_Fname.text;
    lname=_Lname.text;
    email=_Email.text;
    mobile=_Mobile.text;
    name=_Name.text;
    fual_type=_FualType.text;
    brand=_Brand.text;
    version=_Version.text;
    color=_Color.text;
    make_year=_Make_Year.text;
    regi_year=_Registration_year.text;
    no_owner=_NoofOwner.text;
    km_driven=_KmDriven.text;
    city=_City.text;
    puc=_PUC.text;
    reg_rto=_Registration_RTO.text;
    ins_valid=_Insurance_Valid.text;
    price=_Price.text;
    additional_info=_AddInfo.text;
    
    capacity=_Capacity.text;
    capacity_unit=_CapacityUnit.text;
    is_new=_IsNew.text;
    status=_Status.text;
    
    _Addinfotxt.hidden = false;
    _Addinfotxt.text = _AddInfo.text;
    
    if([_Fname validate] & [_Lname validate] & [_Name validate] & [_Email validate] & [_Brand validate] & [_Version validate] & [_Color validate] & [_NoofOwner validate] & [_KmDriven validate] & [_PUC validate] & [_Registration_RTO validate] & [_Capacity validate] & [_Addinfotxt validate])
    {
        if (!_termConditionCheck)
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:@"You must accept our term and condition!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [al show];
            return;
        }
        else
        {
            isTermAc = @"1";
        }
        
        setdic=[[NSMutableDictionary alloc]init];
        
        [setdic setObject:[AppMethod getStringDefault:@"default_id"] forKey:@"user_id"];
        [setdic setObject:c_name forKey:@"company_name"];
        [setdic setObject:fname forKey:@"firstname"];
        [setdic setObject:lname forKey:@"lastname"];
        [setdic setObject:email forKey:@"email"];
        [setdic setObject:mobile forKey:@"mobile"];
        [setdic setObject:name forKey:@"name"];
        
        if ([fual_type isEqualToString:@""])
        {
            [setdic setObject:[fualtyp objectAtIndex:0] forKey:@"fuel_type"];
        }
        else
        {
            [setdic setObject:fual_type forKey:@"fuel_type"];
        }

        [setdic setObject:version forKey:@"version"];
        [setdic setObject:color forKey:@"color"];
        [setdic setObject:make_year forKey:@"make_year"];
        [setdic setObject:regi_year forKey:@"year_registration"];
        [setdic setObject:no_owner forKey:@"no_of_owners"];
        [setdic setObject:km_driven forKey:@"km_driven"];
        
        if ([city isEqualToString:@""])
        {
            [setdic setObject:[[[adondata valueForKey:@"city"]objectAtIndex:0] valueForKey:@"value"] forKey:@"city"];
        }
        else
        {
            [setdic setObject:city forKey:@"city"];
        }

        [setdic setObject:puc forKey:@"puc"];
        [setdic setObject:reg_rto forKey:@"rigister_rto"];
        [setdic setObject:ins_valid forKey:@"insurance_valid"];
        [setdic setObject:price forKey:@"price"];
        [setdic setObject:additional_info forKey:@"additonal_info"];
        [setdic setObject:isTermAc forKey:@"terms_condition"];
        
        if ([motor_vehi isEqualToString:@""])
        {
            [setdic setObject:[[[adondata valueForKey:@"vehicle_type"]objectAtIndex:0] valueForKey:@"id"] forKey:@"vehicle_type_id"];
        }
        else
        {
            [setdic setObject:motor_vehi forKey:@"vehicle_type_id"];
        }
        
        
        
        [setdic setObject:capacity forKey:@"capacity"];
        
        if ([capacity_unit isEqualToString:@""])
        {
            [setdic setObject:[capacityUnit objectAtIndex:0] forKey:@"capacity_unit"];
        }
        else
        {
            [setdic setObject:capacity_unit forKey:@"capacity_unit"];
        }
        
        if ([brand isEqualToString:@""])
        {
           [setdic setObject:[[[adondata valueForKey:@"dealer_brand"]objectAtIndex:0] valueForKey:@"value"] forKey:@"brand"];
        }
        else
        {
           [setdic setObject:brand forKey:@"brand"];
        }
        
        NSMutableArray *imaglist = [[NSMutableArray alloc]init];
        if ([_imagelist count]>0) {
            for (int i = 0; i<[_imagelist count]; i++)
            {
                [imaglist addObject:[self imageToNSString:[_imagelist objectAtIndex:i]]];
            }
        }
        else
        {
            
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Add Minimum 1 Image." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [al show];
            return;
        }
        
        [setdic setObject:imaglist forKey:@"image"];
        if ([is_new isEqualToString:@"New"])
        {
            [setdic setObject:@"1" forKey:@"is_new"];
        }
        else
        {
            [setdic setObject:@"0" forKey:@"is_new"];
        }
        
        if ([status isEqualToString:@"Active"])
        {
            [setdic setObject:@"1" forKey:@"status"];
        }
        else
        {
            [setdic setObject:@"0" forKey:@"status"];
            
        }
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
          [ProgressHUD show:@"Please wait..."];
        [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];        
        [manager POST:[baseurl stringByAppendingString:SellVehicleurl] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
         {
              [ProgressHUD dismiss];
             BOOL boolean = [[dic12 valueForKey:@"status"] boolValue];
             if (boolean)
             {
                 UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:[dic12 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                 al.tag = 1;
                 [al show];
             }
             else
             {
                 UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:[dic12 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                 al.tag = 2;
                 [al show];
                 
             }
 
             
         } failure:^(NSURLSessionTask *operation, NSError *error)
         {
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
             [al show];
              [ProgressHUD dismiss];
         }];
        
        



//        NSMutableDictionary *dic12 = [httpws httpPostWithauth:[baseurl stringByAppendingString:SellVehicleurl] :setdic :[AppMethod getStringDefault:@"default_access_token"]];
//        
//        NSDictionary *dic1 = [[NSMutableDictionary alloc] initWithDictionary:[dic12 objectForKey:@"data"]copyItems:YES];
//        
//        BOOL boolean = [[dic12 valueForKey:@"status"] boolValue];
//        if (boolean)
//        {
//            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:[dic12 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//            [al show];
//        }

    }
}

- (NSString *)imageToNSString:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    if (alertView.tag == 1)
    {
        if (buttonIndex == 0)
        {
            SWRevealViewController *inq = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
            [self.navigationController pushViewController:inq animated:YES];
        }
    }
    
}


-(void)myDeleteButtonPressed:(UIButton *)sender
{
    UIButton *senderButton = (UIButton *)sender;
    [_imagelist removeObjectAtIndex:senderButton.tag];
    [_vehicledata reloadData];
   // [self setTableViewheightOfTable:_vehicledata ByArrayName:_imagelist];
}



- (IBAction)AddImage:(id)sender
{
    [_imagelist addObject:[UIImage imageNamed:@"app_icon.png"]];
    [_vehicledata reloadData];
   // [self setTableViewheightOfTable:_vehicledata ByArrayName:_imagelist];
}

//-(void)setTableViewheightOfTable :(UITableView *)tableView ByArrayName:(NSArray *)array
//{
//    CGFloat height = tableView.rowHeight;
//    height *= array.count;
//    
//    CGRect tableFrame = tableView.frame;
//    tableFrame.size.height = height;
//    tableView.frame = tableFrame;
//    
//}


- (IBAction)Type_dropdown:(id)sender
{
    _type_tabledata.hidden = NO;
}
- (IBAction)dropdown_capacityUnit:(id)sender
{
    _capacityUnit_tabledata.hidden = NO;
}

- (IBAction)dropdown_fual:(id)sender
{
      _fual_tabledata.hidden = NO;
}
- (IBAction)dropdown_status:(id)sender
{
      _status_tabledata.hidden = NO;
}
- (IBAction)dropdown_isnew:(id)sender
{
      _isnew_tabledata.hidden = NO;
}


///keybord method
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
    
     UITextField *add1 = (UITextField *)textField;
    if (add1.tag == 1)
    {
        _Addinfotxt.hidden = YES;
        [_AddInfo becomeFirstResponder];
    }

    
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
    _viewGallary.hidden = YES;
}

- (IBAction)gallarybtn:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    _viewGallary.hidden = YES;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    [_imagelist replaceObjectAtIndex:_vehicleimg_position withObject:chosenImage];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [_vehicledata reloadData];
    
    
}
- (IBAction)closebtn:(id)sender
{
    _viewGallary.hidden = YES;
}


- (IBAction)uncheckbtn:(id)sender
{
     [_uncheckbtn addTarget:self action:@selector(ChkUnChk_TermCondition:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)ChkUnChk_TermCondition:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
    if (_termConditionCheck)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"uncheck.png"]forState:UIControlStateNormal];
        
        _termConditionCheck = NO;
        
    }
    else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"check.png"]forState:UIControlStateNormal];
        _termConditionCheck = YES;
    }
}

- (IBAction)dropdown_brand:(id)sender
{
    _brand_table.hidden = NO;
}
- (IBAction)dropdown_city:(id)sender
{
    _city_table.hidden = NO;
}

@end
