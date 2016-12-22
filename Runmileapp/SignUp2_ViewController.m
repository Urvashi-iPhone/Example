//
// SignUp2_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/29/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "SignUp2_ViewController.h"
#import "Brand_TableViewCell.h"
#import "SignUp1_ViewController.h"
#import "ServiceDetails_TableViewCell.h"
#import "PartsDetail_TableViewCell.h"
#import "SWRevealViewController.h"
#import "httpws.h"
#import "Constant.h"
#import "AppMethod.h"
#import "tabbarcontroller.h"
#import "MyProfile_ViewController.h"
#import "Vehicle_Type_Capacity_New_TableViewCell.h"
#import "sidebarViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"

@interface SignUp2_ViewController ()<UITextFieldDelegate>

@end

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@implementation SignUp2_ViewController

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
    
    _termConditionCheck = NO;
    
    NSString *strdata=[NSString stringWithFormat:@"%@",_abcd];

    NSData *data = [strdata dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *dic12 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSMutableArray *usertype = [[dic12 valueForKey:@"data"] valueForKey:@"user_type"];
    
    _viewborder3.userInteractionEnabled = NO;
    _viewborder4.userInteractionEnabled = NO;
    _viewborder5.userInteractionEnabled = NO;
    
    //3-service  4-brand 5-parts
    for (int i = 0; i<[usertype count]; i++)
    {
    NSString *abc = [usertype objectAtIndex:i];
    if ([abc isEqualToString:@"user"])
    {
        
    }
    else if ([abc isEqualToString:@"dealer"])
    {
        _viewborder4.userInteractionEnabled = YES;
    }
    else if ([abc isEqualToString:@"seller"])
    {
        
    }
    else if ([abc isEqualToString:@"parts_dealer"])
    {
        _viewborder5.userInteractionEnabled = YES;
    }
    else if ([abc isEqualToString:@"transporter"])
    {
        _viewborder3.userInteractionEnabled = YES;
    }

    }
    
    
    //    _viewborder4.hidden = YES;
    //    _viewborder5.hidden = YES;
    //    _viewborder3.hidden = YES;
    //
    //    for (int i = 0; i<[usertype count]; i++)
    //    {
    //        NSString *abc = [usertype objectAtIndex:i];
    //        if ([abc isEqualToString:@"user"])
    //        {
    //            NSLog(@"%@",usertype);
    //        }
    //    else if ([abc isEqualToString:@"dealer"])
    //    {
    //        _viewborder4.hidden = NO;
    //    }
    //    else if ([abc isEqualToString:@"seller"])
    //    {
    //        NSLog(@"%@",usertype);
    //    }
    //    else if ([abc isEqualToString:@"parts_dealer"])
    //    {
    //        _viewborder5.hidden = NO;
    //    }
    //    else if ([abc isEqualToString:@"transporter"])
    //    {
    //        _viewborder3.hidden = NO;
    //    }
    //
    //    }

    
    
    [_companyname setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_fname setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_lname setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_mobile setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_landline setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_website setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_noofvehicle setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_contactPreference setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_Addressline1 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_Adressline2 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_pincode setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_city setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_state setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_txtgender setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_txtlocale setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_txtpicker setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_countrytxt setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    locale = @"";
    contry = @"";
    contactprefrence = @"";
    adondata = [[NSDictionary alloc]init];
    
    user = [[NSMutableArray alloc]init];
    user1 = [[NSMutableArray alloc]init];
    user2 = [[NSMutableArray alloc]init];
    user5 = [[NSMutableArray alloc]init];
    permit = [[NSMutableArray alloc]init];
    localee = [[NSMutableArray alloc]init];
    
    [self Get_adondata];

      serviceIdList=[[NSMutableArray alloc]init];
      brandIdList=[[NSMutableArray alloc]init];
      partIdList=[[NSMutableArray alloc]init];
    
    _registerbtn.layer.cornerRadius = 15.0;
    
    _imageborder.layer.borderColor = [[UIColor whiteColor]CGColor];
    _imageborder.layer.borderWidth = 1.0f;
    
    _viewborder1.layer.borderColor=[[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _viewborder1.layer.borderWidth= 1.0f;
    _viewborder1.layer.cornerRadius = 15.0;
    
    
    _viewborder2.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];
    _viewborder2.layer.borderWidth = 1.0f;
    _viewborder2.layer.cornerRadius = 15.0;
    
    _viewborder3.layer.borderColor = [[UIColor whiteColor]CGColor];
    _viewborder3.layer.borderWidth = 1.0f;
    _viewborder3.layer.cornerRadius = 15.0;
    
    _viewborder4.layer.borderColor = [[UIColor whiteColor]CGColor];
    _viewborder4.layer.borderWidth = 1.0f;
    _viewborder4.layer.cornerRadius = 15.0;
    
    _viewborder5.layer.borderColor = [[UIColor whiteColor]CGColor];
    _viewborder5.layer.borderWidth = 1.0f;
    _viewborder5.layer.cornerRadius = 15.0;
    
    _imageuplod.hidden=NO;

    _imageuplod.clipsToBounds=YES;

    _fname.delegate=self;
    _fname.presentInView=self.view;
    
    _lname.delegate=self;
    _lname.presentInView=self.view;
    
    _Addressline1.delegate=self;
    _Addressline1.presentInView=self.view;
    
    _Adressline2.delegate=self;
    _Adressline2.presentInView=self.view;
    
    _city.delegate=self;
    _city.presentInView=self.view;
    
    _state.delegate=self;
    _state.presentInView=self.view;
    
    [self setupAlerts];
   
    
    _view_Galary.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];
    _view_Galary.layer.borderWidth= 1.0f;
    _view_Galary.layer.cornerRadius = 15.0;
    _camerabtn.layer.cornerRadius = 17.0;
    _galarybtn.layer.cornerRadius = 17.0;
     _view_Galary.hidden = YES;
    
//    UITapGestureRecognizer *m2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handle)];
//    _imgview.userInteractionEnabled=YES;
//    
//    [m2 setNumberOfTapsRequired:1];
//    
//    [self.imgview addGestureRecognizer:m2];
    
    _gender_table.hidden = YES;
    genderarry=[[NSMutableArray alloc]initWithObjects:@"Male",@"Female",nil];
    
    _contactPreference_table.hidden = YES;
    contactPreferencearry=[[NSMutableArray alloc]initWithObjects:@"morning",@"noon",@"after noon",@"evening",nil];

 }

//
//-(void)handle
//{
//    [self.imgview endEditing:YES];
//}

-(void)setupAlerts
{
    [_fname addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Firstname cannot be blank."];
    [_lname addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Lastname cannot be blank."];
    
    [_Addressline1 addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Addressline1 cannot be blank."];
    [_Adressline2 addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Addressline2 cannot be blank."];

    [_city addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"City cannot be blank."];
    [_state addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@" State cannot be blank."];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)Get_adondata
{
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
    adondata = [dic valueForKey:@"data"];
    
    [self jsonparsing_servicedetail];
    [self jsonparsing_branddetail];
    [self jsonparsing_Partsdetail];
    [self jsonparsing_PermitType];
    _permit_table.hidden = YES;
    [self jsonparsing_CountryList];
    _country_tabledata.hidden = YES;
    [self jsonparsing_LocaleType];
    _LOCALE_TABLE.hidden = YES;
}


-(void)jsonparsing_LocaleType
{
    localetype=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"availabel_locale"]copyItems:YES];
    
    for (int i=0; i<[localetype count];i++)
    {
        NSDictionary *dic12 = [localetype objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [localee addObject:str1];
    }
    [_LOCALE_TABLE reloadData];
}


-(void)jsonparsing_servicedetail
{
    usrtype=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"transporter_service"]copyItems:YES];
    
    for (int i=0; i<[usrtype count];i++)
    {
        NSDictionary *dic12 = [usrtype objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [user addObject:str1];
    }
    [_servicetabledata reloadData];
}


-(void)jsonparsing_branddetail
{
    
    usrtype1=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"dealer_brand"]copyItems:YES];
    
    for (int i=0; i<[usrtype1 count];i++)
    {
        NSDictionary *dic121 = [usrtype1 objectAtIndex:i];
        NSString *str12 = [dic121 objectForKey:@"value"];
        
        [user1 addObject:str12];
    }
    [_brandtabledata reloadData];

}
-(void)jsonparsing_CountryList
{
    
    usrtype5=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"country"]copyItems:YES];
    
    for (int i=0; i<[usrtype5 count];i++)
    {
        NSDictionary *dic121 = [usrtype5 objectAtIndex:i];
        NSString *str12 = [dic121 objectForKey:@"value"];
        
        [user5 addObject:str12];
    }
    [_country_tabledata reloadData];
    
}
-(void)jsonparsing_Partsdetail
{
    usrtype2=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"parts_type"]copyItems:YES];
    
    for (int i=0; i<[usrtype2 count];i++)
    {
        NSDictionary *dic1211 = [usrtype2 objectAtIndex:i];
        NSString *str121 = [dic1211 objectForKey:@"value"];
        
        [user2 addObject:str121];
    }
    [_partstabledata reloadData];
    
}
-(void)jsonparsing_PermitType
{
    permittypee=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"permit_type"]copyItems:YES];
    
    for (int i=0; i<[permittypee count];i++)
    {
        NSDictionary *dic12112 = [permittypee objectAtIndex:i];
        NSString *str1212 = [dic12112 objectForKey:@"value"];
        
        [permit addObject:str1212];
    }
    [_permit_table reloadData];
    
}



-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == _txtpicker)
    {
        _permit_table.hidden = NO;
        
        [self.permit_table reloadData];
    }
  else if (textField == _txtlocale)
    {
        _LOCALE_TABLE.hidden = NO;
        
        [self.LOCALE_TABLE reloadData];    }

    else
    {
    _country_tabledata.hidden = NO;
    
    [self.country_tabledata reloadData];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    NSInteger count;
 
    if (tableView == _servicetabledata)
    {
        count = [user count];
      //  [self setTableViewheightOfTable:_servicetabledata ByArrayName:user];
        
//        float x = CGRectGetMaxX([_viewborder1 convertRect:_viewborder1.frame toView:self.view]);
//        float y = CGRectGetMinY([_viewborder1 convertRect:_viewborder1.frame toView:self.view]);
//        
//        CGRect frame = self.servicetabledata.frame;
//        frame.origin.y = y;
        
       // self.servicetabledata.frame = frame;
        
        
        
    }
    else if(tableView == _brandtabledata)
    {
        count = [user1 count];
      //  [self setTableViewheightOfTable:_brandtabledata ByArrayName:user1];
//        
//        float x = CGRectGetMaxX([_servicetabledata convertRect:_servicetabledata.frame toView:self.view]);
//        float y = CGRectGetMinY([_servicetabledata convertRect:_servicetabledata.frame toView:self.view]);
//        
//        CGRect frame = self.brandtabledata.frame;
//        frame.origin.y = y;
//        
//        self.brandtabledata.frame = frame;
     
    }
    else if(tableView == _partstabledata)
    {
        count = [user2 count];
       // [self setTableViewheightOfTable:_partstabledata ByArrayName:user2];
        
//        float x = CGRectGetMinX([_brandtabledata convertRect:_brandtabledata.frame toView:self.view]);
//        float y = CGRectGetMinY([_brandtabledata convertRect:_brandtabledata.frame toView:self.view]);
//        
//        CGRect frame = self.partstabledata.frame;
//        frame.origin.y = y;
//        
//        self.partstabledata.frame = frame;

    }
    else if(tableView == _country_tabledata)
    {
         count = [user5 count];
    }
    else if (tableView == _permit_table)
        
    {
       return [permit count];
    }
    else if (tableView == _LOCALE_TABLE)
    {
        return [localee count];
    }
    else if(tableView == _gender_table)
    {
        return [genderarry count];
    }
    else if(tableView == _contactPreference_table)
    {
        return [contactPreferencearry count];
    }

    return count;

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _servicetabledata)
    {
    
        static NSString *table = @"cell2";
    
        ServiceDetails_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
         [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
    
        if (cell == nil)
        {
        
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:table];
        
        }
        
        
        cell.lblServiceName.text = [user objectAtIndex:indexPath.row];
        
        cell.servicecheckbtn.tag=indexPath.row;
        [cell.servicecheckbtn addTarget:self action:@selector(ChkUnChk_Service:) forControlEvents:UIControlEventTouchUpInside];
 
        return cell;
    
    }

    else if (tableView == _brandtabledata)
    {
        static NSString *table = @"cell3";
        
        Brand_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:table];
            
        }
        cell.lblBrandname.text = [user1 objectAtIndex:indexPath.row];
        
        cell.brandcheckbtn.tag=indexPath.row;
        [cell.brandcheckbtn addTarget:self action:@selector(ChkUnChk_Brand:) forControlEvents:UIControlEventTouchUpInside];

        return cell;

    }
    else if (tableView == _partstabledata)
    {
        static NSString *table = @"cell1";
        
        PartsDetail_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:table];
            
        }
        
      
        cell.lblpartsname.text = [user2 objectAtIndex:indexPath.row];
        
        cell.partscheckbtn.tag=indexPath.row;
        [cell.partscheckbtn addTarget:self action:@selector(ChkUnChk_Parts:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }
    else if (tableView == _country_tabledata)
    {
        static NSString *table = @"cell4";
        
        Brand_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:table];
            
        }
        cell.countrylbl.text = [user5 objectAtIndex:indexPath.row];
        return cell;
    }
   else if (tableView == _permit_table)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        cell.permitlbl_signup2.text = [permit objectAtIndex:indexPath.row];
        
        return cell;
        
    }
   else if(tableView == _gender_table)
   {
       static NSString *table = @"cell1";
       Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
       //ipad tablview clear color
       [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
       if (cell == nil)
       {
           cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
           
           
       }
       cell.genderlbl_brand.text = [genderarry objectAtIndex:indexPath.row];
       
       return cell;
       
       
   }
   else if(tableView == _contactPreference_table)
   {
       static NSString *table = @"cell1";
       Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
       //ipad tablview clear color
       [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
       if (cell == nil)
       {
           cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
           
           
       }
       cell.contactPre_lable.text = [contactPreferencearry objectAtIndex:indexPath.row];
       
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
       cell.localelbl_brand.text = [localee objectAtIndex:indexPath.row];
       
       return cell;
       
   }
    

    

    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 if (tableView == _country_tabledata)
    {
        _countrytxt.text=[user5 objectAtIndex:indexPath.row];
        contry = [NSString stringWithFormat:@"%@",[[[adondata valueForKey:@"country"]objectAtIndex:indexPath.row] valueForKey:@"id"] ];
        _country_tabledata.hidden = YES;
        
    }
    else if (tableView == _permit_table)
    {
        _txtpicker.text=[permit objectAtIndex:indexPath.row];
        _permit_table.hidden = YES;
    }
    else if (tableView == _gender_table)
    {
        _txtgender.text=[genderarry objectAtIndex:indexPath.row];
        _gender_table.hidden = YES;
    }
    else if (tableView == _contactPreference_table)
    {
        _contactPreference.text=[contactPreferencearry objectAtIndex:indexPath.row];
        _contactPreference_table.hidden = YES;
    }
    else
    {
        _txtlocale.text=[localee objectAtIndex:indexPath.row];
         locale = [[[adondata valueForKey:@"availabel_locale"]objectAtIndex:indexPath.row] valueForKey:@"id"];
        _LOCALE_TABLE.hidden = YES;
    }


}
-(void)ChkUnChk_Service:(id)sender
{
    UIButton *btn=(UIButton *)sender;
  
    NSString *Str=[NSString stringWithFormat:@"%d",btn.tag];
   
    BOOL flag=   [serviceIdList containsObject:Str];
    
    if (flag==YES)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"uncheck.png"]forState:UIControlStateNormal];
        [serviceIdList removeObject:Str];
    }
    else
    {
        [serviceIdList addObject:Str];
        [btn setBackgroundImage:[UIImage imageNamed:@"check.png"]forState:UIControlStateNormal];
    }
}

-(void)ChkUnChk_Brand:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
    NSString *Str=[NSString stringWithFormat:@"%d",btn.tag];
    
    BOOL flag=   [brandIdList containsObject:Str];
    
    if (flag==YES)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"uncheck.png"]forState:UIControlStateNormal];
        [brandIdList removeObject:Str];
    }
    else
    {
        [brandIdList addObject:Str];
        [btn setBackgroundImage:[UIImage imageNamed:@"check.png"]forState:UIControlStateNormal];
    }
}

-(void)ChkUnChk_Parts:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
    NSString *Str=[NSString stringWithFormat:@"%d",btn.tag];
    
    BOOL flag=   [partIdList containsObject:Str];
    
    if (flag==YES)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"uncheck.png"]forState:UIControlStateNormal];
        [partIdList removeObject:Str];
    }
    else
    {
        [partIdList addObject:Str];
        [btn setBackgroundImage:[UIImage imageNamed:@"check.png"]forState:UIControlStateNormal];
    }
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

- (IBAction)dropdown_permittyp:(id)sender
{
    _permit_table.hidden = NO;
}

- (IBAction)dropdown_locale:(id)sender
{
     _LOCALE_TABLE.hidden = NO;
}

- (IBAction)dropdown_gender:(id)sender
{
     _gender_table.hidden = NO;
}

- (IBAction)dropdown_contactPreferenc:(id)sender
{
    _contactPreference_table.hidden = NO;
}

- (IBAction)registerbtn:(id)sender
{
    comName=_companyname.text;
    fname=_fname.text;
    lname=_lname.text;
    
    mobile=_mobile.text;
    landline=_landline.text;
    website=_website.text;
    permittypee=_txtpicker.text;
    noofvehicle=_noofvehicle.text;
   
    gender=_txtgender.text;
 
    contactprefrence=_contactPreference.text;
    add1=_Addressline1.text;
    add2=_Adressline2.text;
    pincode=_pincode.text;
    city=_city.text;
    state=_state.text;
   
    
    
    if([_fname validate] & [_lname validate] & [_Addressline1 validate] & [_Adressline2 validate] & [_city validate] & [_state validate])
    {
        
        //tableview validation
        
        if ([_viewborder4 isUserInteractionEnabled])
        {
            
            if ([brandIdList count]<1)
            {
                UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Select minimum one brand" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [al show];
                return;
            }
        }
        if ([_viewborder3 isUserInteractionEnabled])
        {
            if ([serviceIdList count]<1)
            {
                UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Select minimum one Service" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [al show];
                return;
            }
        }
        if ([_viewborder5 isUserInteractionEnabled])
        {
            if ([partIdList count]<1)
            {
                UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Select minimum one Parts" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [al show];
                return;
            }
        }

        
        //tableview validation
        if (!_termConditionCheck)
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Accept Term & Condition." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [al show];
            return;
        }
        
        NSString *strdata=[NSString stringWithFormat:@"%@",_abcd];
        NSData *data = [strdata dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *dic12 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        setdic=[[NSMutableDictionary alloc]init];
        [setdic setObject:[[dic12 valueForKey:@"data"] valueForKey:@"email"] forKey:@"email"];
        [setdic setObject:[[dic12 valueForKey:@"data"] valueForKey:@"password"] forKey:@"password"];
        [setdic setObject:[[dic12 valueForKey:@"data"] valueForKey:@"username"] forKey:@"username"];
        [setdic setObject:[[dic12 valueForKey:@"data"] valueForKey:@"user_type"] forKey:@"user_type"];
        [setdic setObject:[[dic12 valueForKey:@"data"] valueForKey:@"user_type"] forKey:@"role"];

        [setdic setObject:comName forKey:@"company_name"];
        [setdic setObject:fname forKey:@"firstname"];
        [setdic setObject:lname forKey:@"lastname"];
        [setdic setObject:mobile forKey:@"mobile"];
        [setdic setObject:landline forKey:@"landline"];
        [setdic setObject:website forKey:@"website"];
        
        NSMutableArray *brandList = [[NSMutableArray alloc] init];
        for (int i = 0; i<[brandIdList count]; i++)
        {
            NSMutableDictionary *dealerBrand = [[adondata valueForKey:@"dealer_brand"] objectAtIndex:i];
            [brandList addObject:[dealerBrand valueForKey:@"id"]];
        }
       [setdic setObject:brandList forKey:@"brands"];
        
        NSMutableArray *serviceList = [[NSMutableArray alloc] init];
        for (int i = 0; i<[serviceIdList count]; i++)
        {
            NSMutableDictionary *service = [[adondata valueForKey:@"transporter_service"] objectAtIndex:i];
            [serviceList addObject:[service valueForKey:@"id"]];
        }
        [setdic setObject:serviceList forKey:@"services"];
        
        NSMutableArray *partsList = [[NSMutableArray alloc] init];
        for (int i = 0; i<[partIdList count]; i++)
        {
            NSMutableDictionary *parts = [[adondata valueForKey:@"parts_type"] objectAtIndex:i];
            [partsList addObject:[parts valueForKey:@"id"]];
        }
        [setdic setObject:partsList forKey:@"parts"];
        
        
        //bydefault select value dropdown
    
        if ([locale isEqualToString:@""])
        {
         
            [setdic setObject:[[[adondata valueForKey:@"availabel_locale"]objectAtIndex:0]valueForKey:@"id"] forKey:@"locale"];
        }
        else
        {
            [setdic setObject:locale forKey:@"locale"];
        }
    
        if ([gender isEqualToString:@"Male"])
        {
            [setdic setObject:@"1" forKey:@"gender"];
        }
        else
        {
            [setdic setObject:@"2" forKey:@"gender"];
        }
    
    
        if ([permittype isEqualToString:@"All India Permit"])
        {
            [setdic setObject:@"1" forKey:@"permit_type_id"];
        }
        else
        {
            [setdic setObject:@"2" forKey:@"permit_type_id"];
        }
    
    
        if ([contry isEqualToString:@""])
        {
            [setdic setObject:[[[adondata valueForKey:@"country"]objectAtIndex:0]valueForKey:@"id"] forKey:@"country_id"];
            
        }
        else
        {
            [setdic setObject:contry forKey:@"country_id"];
        }

        
        [setdic setObject:[self imageToNSString:_imageuplod.image] forKey:@"avatar"];
        
        if ([contactprefrence isEqualToString:@""])
        {
            [setdic setObject:[contactPreferencearry objectAtIndex:0] forKey:@"contact_preference"] ;
            
        }
        else
        {
            [setdic setObject:contactprefrence forKey:@"contact_preference"];
        }
        
       
        [setdic setObject:add1 forKey:@"addressline1"];
        [setdic setObject:add2 forKey:@"addressline2"];
        [setdic setObject:pincode forKey:@"pincode"];
        [setdic setObject:city forKey:@"city"];
        [setdic setObject:state forKey:@"state"];
    
        NSMutableDictionary *device = [[NSMutableDictionary alloc]init];
        [device setObject:@"abcd" forKey:@"udid"];
        [device setObject:@"abc" forKey:@"token"];
        [device setObject:@"phone" forKey:@"type"];
        [device setObject:@"ios" forKey:@"os"];
        [setdic setObject:device forKey:@"device"];
        
    
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
         [ProgressHUD show:@"Please wait..."];
        [manager POST:[baseurl stringByAppendingString:Signup2url] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic1)
        {
            [ProgressHUD dismiss];
            BOOL boolean = [[dic1 valueForKey:@"status"] boolValue];
            if (boolean)
            {
                SWRevealViewController *sc=[self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                
                    NSMutableDictionary *data = [dic1 valueForKey:@"data"];
                    [AppMethod  setStringDefault:@"default_id" :[data valueForKey:@"id"]];
                    [AppMethod  setStringDefault:@"default_access_token" :[data valueForKey:@"access_token"]];
                    [AppMethod  setStringDefault:@"default_email" :[data valueForKey:@"email"]];
                    [AppMethod  setStringDefault:@"default_fname" :[data valueForKey:@"firstname"]];
                    [AppMethod  setStringDefault:@"default_lname" :[data valueForKey:@"lastname"]];
                    [AppMethod  setStringDefault:@"default_profileImage" :[data valueForKey:@"avatar"]];
                    [AppMethod  setStringDefault:@"default_role" :[data valueForKey:@"role"]];
                NSLog(@"%@",[data valueForKey:@"role"]);
                    [self.navigationController pushViewController:sc animated:YES];
            }
            else
                
            {
                UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[dic1 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                
                [al show];
            }
            

        }failure:^(NSURLSessionTask *operation, NSError *error) {
            [ProgressHUD dismiss];
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [al show];
            
        }];

    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self.navigationController presentedViewController];
    }
    
}


- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)uncheckbtn:(id)sender
{
    [_uncheckbtn addTarget:self action:@selector(ChkUnChk_TermCondition:) forControlEvents:UIControlEventTouchUpInside];
}



- (IBAction)Dropdowncounty:(id)sender
{
     _country_tabledata.hidden = NO;
}


- (IBAction)btnimg:(id)sender
{
    _view_Galary.hidden = NO;
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

- (NSString *)imageToNSString:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}
- (IBAction)camerabtn:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    _view_Galary.hidden = YES;
 
}
- (IBAction)galarybtn:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    _view_Galary.hidden = YES;
 
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageuplod.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (IBAction)closebtn:(id)sender
{
    _view_Galary.hidden = YES;
}
@end
