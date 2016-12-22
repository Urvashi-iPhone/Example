//
//  InsuranceViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/24/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

#define REGEX_TEXTFIELD_LIMIT @"^[A-Za-z0-9]{1}+[A-Za-z0-9 .]{1,}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"[A-Za-z0-9]{6,20}"
#define REGEX_TEXTVIEW @"[\\S ]{3,}"

@interface InsuranceViewController : UIViewController
{
	NSMutableDictionary *setdic;
    NSMutableString *name,*c_name,*vehicle,*insuranc_date,*existing_insurer,*email,*mobile,*landline,*insurance_type,*prefer_Contact,*address1;
    CGFloat animatedDistance;

}

@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;
@property (weak, nonatomic) IBOutlet UIButton *submitbtn;
- (IBAction)submitbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewborder1;

@property (weak, nonatomic) IBOutlet TextFieldValidator *name;

@property (weak, nonatomic) IBOutlet UITextField *CompanyName;
@property (weak, nonatomic) IBOutlet TextFieldValidator *vehicle;

//datepicker
@property (weak, nonatomic) IBOutlet TextFieldValidator *insuranc_date_txt;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (weak, nonatomic) IBOutlet TextFieldValidator *existing_Insurance;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Email;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Mobile;
@property (weak, nonatomic) IBOutlet UITextField *Landline;
@property (weak, nonatomic) IBOutlet TextFieldValidator *InsuranceType;
@property (weak, nonatomic) IBOutlet TextFieldValidator *prefere_contact;

@property (weak, nonatomic) IBOutlet UITextView *Add1;
@property (weak, nonatomic) IBOutlet TextFieldValidator *add1txt;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;

- (IBAction)btn_datepicker:(id)sender;



@end
