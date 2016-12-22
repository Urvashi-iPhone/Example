//
//  PostRequest_Vehicle_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/7/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

#define REGEX_TEXTFIELD_LIMIT @"^[A-Za-z0-9]{1}+[A-Za-z0-9 .]{1,}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"[A-Za-z0-9]{6,20}"
#define REGEX_TEXTVIEW @"[\\S ]{3,}"

@interface PostRequest_Vehicle_ViewController : UIViewController
{
    NSMutableString *name,*c_name,*email,*mobile,*landline,*address1,*address2,*fuel_type,*brand,*version,*color,*make_year,*year_registration,*no_of_owners,*km_driven,*city,*puc,*rigister_rto,*insurance_valid,*price,*additional_info,*vehicle_type_id,*capacity,*capacity_unit,*is_new;
    NSMutableArray *fualtyp,*Isnew;
    NSMutableDictionary *setdic;
    NSMutableArray *vtype,*vtypedata;
    NSMutableArray *capacityUnit,*capacityUnittype;
    NSMutableDictionary *adon_dic;
     NSMutableArray *citytyp,*citytypdata;
     NSMutableArray *brandtyp,*brandtypedata;
    CGFloat animatedDistance;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;
- (IBAction)submitbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitbtn;

@property (weak, nonatomic) IBOutlet TextFieldValidator *name;
@property (weak, nonatomic) IBOutlet UITextField *CompanyName;

@property (weak, nonatomic) IBOutlet TextFieldValidator *Email;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Mobile;
@property (weak, nonatomic) IBOutlet UITextField *Landline;
@property (weak, nonatomic) IBOutlet TextFieldValidator *AddressLine1;
@property (weak, nonatomic) IBOutlet TextFieldValidator *AddressLine2;
@property (weak, nonatomic) IBOutlet UIView *border1;
@property (weak, nonatomic) IBOutlet UIView *border2;
@property (weak, nonatomic) IBOutlet UITextField *Brand;
@property (weak, nonatomic) IBOutlet UITextField *Version;
@property (weak, nonatomic) IBOutlet UITextField *Color;
@property (weak, nonatomic) IBOutlet UITextField *MakeYear;
@property (weak, nonatomic) IBOutlet UITextField *RegistrationYear;
@property (weak, nonatomic) IBOutlet UITextField *FualType;
- (IBAction)dropdown_fualType:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *fual_tabledata;
@property (weak, nonatomic) IBOutlet TextFieldValidator *addInfoTxt;


@property (weak, nonatomic) IBOutlet UITextField *NoOfOwners;
@property (weak, nonatomic) IBOutlet UITextField *KmDriven;
@property (weak, nonatomic) IBOutlet UITextField *City;
@property (weak, nonatomic) IBOutlet UITextField *InsuranceValid;
@property (weak, nonatomic) IBOutlet UITextField *Puc;
@property (weak, nonatomic) IBOutlet UITextField *Type;
@property (weak, nonatomic) IBOutlet UITextField *RegistrationRTO;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Capacity;
@property (weak, nonatomic) IBOutlet UITextField *Price;
@property (weak, nonatomic) IBOutlet UITextView *Add_info;
@property (weak, nonatomic) IBOutlet UITextField *CapacityUnit;
@property (weak, nonatomic) IBOutlet UITextField *IsNew;

- (IBAction)dropdown_IsNew:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *isnew_tabledata;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
- (IBAction)dropdown_vehicletype:(id)sender;

- (IBAction)dropdown_CapacityUnit:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *type_tabledata;

@property (weak, nonatomic) IBOutlet UITableView *capacityUnit_tabledata;

@property (weak, nonatomic) IBOutlet UITableView *city_table;
@property (weak, nonatomic) IBOutlet UITableView *table_brand;

- (IBAction)dropdown_city:(id)sender;
- (IBAction)dropdown_brand:(id)sender;

@end
