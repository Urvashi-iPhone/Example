//
//  PostRequest_Hire_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/5/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

#define REGEX_TEXTFIELD_LIMIT @"^[A-Za-z0-9]{1}+[A-Za-z0-9 .]{1,}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"[A-Za-z0-9]{6,20}"


@interface PostRequest_Hire_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableString *name,*c_name,*email,*mobile,*landline,*address1,*address2,*from_add,*to_add,*start_time,*end_time,*Approx_distance,*price,*part_load_available,*cargo_type_id;
    NSMutableDictionary *setdic;
    NSMutableArray *cargo,*cargotype;
    NSMutableDictionary *adon_dic;
    
    CGFloat animatedDistance;
}
- (IBAction)submitbtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;

@property (weak, nonatomic) IBOutlet UIButton *submitbtn;
@property (weak, nonatomic) IBOutlet TextFieldValidator *name;
@property (weak, nonatomic) IBOutlet UITextField *CompanyName;

@property (weak, nonatomic) IBOutlet TextFieldValidator *Email;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Mobile;
@property (weak, nonatomic) IBOutlet UITextField *Landline;
@property (weak, nonatomic) IBOutlet TextFieldValidator *AddressLine1;
@property (weak, nonatomic) IBOutlet TextFieldValidator *AddressLine2;
@property (weak, nonatomic) IBOutlet TextFieldValidator *FromAddress;
@property (weak, nonatomic) IBOutlet TextFieldValidator *ToAddress;
@property (weak, nonatomic) IBOutlet UITextField *StartTime;
@property (weak, nonatomic) IBOutlet UITextField *EndTime;
@property (weak, nonatomic) IBOutlet UITextField *ApproxDistance;
@property (weak, nonatomic) IBOutlet UITextField *Price;
@property (weak, nonatomic) IBOutlet UITextField *PartLoadAvailable;
@property (weak, nonatomic) IBOutlet UIView *border1;
@property (weak, nonatomic) IBOutlet UIView *border2;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@property (weak, nonatomic) IBOutlet UITextField *cargotyptxt;
- (IBAction)dropdown_cargo:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *cargo_tabledata;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelbtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *donebtn;


@end
