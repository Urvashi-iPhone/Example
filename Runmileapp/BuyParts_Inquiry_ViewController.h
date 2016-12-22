//
//  BuyParts_Inquiry_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/7/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

#define REGEX_TEXTFIELD_LIMIT @"^[A-Za-z0-9]{1}+[A-Za-z0-9 .]{1,}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"[A-Za-z0-9]{6,20}"
#define REGEX_TEXTVIEW @"[\\S ]{3,}"


@interface BuyParts_Inquiry_ViewController : UIViewController
{
    NSMutableDictionary *setdic;
    NSMutableString *v_id,*name,*email,*phone,*title,*description;
     CGFloat animatedDistance;
}


@property (weak, nonatomic) IBOutlet TextFieldValidator *InquiryName;
@property (weak, nonatomic) IBOutlet TextFieldValidator *InquiryEmail;
@property (weak, nonatomic) IBOutlet TextFieldValidator *InquiryPhone;
@property (weak, nonatomic) IBOutlet TextFieldValidator *InquiryTitle;
@property (weak, nonatomic) IBOutlet UITextView *InquiryDescription;
@property (weak, nonatomic) IBOutlet TextFieldValidator *inqDescriptionTxt;

@property (weak, nonatomic) IBOutlet UIButton *inquirybtn;
@property (nonatomic)NSString *partid;
- (IBAction)inquirybtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *closebtn;
- (IBAction)closebtn:(id)sender;

@end
