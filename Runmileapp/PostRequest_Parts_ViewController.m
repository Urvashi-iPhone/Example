//
//  PostRequest_Parts_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/8/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "PostRequest_Parts_ViewController.h"
#import "httpws.h"
#import "Constant.h"
#import "AppMethod.h"
#import "BuyPartsSearch_ViewController.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "Vehicle_Type_Capacity_New_TableViewCell.h"
@interface PostRequest_Parts_ViewController ()

@end
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
@implementation PostRequest_Parts_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
         _border1.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];
    _border1.layer.borderWidth = 1.0f;
    _border1.layer.cornerRadius = 10;
     _border2.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _border2.layer.borderWidth = 1.0f;
    _border2.layer.cornerRadius = 10;
    _submitbtn.layer.cornerRadius = 17.0;
    //scrollview
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlview.contentSize = contentRect.size;
    
    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    brand = @"";
    city = @"";
    parts_type = @"";
    
    adon_dic = [[NSDictionary alloc]init];
    citytyp = [[NSMutableArray alloc]init];
    parttyp = [[NSMutableArray alloc]init];
    brandtyp = [[NSMutableArray alloc]init];
    [self Get_adondata];
    
    [self setupAlerts];
    [self Validation_Delegate];
    
    _Partstype.enabled = NO;
    _City.enabled = NO;
    _Brand.enabled =NO;
    
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
-(void)textFieldDidChange:(UITextField *)textField
{
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
    else if (textField == _Partstype)
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
    return nil;
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
        cell.citylbl_postpart.text = [citytyp objectAtIndex:indexPath.row];
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
        cell.brandlbl_postpart.text = [brandtyp objectAtIndex:indexPath.row];
        
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
        cell.partlbl_postpart.text = [parttyp objectAtIndex:indexPath.row];
        
        return cell;
        
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_city_table)
    {
        _City.text=[citytyp objectAtIndex:indexPath.row];
        city= [[[adon_dic valueForKey:@"city"]objectAtIndex:indexPath.row] valueForKey:@"value"];
        _city_table.hidden = YES;
    }
    else if (tableView==_table_parttype)
    {
        _Partstype.text=[parttyp objectAtIndex:indexPath.row];
        parts_type= [[[adon_dic valueForKey:@"parts_type"]objectAtIndex:indexPath.row] valueForKey:@"id"];
        _table_parttype.hidden = YES;
    }
    else if (tableView==_table_brand)
    {
        _Brand.text=[brandtyp objectAtIndex:indexPath.row];
        brand= [[[adon_dic valueForKey:@"dealer_brand"]objectAtIndex:indexPath.row] valueForKey:@"value"];
        _table_brand.hidden = YES;
    }
}
-(void)Validation_Delegate
{
    _name.delegate=self;
    _Email.delegate=self;
    _AddressLine1.delegate=self;
    _AddressLine2.delegate=self;
    _Partstype.delegate=self;
      _Mobile.delegate=self;
    
    _name.presentInView=self.view;
    _Email.presentInView=self.view;
    _AddressLine1.presentInView=self.view;
    _AddressLine2.presentInView=self.view;
    _Partstype.presentInView=self.view;
      _Mobile.presentInView=self.view;
   
}
-(void)setupAlerts
{
    [_name addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Name can not be blank."];
    
    [_Email addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    
    [_AddressLine1 addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Addressline1 can not be blank."];
    
    [_AddressLine2 addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"can not be blank."];
    
    [_Partstype addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Parts Type can not be blank."];
    
     [_Mobile addRegx:REGEX_PHONE_NUMBER withMsg:@"Mobile Number can not be blank."];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)submitbtn:(id)sender
{
    name = _name.text;
    c_name = _CompanyName.text;
    email = _Email.text;
    mobile = _Mobile.text;
    landline = _Landline.text;
    address1 = _AddressLine1.text;
    address2 = _AddressLine2.text;
    manufacture = _Manufacture.text;
    parts_type = _Partstype.text;
    veh_model = _VehicleModel.text;
    manufacture_year = _ManufactureYear.text;
    model_no = _ModelNumber.text;
    price = _Price.text;
    brand = _Brand.text;
    city = _City.text;
    parts_det = _PartsDetail.text;
    lenght = _Length.text;
    width = _Width.text;
    height = _Height.text;
    weight = _Weight.text;
    
    if([_name validate] & [_Email validate] & [_AddressLine1 validate] & [_AddressLine2 validate] & [_Partstype validate] & [_Mobile validate])
      // & [_Price validate] & [_Height validate] & [_Width validate]  & [_Length validate] & [_Weight validate])
    {

        setdic = [[NSMutableDictionary alloc]init];
        [setdic setObject:name forKey:@"name"];
        [setdic setObject:c_name forKey:@"company_name"];
        [setdic setObject:email forKey:@"email"];
        [setdic setObject:mobile forKey:@"mobile"];
        [setdic setObject:landline forKey:@"landline"];
        [setdic setObject:address1 forKey:@"addressline1"];
        [setdic setObject:address2 forKey:@"addressline2"];
        [setdic setObject:manufacture forKey:@"manufacturer"];
        
        if ([parts_type isEqualToString:@""])
        {
            [setdic setObject:[[[adon_dic valueForKey:@"parts_type"]objectAtIndex:0] valueForKey:@"value"] forKey:@"parts_type"];
        }
        else
        {
            [setdic setObject:parts_type forKey:@"parts_type"];
        }
        
       
        [setdic setObject:veh_model forKey:@"vehicle_model"];
        [setdic setObject:manufacture_year forKey:@"year_of_manufacture"];
        [setdic setObject:model_no forKey:@"model_no"];
        [setdic setObject:price forKey:@"price"];
        
        
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
       
        [setdic setObject:parts_det forKey:@"parts_detail"];
        [setdic setObject:lenght forKey:@"lenght"];
        [setdic setObject:width forKey:@"width"];
        [setdic setObject:height forKey:@"height"];
        [setdic setObject:weight forKey:@"weight"];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
       [ProgressHUD show:@"Please wait..."];
        
        [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
        [manager POST:[baseurl stringByAppendingString:PartsPostRequest] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
         
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
//        BuyPartsSearch_ViewController *post = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyPartsSearch_ViewController"];
//        [self.navigationController pushViewController:post animated:YES];
         [self.navigationController popViewControllerAnimated:YES];
    }
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

- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)dropdown_parttype:(id)sender
{
    _table_parttype.hidden = NO;
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
