//
//  HireInquiry_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/6/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

#define REGEX_TEXTFIELD_LIMIT @"^[A-Za-z0-9]{1}+[A-Za-z0-9 .]{1,}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"[A-Za-z0-9]{6,20}"
#define REGEX_TEXTVIEW @"[\\S ]{3,}"

@interface HireInquiry_ViewController : UIViewController<UITextViewDelegate>
{
    NSMutableDictionary *setdic;
    NSMutableString *v_id,*name,*email,*phone,*title,*description;
     CGFloat animatedDistance;
}
@property (weak, nonatomic) IBOutlet TextFieldValidator *inquiryName;
@property (weak, nonatomic) IBOutlet TextFieldValidator *inquiryEmail;
@property (weak, nonatomic) IBOutlet TextFieldValidator *inquiryPhone;
@property (weak, nonatomic) IBOutlet TextFieldValidator *inquiryTitle;
@property (weak, nonatomic) IBOutlet UITextView *inquiryDescription;
@property (weak, nonatomic) IBOutlet TextFieldValidator *inqDescriptionTxt;

@property (weak, nonatomic) IBOutlet UIButton *inquiryBtn;
- (IBAction)inquiryName:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

- (IBAction)closebtn:(id)sender;

@property(nonatomic)NSString *tripid;

@end
