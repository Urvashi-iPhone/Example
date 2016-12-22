//
//  PostRequest_Parts_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/8/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

#define REGEX_TEXTFIELD_LIMIT @"^[A-Za-z0-9]{1}+[A-Za-z0-9 .]{1,}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"[A-Za-z0-9]{6,20}"


@interface PostRequest_Parts_ViewController : UIViewController
{
    NSMutableString *name,*c_name,*email,*mobile,*landline,*address1,*address2,*manufacture,*parts_type,*veh_model,*manufacture_year,*model_no,*price,*brand,*city,*parts_det,*lenght,*width,*height,*weight;
    NSMutableDictionary *setdic;
     CGFloat animatedDistance;
    
  
    NSDictionary *adon_dic;
    NSMutableArray *citytyp,*citytypdata;
    NSMutableArray *parttyp,*parttypdata;
    NSMutableArray *brandtyp,*brandtypedata;
}

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
@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;
@property (weak, nonatomic) IBOutlet UITextField *Manufacture;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Partstype;

@property (weak, nonatomic) IBOutlet UITextField *VehicleModel;
@property (weak, nonatomic) IBOutlet UITextField *ManufactureYear;
@property (weak, nonatomic) IBOutlet UITextField *ModelNumber;
@property (weak, nonatomic) IBOutlet UITextField *Price;
@property (weak, nonatomic) IBOutlet UITextField *Brand;
@property (weak, nonatomic) IBOutlet UITextField *City;
@property (weak, nonatomic) IBOutlet UITextField *PartsDetail;
@property (weak, nonatomic) IBOutlet UITextField *Length;
@property (weak, nonatomic) IBOutlet UITextField *Width;
@property (weak, nonatomic) IBOutlet UITextField *Height;
@property (weak, nonatomic) IBOutlet UITextField *Weight;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;


@property (weak, nonatomic) IBOutlet UITableView *table_parttype;
@property (weak, nonatomic) IBOutlet UITableView *city_table;
@property (weak, nonatomic) IBOutlet UITableView *table_brand;

- (IBAction)dropdown_city:(id)sender;
- (IBAction)dropdown_brand:(id)sender;
- (IBAction)dropdown_parttype:(id)sender;

@end
