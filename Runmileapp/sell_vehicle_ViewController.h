//
//  sell_vehicle_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/24/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

@interface sell_vehicle_ViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableDictionary *setdic;
    NSString *uid,*c_name,*fname,*lname,*email,*mobile,*name,*fual_type,*brand,*version,*color,*make_year,*regi_year,*no_owner,*km_driven,*city,*puc,*reg_rto,*ins_valid,*price,*additional_info,*motor_vehi,*capacity,*capacity_unit,*is_new,*status,*isTermAc;
    NSMutableArray *vtype,*vtypedata;
    NSMutableArray *capacityUnit,*capacityUnittype;
    NSMutableArray *fualtyp,*statustype,*isnewtyp;
     CGFloat animatedDistance;
    NSMutableArray *brandtyp,*brandtypedata;
    NSMutableArray *citytyp,*citytypdata;
    NSDictionary *adondata;
}


@property (weak, nonatomic) IBOutlet UIView *viewGallary;

@property (weak, nonatomic) IBOutlet UIButton *camerabtn;
- (IBAction)camerabtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *gallarybtn;

- (IBAction)gallarybtn:(id)sender;
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
@property (strong, nonatomic) IBOutlet UIView *Main_view;

@property (weak, nonatomic) IBOutlet TextFieldValidator *Version;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Color;
@property (weak, nonatomic) IBOutlet UITextField *Make_Year;
@property (weak, nonatomic) IBOutlet UITextField *Registration_year;
@property (weak, nonatomic) IBOutlet TextFieldValidator *NoofOwner;
@property (weak, nonatomic) IBOutlet TextFieldValidator *City;
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

- (IBAction)dropdown_brand:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *Status;

- (IBAction)dropdown_status:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dropdown_brand;
@property (weak, nonatomic) IBOutlet UITableView *brand_table;

@property (weak, nonatomic) IBOutlet UITableView *status_tabledata;



@property (weak, nonatomic) IBOutlet UITextView *AddInfo;

@property (weak, nonatomic) IBOutlet UITextField *IsNew;
- (IBAction)dropdown_isnew:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *isnew_tabledata;

@property (weak, nonatomic) IBOutlet UIButton *AddImage;
@property (weak, nonatomic) IBOutlet UIButton *createbtn;
- (IBAction)createbtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *vehicledata;

@property (nonatomic)NSMutableArray *imagelist;

- (IBAction)AddImage:(id)sender;

@property (nonatomic)NSInteger vehicleimg_position;

@property (weak, nonatomic) IBOutlet TextFieldValidator *Addinfotxt;
- (IBAction)uncheckbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *uncheckbtn;
@property (nonatomic)BOOL termConditionCheck;
- (IBAction)dropdown_city:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *city_table;

@end
