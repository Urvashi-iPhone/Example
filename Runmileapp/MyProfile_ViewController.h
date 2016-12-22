//
//  MyProfile_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/26/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface MyProfile_ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewborder1;

@property (weak, nonatomic) IBOutlet UIView *viewborder2;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@property (weak, nonatomic) IBOutlet UILabel *CompanyName;
@property (weak, nonatomic) IBOutlet UILabel *Fname;
@property (weak, nonatomic) IBOutlet UILabel *Lname;

@property (weak, nonatomic) IBOutlet UILabel *Mobile;
@property (weak, nonatomic) IBOutlet UILabel *Landline;
@property (weak, nonatomic) IBOutlet UILabel *permitType;
@property (weak, nonatomic) IBOutlet UILabel *NoofVehicle;
@property (weak, nonatomic) IBOutlet UILabel *Website;
@property (weak, nonatomic) IBOutlet UITextView *Address;

@property (weak, nonatomic) IBOutlet UILabel *Locale;
@property (weak, nonatomic) IBOutlet UILabel *Gender;
@property (weak, nonatomic) IBOutlet UILabel *IsRunmileApprove;
@property (weak, nonatomic) IBOutlet UILabel *Contact;


@property (weak, nonatomic) IBOutlet UILabel *lastRatingTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *Totalrate;
@property (weak, nonatomic) IBOutlet UILabel *TotalReview;
@property (weak, nonatomic) IBOutlet UILabel *Overall;
@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;

@property (weak, nonatomic) IBOutlet HCSStarRatingView *myrateview;

@end
