//
//  Edit_Trip_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/24/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

#define REGEX_TEXTFIELD_LIMIT @"^[A-Za-z0-9]{1}+[A-Za-z0-9 .]{1,}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"[A-Za-z0-9]{6,20}"
#define REGEX_TEXTVIEW @"[\\S ]{3,}"


@interface Edit_Trip_ViewController : UIViewController

{
    NSMutableArray *vtype,*vtypedata,*permittyp,*capacitytyp,*capacityUnittype,*cargotyp,*cargo,*statustyp,*isGPStyp;
    NSMutableArray *permit,*permittype;
    NSMutableDictionary *setdic;
    
    NSString *tripimage,*title,*from_add,*to_add,*start_time,*end_time,*approx_dist,*price,*parts_load,*status,*cargo_type,*descri,*load_add,*unload_add,*brand,*model,*capacity,*capacity_unit,*permitt,*vehicle_type,*gps,*vehicle_no,*uid;
    
    CGFloat animatedDistance;
    NSDictionary *adondata;
}
@property (weak, nonatomic) IBOutlet UIView *viewFilter;
@property (weak, nonatomic) IBOutlet UIButton *camerabtn;
- (IBAction)camerabtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *galarybtn;
- (IBAction)galarybtn:(id)sender;

- (IBAction)takeImagebtn:(id)sender;


@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@property (weak, nonatomic) IBOutlet UIView *border1;

@property (weak, nonatomic) IBOutlet UIView *border2;
@property (weak, nonatomic) IBOutlet UIView *border3;
@property (weak, nonatomic) IBOutlet UITableView *isGPS_table;

@property (weak, nonatomic) IBOutlet UITableView *VehicleType_table;
@property (weak, nonatomic) IBOutlet UITableView *cargoType_table;
@property (weak, nonatomic) IBOutlet UITableView *statustyp_table;

@property (weak, nonatomic) IBOutlet UITableView *Permittype_table;
@property (weak, nonatomic) IBOutlet UITableView *Capacity_Unit_table;


- (IBAction)Updatebtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *updatebtn;


@property (weak, nonatomic) IBOutlet TextFieldValidator *Title;

@property (weak, nonatomic) IBOutlet TextFieldValidator *fromAdd;


@property (weak, nonatomic) IBOutlet TextFieldValidator *ToAdd;
@property (weak, nonatomic) IBOutlet UITextField *starttime;

@property (weak, nonatomic) IBOutlet UITextField *endtime;
@property (weak, nonatomic) IBOutlet TextFieldValidator *approxDist;
@property (weak, nonatomic) IBOutlet TextFieldValidator *price;
@property (weak, nonatomic) IBOutlet TextFieldValidator *partLoad;
@property (weak, nonatomic) IBOutlet UITextField *status;
- (IBAction)dropdown_status:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *cargotyp;
- (IBAction)dropdown_cargo:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *Description;
@property (weak, nonatomic) IBOutlet UITextView *loadAddress;

@property (weak, nonatomic) IBOutlet UITextView *UnloadingAdd;
@property (weak, nonatomic) IBOutlet TextFieldValidator *brand;
@property (weak, nonatomic) IBOutlet TextFieldValidator *model;
@property (weak, nonatomic) IBOutlet TextFieldValidator *capacity;
@property (weak, nonatomic) IBOutlet UITextField *vehicleType;

- (IBAction)dropdown_vehicleTyp:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *isGPS;
- (IBAction)dropdown_isGPS:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *permittyp;
- (IBAction)dropdown_permit:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *capacity_unit;
- (IBAction)dropdown_capacity:(id)sender;
@property (weak, nonatomic) IBOutlet TextFieldValidator *vehicleNO;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property(nonatomic)NSDictionary *Tripedit;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *donebtn;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelbtn;

@end