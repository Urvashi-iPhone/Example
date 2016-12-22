//
//  Edit_Vehicle_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/23/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

#define REGEX_TEXTFIELD_LIMIT @"^[A-Za-z0-9]{1}+[A-Za-z0-9 .]{1,}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"[A-Za-z0-9]{6,20}"
#define REGEX_TEXTVIEW @"[\\S ]{3,}"

@interface Edit_Vehicle_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableDictionary *setdic;
    
    
    NSString *user_id,*c_name,*fname,*lname,*email,*mobile,*name,*fual_type,*brand,*version,*color,*make_year,*regi_year,*no_owner,*km_driven,*city,*puc,*reg_rto,*ins_valid,*price,*additional_info,*vehicle_typ,*capacity,*capacity_unit,*is_new,*status,*isTermAc;
    
    NSMutableArray *vtype,*vtypedata;
    NSMutableArray *capacityUnit,*capacityUnittype;
    NSMutableArray *fualtyp,*statustype,*isnewtyp;
     NSMutableArray *brandtyp,*brandtypedata;
      NSMutableArray *citytyp,*citytypdata;
    CGFloat animatedDistance;
    NSDictionary *adondata;
}
@property (weak, nonatomic) IBOutlet UITableView *brand_table;

@property (weak, nonatomic) IBOutlet UIView *viewGalary;
@property (weak, nonatomic) IBOutlet UIButton *camerabtn;
- (IBAction)camerabtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *galarybtn;

- (IBAction)galarybtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dropdown_brand;
- (IBAction)dropdown_brand:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrview;

@property (weak, nonatomic) IBOutlet UIView *viewborder1;
@property (weak, nonatomic) IBOutlet UIView *viewborder2;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@property (weak, nonatomic) IBOutlet UITextField *CompanyName;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Fname;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Lname;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Email;

@property (weak, nonatomic) IBOutlet UITextField *Mobile;

@property (weak, nonatomic) IBOutlet TextFieldValidator *Name;
@property (weak, nonatomic) IBOutlet UITextField *FualType;
@property (weak, nonatomic) IBOutlet UITableView *fual_tabledata;

- (IBAction)dropdown_fual:(id)sender;

@property (weak, nonatomic) IBOutlet TextFieldValidator *Brand;

@property (weak, nonatomic) IBOutlet TextFieldValidator *Version;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Color;
@property (weak, nonatomic) IBOutlet UITextField *Make_Year;
@property (weak, nonatomic) IBOutlet UITextField *Registration_year;
@property (weak, nonatomic) IBOutlet TextFieldValidator *NoofOwner;
@property (weak, nonatomic) IBOutlet UITextField *City;
@property (weak, nonatomic) IBOutlet TextFieldValidator *KmDriven;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Insurance_Valid;
@property (weak, nonatomic) IBOutlet TextFieldValidator *PUC;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Price;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Registration_RTO;
@property (weak, nonatomic) IBOutlet UITextField *Type;
- (IBAction)Type_dropdown:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *type_tabledata;


@property (weak, nonatomic) IBOutlet TextFieldValidator *Capacity;
@property (weak, nonatomic) IBOutlet UITextField *CapacityUnit;

- (IBAction)dropdown_capacityUnit:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *capacityUnit_tabledata;

@property (weak, nonatomic) IBOutlet UITextField *Status;

- (IBAction)dropdown_status:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *status_tabledata;



@property (weak, nonatomic) IBOutlet UITextView *AddInfo;

@property (weak, nonatomic) IBOutlet UITextField *IsNew;
- (IBAction)dropdown_isnew:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *isnew_tabledata;

@property (weak, nonatomic) IBOutlet UIButton *AddImage;
@property (weak, nonatomic) IBOutlet UIButton *Updatebtn;

- (IBAction)updatebtn:(id)sender;


@property (weak, nonatomic) IBOutlet UITableView *vehicledata;

@property (nonatomic)NSMutableArray *imagelist;

- (IBAction)AddImage:(id)sender;


@property (nonatomic)NSDictionary *vehicleedit;


@property (nonatomic)NSInteger vehicleimg_position;
- (IBAction)uncheckbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *uncheckbtn;
@property (nonatomic)BOOL termConditionCheck;
- (IBAction)dropdown_city:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *city_table;
@end
