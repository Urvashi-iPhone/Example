//
//  PostRequest_Test_Transport_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/8/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "TextFieldValidator.h"
#import "CBAutoScrollLabel.h"

#define REGEX_TEXTFIELD_LIMIT @"^[A-Za-z0-9]{1}+[A-Za-z0-9 .]{1,}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"[A-Za-z0-9]{6,20}"


@interface PostRequest_Test_Transport_ViewController : UIViewController
{
    NSMutableDictionary *setdic;
    NSMutableString *write_review,*name,*email,*rating;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;
@property (weak, nonatomic) IBOutlet UIView *border1;
@property (weak, nonatomic) IBOutlet UIView *border2;

@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *lableName;


@property (weak, nonatomic) IBOutlet UILabel *CompanyName;
@property (weak, nonatomic) IBOutlet UILabel *FirstName;
@property (weak, nonatomic) IBOutlet UILabel *LastName;
@property (weak, nonatomic) IBOutlet UILabel *Mobile;
@property (weak, nonatomic) IBOutlet UILabel *Landline;
@property (weak, nonatomic) IBOutlet UILabel *PermitType;
@property (weak, nonatomic) IBOutlet UILabel *NoofVehicle;

@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *Website;

@property (weak, nonatomic) IBOutlet UILabel *Review;
@property (weak, nonatomic) IBOutlet UITextView *Address;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@property (nonatomic)NSDictionary *transportdata;
@property (weak, nonatomic) IBOutlet UIButton *SubmitReview;

@property (weak, nonatomic) IBOutlet HCSStarRatingView *rateview;

@property (weak, nonatomic) IBOutlet HCSStarRatingView *rateview2;



- (IBAction)SubmitReview:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *WriteReview;
@property (weak, nonatomic) IBOutlet TextFieldValidator *ReviewName;
@property (weak, nonatomic) IBOutlet TextFieldValidator *ReviewEmail;
@property(nonatomic)NSString *reviewuser_id;
@end
