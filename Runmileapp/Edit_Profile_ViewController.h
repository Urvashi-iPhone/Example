//
//  Edit_Profile_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/16/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

#define REGEX_TEXTFIELD_LIMIT @"^[A-Za-z0-9]{1}+[A-Za-z0-9 .]{1,}"

#define REGEX_PHONE_DEFAULT @"^[+]?[0-9]{10,13}$"

@interface Edit_Profile_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
     NSMutableArray *permit,*permittype,*genderarry;
     NSMutableArray *locale,*localetype;
    NSMutableArray *country,*countrytype;
    
      NSMutableDictionary *setdic;
       NSString *cname,*fname,*lname,*Mobile,*landline,*website,*noofvehicle,*contactPre,*address1,*address2,*pincode,*city,*state,*permittyp,*localetyp,*gender,*contrylist;
    
    CGFloat animatedDistance;
    NSDictionary *adondata;
}
- (IBAction)Takeimgbtn:(id)sender;
- (IBAction)closebtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewGalary;

@property (weak, nonatomic) IBOutlet UIButton *camerabtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;

@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@property (weak, nonatomic) IBOutlet UIButton *gallarybtn;
- (IBAction)gallarybtn:(id)sender;

- (IBAction)camerabtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *border1;

@property (weak, nonatomic) IBOutlet UIView *border2;
@property (weak, nonatomic) IBOutlet UITextField *companyName;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Fname;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Lname;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Mobile;
@property (weak, nonatomic) IBOutlet UITextField *Landline;

@property (weak, nonatomic) IBOutlet UITextField *Website;
@property (weak, nonatomic) IBOutlet UITextField *Permittype;

- (IBAction)dropdown_permittype:(id)sender;


@property (weak, nonatomic) IBOutlet UITableView *permit_tabledata;

@property (weak, nonatomic) IBOutlet UITextField *noofVehicle;
@property (weak, nonatomic) IBOutlet UITextField *Locale;

- (IBAction)dropdown_locale:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *locale_tabledata;

@property (weak, nonatomic) IBOutlet UITextField *Gender;

- (IBAction)dropdown_gender:(id)sender;


@property (weak, nonatomic) IBOutlet UITableView *gender_tabledata;



@property (weak, nonatomic) IBOutlet UITextField *ContactPreference;

@property (weak, nonatomic) IBOutlet TextFieldValidator *Add1;

@property (weak, nonatomic) IBOutlet TextFieldValidator *Add2;
@property (weak, nonatomic) IBOutlet TextFieldValidator *pincode;

@property (weak, nonatomic) IBOutlet TextFieldValidator *city;
@property (weak, nonatomic) IBOutlet TextFieldValidator *state;
@property (weak, nonatomic) IBOutlet UIButton *updatebtn;

- (IBAction)updatebtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *countrytxt;
- (IBAction)dropdown_country:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *country_tabledata;

@end
