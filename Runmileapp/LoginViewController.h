//
//  LoginViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/23/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

#define REGEX_TEXTFIELD_LIMIT @"^[A-Za-z0-9]{1}+[A-Za-z0-9 .]{1,}"

#define REGEX_USERNAME @"[\\S]{3,}"

#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"[A-Za-z0-9]{6,20}"


@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    NSMutableString *username,*password ,*Email;
    NSMutableDictionary *setdic,*setpass;
    NSDictionary *jsondata;
    
     CGFloat animatedDistance;
}
@property (weak, nonatomic) IBOutlet UIView *bgimg;
@property (weak, nonatomic) IBOutlet TextFieldValidator *pass;

@property (weak, nonatomic) IBOutlet TextFieldValidator *uname;
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;




@property (strong, nonatomic) IBOutlet UIView *imgview;

- (IBAction)loginbtn:(id)sender;

- (IBAction)signup:(id)sender;
@property (weak, nonatomic) IBOutlet TextFieldValidator *Email;
@property (weak, nonatomic) IBOutlet UIButton *Submit;
- (IBAction)Submit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Canclebtn;
- (IBAction)Canclebtn:(id)sender;
- (IBAction)ForgotPass:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *Forgptpass_View;

@property (nonatomic)NSMutableArray *str;


@end

/*
 
 <color name="app_color">#CB4150</color>
 <color name="text_color">#A2A1B8</color>
 <color name="btn_bg_color">#FCB042</color>
 <color name="drawer_bg_color">#0054A4</color>
 <color name="drawer_divider_color">#06498B</color>
 <color name="rv_divider_color">#06498B</color>
 <color name="login_divider_color">#80FFFFFF</color>
 
 */