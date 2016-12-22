//
//  SignUp1_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/26/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

#define REGEX_TEXTFIELD_LIMIT @"^[A-Za-z0-9]{1}+[A-Za-z0-9 .]{1,}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"[A-Za-z0-9]{6,20}"

@interface SignUp1_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *user,*usertyp;
    NSMutableArray *clickflag;
    NSDictionary *adon_dic;
    NSMutableString *Email,*Pass,*Username,*Mobile;
    NSMutableDictionary *setdic;
    NSDictionary *jsondata;
    
     CGFloat animatedDistance;


}
- (IBAction)backbtn:(id)sender;

@property (weak, nonatomic) IBOutlet TextFieldValidator *uname;
@property (weak, nonatomic) IBOutlet TextFieldValidator *email;
@property (weak, nonatomic) IBOutlet UITextField *mobileno;
@property (weak, nonatomic) IBOutlet TextFieldValidator *pass;
@property (weak, nonatomic) IBOutlet TextFieldValidator *cpass;


@property (weak, nonatomic) IBOutlet UIButton *proceedbtn;

@property (weak, nonatomic) IBOutlet UITableView *table_data;

@property (weak, nonatomic) IBOutlet UINavigationItem *signuplable;

- (IBAction)proceedbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *imgview;

@end
