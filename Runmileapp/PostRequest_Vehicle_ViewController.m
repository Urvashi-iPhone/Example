//
//  PostRequest_Vehicle_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/7/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "PostRequest_Vehicle_ViewController.h"
#import "httpws.h"
#import "AppMethod.h"
#import "Constant.h"
#import "VehicleSearch_ViewController.h"
#import "SWRevealViewController.h"
#import "Vehicle_Type_Capacity_New_TableViewCell.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"

@interface PostRequest_Vehicle_ViewController ()

@end
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@implementation PostRequest_Vehicle_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     //[[UINavigationBar appearance]setFrame:CGRectMake(0, 0,self.view.frame.size.width, 60)];
     _border1.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];
    _border1.layer.borderWidth = 1.0f;
    _border1.layer.cornerRadius = 10;
     _border2.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _border2.layer.borderWidth = 1.0f;
    _border2.layer.cornerRadius = 10;
    _submitbtn.layer.cornerRadius = 17.0;
    
    brand = @"";
    city = @"";
    
    //scrollview
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlview.contentSize = contentRect.size;
    
    
    adon_dic = [[NSDictionary alloc]init];
    vtype = [[NSMutableArray alloc]init];
    capacityUnit = [[NSMutableArray alloc]init];
    citytyp = [[NSMutableArray alloc]init];
    brandtyp = [[NSMutableArray alloc]init];
    [self Get_adondata];
    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    _fual_tabledata.hidden = YES;
    fualtyp=[[NSArray alloc]initWithObjects:@"Petrol",@"Diesel",nil];
    
    _isnew_tabledata.hidden = YES;
    Isnew=[[NSArray alloc]initWithObjects:@"New",@"Old",nil];
    
    _Add_info.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _Add_info.layer.borderWidth = 1.0f;
    _Add_info.layer.cornerRadius = 5;
    
//    _Add_info.text = @"Additional Info";
//    _Add_info.textColor = [UIColor lightGrayColor];
//    _Add_info.delegate = self;
   
    _City.enabled = NO;
    _Brand.enabled =NO;
    
    _addInfoTxt.tag = 1;
    [self setupAlerts];
    [self Validation_Delegate];


    
    // Do any additional setup after loading the view.
}
-(void)Validation_Delegate
{
    _name.delegate=self;
    _Email.delegate=self;
    
    _AddressLine1.delegate=self;
    _AddressLine2.delegate=self;
    _Capacity.delegate=self;
     _Mobile.delegate=self;
    
    
    _name.presentInView=self.view;
    _Email.presentInView=self.view;
    
    _AddressLine1.presentInView=self.view;
    _AddressLine2.presentInView=self.view;
    _Capacity.presentInView=self.view;
    _Mobile.presentInView=self.view;


    
}
-(void)setupAlerts
{
    [_name addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Name can not be blank."];
    
    [_Email addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    
    
    
    [_AddressLine1 addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Addressline1 can not be blank."];
    
    [_AddressLine2 addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Addressline2 can not be blank."];
    
    [_Capacity addRegx:REGEX_FLOAT withMsg:@"From Address can not be blank."];
    
   [_Mobile addRegx:REGEX_PHONE_NUMBER withMsg:@"Mobile Number can not be blank."];
    
}

//- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
//{
//    _Add_info.text = @"";
//    _Add_info.textColor = [UIColor blackColor];
//    return YES;
//}
//
//-(void) textViewDidChange:(UITextView *)textView
//{
//    if(_Add_info.text.length == 0)
//    {
//        _Add_info.textColor = [UIColor lightGrayColor];
//        _Add_info.text = @"Additional Info";
//        [_Add_info resignFirstResponder];
//    }
//}
-(void)Get_adondata
{
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
    adon_dic = [dic valueForKey:@"data"];
    [self jsonparsing_VehicleType];
    _type_tabledata.hidden = YES;
    [self jsonparsing_capacityUnitType];
    _capacityUnit_tabledata.hidden = YES;
    [self jsonparsing_cityType];
    _city_table.hidden = YES;
    [self jsonparsing_BrandType];
    _table_brand.hidden = YES;
    
}
-(void)jsonparsing_VehicleType
{
    
    vtypedata=[[NSMutableArray alloc] initWithArray:[adon_dic objectForKey:@"vehicle_type"]copyItems:YES];
    
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
-(void)jsonparsing_capacityUnitType
{
    
    capacityUnittype=[[NSMutableArray alloc] initWithArray:[adon_dic objectForKey:@"capacity_unit"]copyItems:YES];
    
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
    if (textField == _City)
    {
        _city_table.hidden = NO;
        
        [self.city_table reloadData];
    }
    else if (textField == _Brand)
    {
        _table_brand.hidden = NO;
        
        [self.table_brand reloadData];
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
    if(tableView==_city_table)
    {
        return [citytyp count];
    }
    else if(tableView==_table_brand)
    {
        return [brandtyp count];
    }
    else if (tableView == _fual_tabledata)
    {
        return [fualtyp count];
    }
    else if (tableView == _isnew_tabledata)
    {
        return [Isnew count];
    }
    else
    {
        return [capacityUnit count];
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_type_tabledata)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
        }
         cell.typelbl.text = [vtype objectAtIndex:indexPath.row];
        
        return cell;
        
    }
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
        cell.citylbl_postvehicle.text = [citytyp objectAtIndex:indexPath.row];
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
        cell.brandlbl_postvehicle.text = [brandtyp objectAtIndex:indexPath.row];
        
        return cell;
        
    }

    else if (tableView == _capacityUnit_tabledata)
    {
        static NSString *table = @"cell2";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        
        cell.capacityUnitlbl.text = [capacityUnit objectAtIndex:indexPath.row];
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
        
        cell.Isnewlbl.text = [Isnew objectAtIndex:indexPath.row];
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
        
        cell.fualtypelbl_postrequestvehicle.text = [fualtyp objectAtIndex:indexPath.row];
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_type_tabledata)
    {
        _Type.text=[vtype objectAtIndex:indexPath.row];
        vehicle_type_id = [[[adon_dic valueForKey:@"vehicle_type"]objectAtIndex:indexPath.row] valueForKey:@"id"];
        _type_tabledata.hidden = YES;
    }
    else if (tableView == _capacityUnit_tabledata)
    {
        _CapacityUnit.text=[capacityUnit objectAtIndex:indexPath.row];
        _capacityUnit_tabledata.hidden = YES;
    }
    else if(tableView==_city_table)
    {
        _City.text=[citytyp objectAtIndex:indexPath.row];
        city= [[[adon_dic valueForKey:@"city"]objectAtIndex:indexPath.row] valueForKey:@"value"];
        _city_table.hidden = YES;
    }
    else if (tableView == _isnew_tabledata)
    {
        _IsNew.text=[Isnew objectAtIndex:indexPath.row];
        _isnew_tabledata.hidden = YES;
    }
    else if (tableView==_table_brand)
    {
        _Brand.text=[brandtyp objectAtIndex:indexPath.row];
        brand= [[[adon_dic valueForKey:@"dealer_brand"]objectAtIndex:indexPath.row] valueForKey:@"value"];
        _table_brand.hidden = YES;
    }
    else
    {
        _FualType.text=[fualtyp objectAtIndex:indexPath.row];
        _fual_tabledata.hidden = YES;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)submitbtn:(id)sender
{
    name=_name.text;
    c_name=_CompanyName.text;
    email=_Email.text;
    mobile=_Mobile.text;
    landline=_Landline.text;
    address1=_AddressLine1.text;
    address2=_AddressLine2.text;
    fuel_type=_FualType.text;
    brand=_Brand.text;
    version=_Version.text;
    color=_Color.text;
    make_year=_MakeYear.text;
    year_registration=_RegistrationYear.text;
    no_of_owners=_NoOfOwners.text;
    km_driven=_KmDriven.text;
    city=_City.text;
    puc=_Puc.text;
    rigister_rto=_RegistrationRTO.text;
    insurance_valid=_InsuranceValid.text;
    price=_Price.text;
    additional_info=_Add_info.text;
    vehicle_type_id=_Type.text;
    capacity=_Capacity.text;
    capacity_unit=_CapacityUnit.text;
    is_new=_IsNew.text;
    
    
    _addInfoTxt.hidden = false;
    _addInfoTxt.text = _Add_info.text;

    
    if([_name validate] & [_Email validate] & [_AddressLine1 validate] & [_AddressLine2 validate] & [_Capacity validate] & [_Mobile validate])
    {
        
   
        setdic = [[NSMutableDictionary alloc]init];
        [setdic setObject:name forKey:@"name"];
        [setdic setObject:c_name forKey:@"company_name"];
        [setdic setObject:email forKey:@"email"];
        [setdic setObject:mobile forKey:@"mobile"];
        [setdic setObject:landline forKey:@"landline"];
        [setdic setObject:address1 forKey:@"addressline1"];
        [setdic setObject:address2 forKey:@"addressline2"];
    if ([fuel_type isEqualToString:@""])
    {
        [setdic setObject:[fualtyp objectAtIndex:0] forKey:@"fuel_type"];
    }
    else
    {
        [setdic setObject:fuel_type forKey:@"fuel_type"];
    }
    
       
        [setdic setObject:version forKey:@"version"];
        [setdic setObject:color forKey:@"color"];
        [setdic setObject:make_year forKey:@"make_year"];
        [setdic setObject:year_registration forKey:@"year_registration"];
        [setdic setObject:no_of_owners forKey:@"no_of_owners"];
        [setdic setObject:km_driven forKey:@"km_driven"];
       
        
        if ([brand isEqualToString:@""])
        {
            [setdic setObject:[[[adon_dic valueForKey:@"dealer_brand"]objectAtIndex:0] valueForKey:@"value"] forKey:@"brand"];
        }
        else
        {
            [setdic setObject:brand forKey:@"brand"];
        }
        
        
        if ([city isEqualToString:@""])
        {
            [setdic setObject:[[[adon_dic valueForKey:@"city"]objectAtIndex:0] valueForKey:@"value"] forKey:@"city"];
        }
        else
        {
            [setdic setObject:city forKey:@"city"];
        }

        [setdic setObject:puc forKey:@"puc"];
        [setdic setObject:rigister_rto forKey:@"rigister_rto"];
        [setdic setObject:insurance_valid forKey:@"insurance_valid"];
        [setdic setObject:price forKey:@"price"];
        [setdic setObject:additional_info forKey:@"additional_info"];
        
        if ([vehicle_type_id isEqualToString:@""])
        {
            [setdic setObject:[[[adon_dic valueForKey:@"vehicle_type"]objectAtIndex:0] valueForKey:@"id"] forKey:@"vehicle_type_id"];
        }
        else
        {
            [setdic setObject:vehicle_type_id forKey:@"vehicle_type_id"];
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
        
    if ([is_new isEqualToString:@"New"])
    {
        [setdic setObject:@"1" forKey:@"is_new"];
    }
    else
    {
        [setdic setObject:@"0" forKey:@"is_new"];
    }
    
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
       [ProgressHUD show:@"Please wait..."];
        
        [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
        [manager POST:[baseurl stringByAppendingString:vehiclePostRequest] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
         
         {
             BOOL boolean = [[dic12 valueForKey:@"status"] boolValue];
             if (boolean)
             {
                 UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:[dic12 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                 [al show];
                 
             }
               [ProgressHUD dismiss];
         }failure:^(NSURLSessionTask *operation, NSError *error)
         {
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
             [al show];
               [ProgressHUD dismiss];
         }];
        
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
//        VehicleSearch_ViewController *inq = [self.storyboard instantiateViewControllerWithIdentifier:@"VehicleSearch_ViewController"];
//        [self.navigationController pushViewController:inq animated:YES];
         [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)dropdown_vehicletype:(id)sender
{
    _type_tabledata.hidden = NO;
}

- (IBAction)dropdown_CapacityUnit:(id)sender
{
    _capacityUnit_tabledata.hidden = NO;
}
- (IBAction)dropdown_fualType:(id)sender
{
    _fual_tabledata.hidden = NO;
}
- (IBAction)dropdown_IsNew:(id)sender
{
    _isnew_tabledata.hidden = NO;
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
    
    UITextField *add1 = (UITextField *)textField;
    if (add1.tag == 1)
    {
        _addInfoTxt.hidden = YES;
        [_Add_info becomeFirstResponder];
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
