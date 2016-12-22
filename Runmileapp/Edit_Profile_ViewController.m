//
//  Edit_Profile_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/16/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "Edit_Profile_ViewController.h"
#import "Vehicle_Type_Capacity_New_TableViewCell.h"
#import "SWRevealViewController.h"
#import "httpws.h"
#import "AppMethod.h"
#import "Constant.h"
#import "MyAccount_ViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"


@interface Edit_Profile_ViewController ()

@end
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
@implementation Edit_Profile_ViewController

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
    
    _viewGalary.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];
    _viewGalary.layer.borderWidth= 1.0f;
    _viewGalary.layer.cornerRadius = 15.0;
    _camerabtn.layer.cornerRadius = 17.0;
    _gallarybtn.layer.cornerRadius = 17.0;
    
    _border1.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];
    _border1.layer.borderWidth= 1.0f;
    _border1.layer.cornerRadius = 15.0;
    
    _border2.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _border2.layer.borderWidth= 1.0f;
    _border2.layer.cornerRadius = 15.0;
    _updatebtn.layer.cornerRadius = 17.0;
    
    contrylist = @"";
    
    adondata = [[NSDictionary alloc]init];
    permit = [[NSMutableArray alloc]init];
    locale = [[NSMutableArray alloc]init];
    country = [[NSMutableArray alloc]init];
    
    [self Get_adondata];
    
    _gender_tabledata.hidden = YES;
    genderarry=[[NSMutableArray alloc]initWithObjects:@"Male",@"Female",nil];

    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    _companyName.text = [AppMethod getStringDefault:@"default_Companyname"];
    
    _Fname.text = [AppMethod getStringDefault:@"default_fname"];
    _Lname.text = [AppMethod getStringDefault:@"default_lname"];
    _Mobile.text = [AppMethod getStringDefault:@"default_Mobile"];
    _Landline.text = [AppMethod getStringDefault:@"default_Landline"];
    _Website.text = [AppMethod getStringDefault:@"default_website"];
    
    // _Permittype.text = [AppMethod getStringDefault:@"default_Permit"];
    
    if ([[AppMethod getStringDefault:@"default_Permit"] isEqualToString:@"1"])
    {
         _Permittype.text = @"State Permit";
    }
    else
    {
         _Permittype.text = @"All India Permit";
    }

  
    _noofVehicle.text = [AppMethod getStringDefault:@"default_noofVehicle"];
    _Locale.text = [AppMethod getStringDefault:@"default_locale"];
    
    _Gender.text = [AppMethod getStringDefault:@"default_Gender"];
    
    if ([[AppMethod getStringDefault:@"default_Gender"] isEqualToString:@"1"])
    {
        _Gender.text = @"Male";
    }
    else
    {
        _Gender.text = @"Female";
    }
    
    _Website.text = [AppMethod getStringDefault:@"default_website"];
    _Locale.text = [AppMethod getStringDefault:@"default_locale"];
    
    NSString *strvalue =  [_Gender.text stringByAppendingString:@"%@"];

     strvalue=[NSString stringWithFormat:@"%@",[AppMethod getStringDefault:@"default_Gender"]];
    
    _ContactPreference.text = [AppMethod getStringDefault:@"default_ContactPref"];
    _Add1.text = [AppMethod getStringDefault:@"default_AddressLine1"];
    _Add2.text = [AppMethod getStringDefault:@"default_AddressLine2"];
    
    _pincode.text = [AppMethod getStringDefault:@"default_pincode"];
    _city.text = [AppMethod getStringDefault:@"default_City"];
    _state.text = [AppMethod getStringDefault:@"default_State"];
    
   _countrytxt.text = [AppMethod getStringDefault:@"default_Country"];

    NSString *imgurl = [AppMethod getStringDefault:@"default_profileImage"];
    _img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgurl]]];
    
     _viewGalary.hidden = YES;
    
    [self setupAlerts];
    [self Validation_Delegate];
    
    // Do any additional setup after loading the view.
}

-(void)Validation_Delegate
{
    _Fname.delegate=self;
    _Lname.delegate=self;
    _Mobile.delegate=self;
    _Add1.delegate=self;
    _Add2.delegate=self;
    _pincode.delegate=self;
    _city.delegate=self;
    _state.delegate = self;
    
    _Fname.presentInView=self.view;
    _Lname.presentInView=self.view;
    _Mobile.presentInView=self.view;
    _Add1.presentInView=self.view;
    _Add2.presentInView=self.view;
    _pincode.presentInView=self.view;
    _city.presentInView=self.view;
    _state.presentInView=self.view;
    
}
-(void)setupAlerts
{
    [_Fname addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"First Name can not be blank."];
    
     [_Lname addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Last Name can not be blank."];
    
     [_Mobile addRegx:REGEX_PHONE_DEFAULT withMsg:@"Mobile can not be blank."];
    
    [_Add1 addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Addressline1 can not be blank."];
    
    [_Add2 addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Addressline2 can not be blank."];
    
    [_pincode addRegx:REGEX_NUMBER withMsg:@"Pincode can not be blank."];
    
    [_city addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"City can not be blank."];
    
    [_state addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"State can not be blank."];
   
}

-(void)Get_adondata
{
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
    adondata = [dic valueForKey:@"data"];
    
    [self jsonparsing_PermitType];
    _permit_tabledata.hidden = YES;
    
    
    [self jsonparsing_LocaleType];
    _locale_tabledata.hidden = YES;
    
    
    [self jsonparsing_CountryList];
    _country_tabledata.hidden = YES;
    
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
    [_permit_tabledata reloadData];
}
-(void)jsonparsing_LocaleType
{
    localetype=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"availabel_locale"]copyItems:YES];
    
    for (int i=0; i<[localetype count];i++)
    {
        NSDictionary *dic12 = [localetype objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [locale addObject:str1];
    }
    [_locale_tabledata reloadData];
}

-(void)jsonparsing_CountryList
{
    countrytype=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"country"]copyItems:YES];
    
    for (int i=0; i<[countrytype count];i++)
    {
        NSDictionary *dic121 = [countrytype objectAtIndex:i];
        NSString *str12 = [dic121 objectForKey:@"value"];
        
        [country addObject:str12];
    }
    [_country_tabledata reloadData];
}

-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == _Permittype)
    {
        _permit_tabledata.hidden = NO;
        
        [self.permit_tabledata reloadData];
    }
    else if (textField == _countrytxt)
    {
        _country_tabledata.hidden = NO;
        
        [self.country_tabledata reloadData];
    }
    else if (textField == _Gender)
    {
        _gender_tabledata.hidden = NO;
        
        [self.gender_tabledata reloadData];
    }
    
    else
    {
    _locale_tabledata.hidden = NO;
    
    [self.locale_tabledata reloadData];
    
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _locale_tabledata)
    {
        return [locale count];
    }
    else if(tableView == _country_tabledata)
    {
        return [country count];
    }
    else if(tableView == _gender_tabledata)
    {
        return [genderarry count];
    }

    else
        
    {
        return [permit count];
   }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _permit_tabledata)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        cell.permittypelbl_editprofile.text = [permit objectAtIndex:indexPath.row];
        
              return cell;
        
    }
    else if(tableView == _country_tabledata)
    {
        static NSString *table = @"cell3";
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        cell.countrylbl_editprofile.text = [country objectAtIndex:indexPath.row];
        
        return cell;
        
        
    }
    else if(tableView == _gender_tabledata)
    {
        static NSString *table = @"cell1";
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        cell.genderlbl_editprofile.text = [genderarry objectAtIndex:indexPath.row];
        
        return cell;
        
        
    }

    else
    {
        static NSString *table = @"cell2";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        cell.localelbl_editprofile.text = [locale objectAtIndex:indexPath.row];
        
        return cell;

    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _permit_tabledata)
    {
        _Permittype.text=[permit objectAtIndex:indexPath.row];
        _permit_tabledata.hidden = YES;
    }
    else if (tableView == _country_tabledata)
    {
        _countrytxt.text=[country objectAtIndex:indexPath.row];
        
        contrylist = [NSString stringWithFormat:@"%@",[[[adondata valueForKey:@"country"]objectAtIndex:indexPath.row] valueForKey:@"id"] ];
        _country_tabledata.hidden = YES;
    }
    else if (tableView == _gender_tabledata)
    {
        _Gender.text=[genderarry objectAtIndex:indexPath.row];
        _gender_tabledata.hidden = YES;
    }

    else
    {
        _Locale.text=[locale objectAtIndex:indexPath.row];
        _locale_tabledata.hidden = YES;
   }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)updatebtn:(id)sender
{
    
    cname = _companyName.text;
    fname =_Fname.text;
    lname=_Lname.text;
    Mobile=_Mobile.text;
    landline = _Landline.text;
    website =_Website.text;
    noofvehicle=_noofVehicle.text;
    contactPre=_ContactPreference.text;
    address1 = _Add1.text;
    address2 =_Add2.text;
    pincode=_pincode.text;
    city=_city.text;
    state=_state.text;
    permittyp = _Permittype.text;
    localetyp = _Locale.text;
    gender = _Gender.text;
    
    
    if([_Fname validate] & [_Lname validate] & [_Mobile validate] & [_Add1 validate] & [_Add2 validate] & [_pincode validate] & [_city validate] & [_state validate])
    {
        

        setdic=[[NSMutableDictionary alloc]init];
        
        [setdic setObject:[AppMethod getStringDefault:@"default_id"] forKey:@"user_id"];
        
        [setdic setObject:cname forKey:@"company_name"];
        [setdic setObject:fname forKey:@"firstname"];
        [setdic setObject:lname forKey:@"lastname"];
        [setdic setObject:Mobile forKey:@"mobile"];
        [setdic setObject:landline forKey:@"landline"];
        [setdic setObject:website forKey:@"website"];
        [setdic setObject:noofvehicle forKey:@"no_of_vehicle"];
        [setdic setObject:contactPre forKey:@"contact_preference"];
        [setdic setObject:address1 forKey:@"addressline1"];
        [setdic setObject:address2 forKey:@"addressline2"];
        [setdic setObject:pincode forKey:@"pincode"];
        [setdic setObject:city forKey:@"city"];
        [setdic setObject:state forKey:@"state"];
        [setdic setObject:permittyp forKey:@"permit"];
        [setdic setObject:localetyp forKey:@"locale"];
        
        NSString *rolStr = [AppMethod getStringDefault:@"default_role_json"];
        NSDictionary *roleDic = [AppMethod Parse_StringJson:rolStr];
        [setdic setObject:roleDic forKey:@"role"];
      


    if ([gender isEqualToString:@"Male"])
    {
        [setdic setObject:@"1" forKey:@"gender"];
    }
    else
    {
        [setdic setObject:@"2" forKey:@"gender"];
    }
    
         [setdic setObject:[self imageToNSString:_img.image] forKey:@"avatar"];
        if ([contrylist isEqualToString:@""])
        {
            [setdic setObject:@"1" forKey:@"country_id"];
        }
        else
        {
            [setdic setObject:contrylist forKey:@"country_id"];
        }
        
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
       [ProgressHUD show:@"Please wait..."];
  
    [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
    [manager POST:[baseurl stringByAppendingString:Editprofileurl] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
     
     {
         [ProgressHUD dismiss];
         BOOL boolean = [[dic12 valueForKey:@"status"] boolValue];
         if (boolean)
         {
             NSMutableDictionary *data = [dic12 valueForKey:@"data"];
             
             [AppMethod  setStringDefault:@"default_id" :[data valueForKey:@"id"]];
             
             [AppMethod  setStringDefault:@"default_access_token" :[data valueForKey:@"access_token"]];
             [AppMethod  setStringDefault:@"default_email" :[data valueForKey:@"email"]];
             
             [AppMethod  setStringDefault:@"default_fname" :[data valueForKey:@"firstname"]];
             [AppMethod  setStringDefault:@"default_lname" :[data valueForKey:@"lastname"]];
             [AppMethod  setStringDefault:@"default_profileImage" :[data valueForKey:@"avatar"]];
             
             
             [AppMethod  setStringDefault:@"default_Companyname" :[[data valueForKey:@"profile"] valueForKey:@"company_name"]];
             
             [AppMethod  setStringDefault:@"default_Mobile" :[[data valueForKey:@"profile"]valueForKey:@"mobile"]];
             [AppMethod  setStringDefault:@"default_Landline" :[[data valueForKey:@"profile"]valueForKey:@"landline"]];
             
             [AppMethod  setStringDefault:@"default_Permit" :[[data valueForKey:@"profile"]valueForKey:@"permit"]];
             
             [AppMethod  setStringDefault:@"default_noofVehicle" :[[data valueForKey:@"profile"]valueForKey:@"no_of_vehicle"]];
             [AppMethod  setStringDefault:@"default_website" :[[data valueForKey:@"profile"]valueForKey:@"website"]];
             [AppMethod  setStringDefault:@"default_locale" :[[data valueForKey:@"profile"]valueForKey:@"locale"]];
             
             [AppMethod  setStringDefault:@"default_Gender" :[[data valueForKey:@"profile"]valueForKey:@"gender"] ];
             
             
             
             [AppMethod  setStringDefault:@"default_RunmileApprove" :[[data valueForKey:@"profile"]valueForKey:@"approve"]];
             [AppMethod  setStringDefault:@"default_ContactPref" :[[data valueForKey:@"profile"]valueForKey:@"contact_preference"]];
             [AppMethod  setStringDefault:@"default_Address" :[[data valueForKey:@"profile"]valueForKey:@"address"]];
             
             [AppMethod  setStringDefault:@"default_AddressLine1" :[[data valueForKey:@"profile"]valueForKey:@"addressline1"]];
             
             [AppMethod  setStringDefault:@"default_AddressLine2" :[[data valueForKey:@"profile"]valueForKey:@"addressline2"]];
             [AppMethod  setStringDefault:@"default_pincode" :[[data valueForKey:@"profile"]valueForKey:@"pincode"]];
             [AppMethod  setStringDefault:@"default_City" :[[data valueForKey:@"profile"]valueForKey:@"city"]];
             
             [AppMethod  setStringDefault:@"default_State" :[[data valueForKey:@"profile"]valueForKey:@"state"]];
             
             
             [AppMethod  setStringDefault:@"default_Country" :[[data valueForKey:@"profile"]valueForKey:@"country"]];
             
             [AppMethod setStringDefault:@"default_TotalRate" :[[[data valueForKey:@"profile"] valueForKey:@"review"]objectForKey:@"totalRate"]];
             [AppMethod  setStringDefault:@"default_TotalReview" :[[[data valueForKey:@"profile"] valueForKey:@"review"]valueForKey:@"totalReview"]];
             [AppMethod  setStringDefault:@"default_OverAll" :[[[data valueForKey:@"profile"] valueForKey:@"review"] valueForKey:@"overAll"]];
             
             [AppMethod  setStringDefault:@"default_role" :[data valueForKey:@"role"]];
             NSString *roleStr = [AppMethod Parse_jsonToString:[data valueForKey:@"role"] ];
             [AppMethod  setStringDefault:@"default_role_json" :roleStr];
             
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:[dic12 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
             [al show];
             
         }
     }failure:^(NSURLSessionTask *operation, NSError *error)
     {
          [ProgressHUD dismiss];
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [al show];
        
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
        
        MyAccount_ViewController *inq = [self.storyboard instantiateViewControllerWithIdentifier:@"MyAccount_ViewController"];
        [self.navigationController pushViewController:inq animated:YES];


    }
}

- (IBAction)dropdown_permittype:(id)sender
{
    _permit_tabledata.hidden = NO;

}
- (IBAction)dropdown_locale:(id)sender
{
    _locale_tabledata.hidden = NO;
}
- (IBAction)dropdown_country:(id)sender
{
    _country_tabledata.hidden = NO;
}
- (IBAction)dropdown_gender:(id)sender
{
     _gender_tabledata.hidden = NO;
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

- (IBAction)Takeimgbtn:(id)sender
{
    _viewGalary.hidden = NO;
}

- (IBAction)closebtn:(id)sender
{
    _viewGalary.hidden = YES;
}
- (IBAction)gallarybtn:(id)sender
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    _viewGalary.hidden = YES;
 
}

- (IBAction)camerabtn:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    _viewGalary.hidden = YES;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.img.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
