//
//  FinanceViewController.h
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


@interface FinanceViewController : UIViewController
{
	NSMutableDictionary *setdic;
    NSMutableString *name,*c_name,*email,*mobile,*landline,*fin_type,*address1,*address2,*req_amount,*city,*comme;
    NSMutableArray *financearr;
    CGFloat animatedDistance;
    NSMutableArray *citytyp,*citytypdata;
    NSDictionary *adondata;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;

@property (weak, nonatomic) IBOutlet UIButton *submitbtn;
- (IBAction)submitbtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewborder1;

@property (weak, nonatomic) IBOutlet TextFieldValidator *name;

@property (weak, nonatomic) IBOutlet UITextField *CompanyName;

@property (weak, nonatomic) IBOutlet TextFieldValidator *Email;
@property (weak, nonatomic) IBOutlet UITextField *Mobile;
@property (weak, nonatomic) IBOutlet UITextField *Landline;
@property (weak, nonatomic) IBOutlet TextFieldValidator *FinanceType;
@property (weak, nonatomic) IBOutlet UITextView *Add1;
@property (weak, nonatomic) IBOutlet UITextView *Add2;
@property (weak, nonatomic) IBOutlet TextFieldValidator *RequiredAmt;
@property (weak, nonatomic) IBOutlet UITextField *City;
@property (weak, nonatomic) IBOutlet UITextView *Comment;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@property (weak, nonatomic) IBOutlet TextFieldValidator *add1txt;
@property (weak, nonatomic) IBOutlet TextFieldValidator *add2txt;
@property (weak, nonatomic) IBOutlet TextFieldValidator *commenttxt;

@property (weak, nonatomic) IBOutlet UIButton *financetyp_btn;

@property (weak, nonatomic) IBOutlet UITableView *financetbl;
- (IBAction)dropdown_financTyp:(id)sender;
- (IBAction)dropdown_city:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *city_table;
@end
