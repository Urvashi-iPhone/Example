//
//  Sell_AutoParts_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/10/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

#define REGEX_TEXTFIELD_LIMIT @"^[A-Za-z0-9]{1}+[A-Za-z0-9 .]{1,}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"[A-Za-z0-9]{6,20}"
#define REGEX_NUMBER @"^[0-9]{1,}"


@interface Sell_AutoParts_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableDictionary *setdic;
    NSString *c_name,*fname,*lname,*email,*mobile,*name,*manufacture,*brand,*city,*parts_type,*vehi_model,*manufacture_year,*model_number,*price,*parts_details,*length,*width,*height,*weight,*is_new,*status,*isTermAc;
    NSMutableArray *isNewtyp,*statustyp;
     CGFloat animatedDistance;
    NSMutableArray *brandtyp,*brandtypedata;
      NSMutableArray *citytyp,*citytypdata;
      NSMutableArray *parttyp,*parttypdata;
    NSDictionary *adondata;
}
@property (weak, nonatomic) IBOutlet UIView *viewGallary;

@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;
@property (weak, nonatomic) IBOutlet UIView *border1;
@property (weak, nonatomic) IBOutlet UIView *border2;
@property (weak, nonatomic) IBOutlet UIButton *createbtn;
- (IBAction)createbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Addimage;
- (IBAction)AddImageList:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *table_brand;

@property (weak, nonatomic) IBOutlet UITextField *CompanyName;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Fname;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Lname;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Email;
@property (weak, nonatomic) IBOutlet UIButton *dropdown_brand;
- (IBAction)dropdown_brand:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *Mobile;

@property (weak, nonatomic) IBOutlet TextFieldValidator *Name;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Manufacture;

@property (weak, nonatomic) IBOutlet TextFieldValidator *Brand;
@property (weak, nonatomic) IBOutlet TextFieldValidator *City;
@property (weak, nonatomic) IBOutlet TextFieldValidator *PartsType;
@property (weak, nonatomic) IBOutlet TextFieldValidator *VehicleModel;
@property (weak, nonatomic) IBOutlet UITextField *Manufacture_year;

@property (weak, nonatomic) IBOutlet TextFieldValidator *ModelNo;

@property (weak, nonatomic) IBOutlet TextFieldValidator *Price;
@property (weak, nonatomic) IBOutlet TextFieldValidator *PartsDetail;

@property (weak, nonatomic) IBOutlet TextFieldValidator *Length;

@property (weak, nonatomic) IBOutlet TextFieldValidator *Width;

@property (weak, nonatomic) IBOutlet TextFieldValidator *height;

@property (weak, nonatomic) IBOutlet TextFieldValidator *weight;

@property (weak, nonatomic) IBOutlet UITextField *IsNew;

- (IBAction)dropdoen_isnew:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *camerabtn;
- (IBAction)galarybtn:(id)sender;

- (IBAction)camerabtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *galarybtn;

@property (weak, nonatomic) IBOutlet UITableView *isnew_tabledata;

@property (weak, nonatomic) IBOutlet UITextField *Status;


- (IBAction)dropdown_status:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *status_tabledata;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@property (weak, nonatomic) IBOutlet UITableView *table_parts;
@property (nonatomic)NSMutableArray *imagelist;
@property (nonatomic)NSInteger vehicleimg_position;

@property (weak, nonatomic) IBOutlet UIButton *uncheckbtn;
- (IBAction)uncheckbtn:(id)sender;
@property (nonatomic)BOOL termConditionCheck;

- (IBAction)dropdown_city:(id)sender;
- (IBAction)dropdown_parttype:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *dropdown_parttype;
@property (weak, nonatomic) IBOutlet UITableView *table_parttype;

@property (weak, nonatomic) IBOutlet UIButton *citybtn;
@property (weak, nonatomic) IBOutlet UITableView *city_table;
@end
