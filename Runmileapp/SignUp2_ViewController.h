//
//  SignUp2_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/29/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TextFieldValidator.h"

#define REGEX_TEXTFIELD_LIMIT @"^[A-Za-z0-9]{1}+[A-Za-z0-9 .]{1,}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"[A-Za-z0-9]{6,20}"


@interface SignUp2_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
   NSMutableArray *usrtype,*user;
    NSMutableArray *usrtype1,*user1;
    NSMutableArray *usrtype2,*user2;
   
    NSMutableArray *usrtype4,*user4;
    NSMutableArray *usrtype5,*user5;
    

    NSMutableArray *permit,*permittypee,*genderarry,*contactPreferencearry;
    NSMutableArray *localee,*localetype;

    
    NSMutableDictionary *setdic;
    
    NSMutableArray *brandIdList,*serviceIdList,*partIdList;
    NSString *comName,*fname,*lname,*mobile,*landline,*website,*permittype,*noofvehicle,*locale,*gender,*profilepic,*contactprefrence,*add1,*add2,*pincode,*city,*state,*contry;
    
    CGFloat animatedDistance;
    
    NSDictionary *adondata;
  
    
}
@property (weak, nonatomic) IBOutlet UIView *imageborder;
@property (weak, nonatomic) IBOutlet UIView *view_Galary;
@property (weak, nonatomic) IBOutlet UIButton *camerabtn;
- (IBAction)camerabtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *galarybtn;
- (IBAction)galarybtn:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *imgview;

@property (weak, nonatomic) IBOutlet UITableView *country_tabledata;

- (IBAction)btnimg:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *uncheckbtn;


- (IBAction)imagebtn:(id)sender;
- (IBAction)uncheckbtn:(id)sender;

- (IBAction)Dropdowncounty:(id)sender;

//@property (nullable, nonatomic, strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *imageuplod;

-(IBAction)imagebtn:(id)sender;

- (IBAction)image_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtgender;
@property (weak, nonatomic) IBOutlet UITextField *txtlocale;
@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;
@property (weak, nonatomic) IBOutlet UIButton *registerbtn;
@property (weak, nonatomic) IBOutlet UITextField *companyname;
@property (weak, nonatomic) IBOutlet TextFieldValidator *fname;
@property (weak, nonatomic) IBOutlet TextFieldValidator *lname;
@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (weak, nonatomic) IBOutlet UITextField *landline;
@property (weak, nonatomic) IBOutlet UITextField *website;
@property (weak, nonatomic) IBOutlet UITextField *noofvehicle;
@property (weak, nonatomic) IBOutlet UITextField *contactPreference;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Addressline1;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Adressline2;
@property (weak, nonatomic) IBOutlet UITextField *pincode;
@property (weak, nonatomic) IBOutlet TextFieldValidator *city;
@property (weak, nonatomic) IBOutlet UITextField *txtpicker;
@property (weak, nonatomic) IBOutlet TextFieldValidator *state;
@property (weak, nonatomic) IBOutlet UITextField *countrytxt;

- (IBAction)dropdown_permittyp:(id)sender;
- (IBAction)dropdown_locale:(id)sender;
- (IBAction)dropdown_gender:(id)sender;
- (IBAction)dropdown_contactPreferenc:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *permit_table;
@property (weak, nonatomic) IBOutlet UITableView *gender_table;
@property (weak, nonatomic) IBOutlet UITableView *LOCALE_TABLE;
@property (weak, nonatomic) IBOutlet UITableView *contactPreference_table;

- (IBAction)registerbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewborder3;
@property (weak, nonatomic) IBOutlet UIView *viewborder4;
@property (weak, nonatomic) IBOutlet UIView *viewborder5;

@property (weak, nonatomic) IBOutlet UIView *viewborder2;
@property (weak, nonatomic) IBOutlet UIView *viewborder1;
- (IBAction)backbtn:(id)sender;

@property(nonatomic)NSString *abcd;


@property (weak, nonatomic) IBOutlet UITableView *servicetabledata;
@property (weak, nonatomic) IBOutlet UITableView *brandtabledata;

@property (weak, nonatomic) IBOutlet UITableView *partstabledata;

@property (nonatomic)BOOL termConditionCheck;
@end
