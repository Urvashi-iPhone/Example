//
//  ContactUs_ViewController.h
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




@interface ContactUs_ViewController : UIViewController

{
	NSMutableDictionary *setdic;
    NSMutableString *name,*email,*sub,*inquiry;
    
    CGFloat animatedDistance;

}
@property (weak, nonatomic) IBOutlet UIButton *submitbtn;

@property (weak, nonatomic) IBOutlet TextFieldValidator *name;
@property (weak, nonatomic) IBOutlet TextFieldValidator *email;
@property (weak, nonatomic) IBOutlet UITextField *subject;

@property (weak, nonatomic) IBOutlet UITextView *inquiry;

- (IBAction)submitbtn:(id)sender;

@property(nonatomic)NSString *contactid;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;

@property (weak, nonatomic) IBOutlet TextFieldValidator *inquirytxt;

@end
