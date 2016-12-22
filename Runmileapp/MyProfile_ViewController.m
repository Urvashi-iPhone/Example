//
//  MyProfile_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/26/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "MyProfile_ViewController.h"
#import "SWRevealViewController.h"
#import "AppMethod.h"
#import "Constant.h"
#import "httpws.h"
#import "LoginViewController.h"
#import "HCSStarRatingView.h"

@interface MyProfile_ViewController ()

@end

@implementation MyProfile_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // [[UINavigationBar appearance]setFrame:CGRectMake(0, 0,self.view.frame.size.width, 60)];
    
        
     _viewborder1.layer.cornerRadius = 15.0;
     _viewborder1.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _viewborder1.layer.borderWidth = 1.0f;
    
    _viewborder2.layer.cornerRadius = 15.0;
    _viewborder2.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];

    _viewborder2.layer.borderWidth = 1.0f;
    
    //scrollview
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlview.contentSize = contentRect.size;
    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
   
    _CompanyName.text = [AppMethod getStringDefault:@"default_Companyname"];

    _Fname.text = [AppMethod getStringDefault:@"default_fname"];
    _Lname.text = [AppMethod getStringDefault:@"default_lname"];
    _Mobile.text = [AppMethod getStringDefault:@"default_Mobile"];
    _Landline.text = [AppMethod getStringDefault:@"default_Landline"];
    _permitType.text = [AppMethod getStringDefault:@"default_Permit"];
    _NoofVehicle.text = [AppMethod getStringDefault:@"default_noofVehicle"];
    _Website.text = [AppMethod getStringDefault:@"default_website"];
    _Locale.text = [AppMethod getStringDefault:@"default_locale"];
  
    if ([[AppMethod getStringDefault:@"default_Gender"] isEqualToString:@"1"])
    {
        _Gender.text = @"Male";
    }
    else
    {
        _Gender.text = @"Female";
    }
    
    
   
    _IsRunmileApprove.text = [AppMethod getStringDefault:@"default_RunmileApprove"];
    _Contact.text = [AppMethod getStringDefault:@"default_ContactPref"];
  
      NSString *htmlString = [AppMethod getStringDefault:@"default_Address"];
    _Address.text=[AppMethod convertHTML:htmlString];
    
    _Totalrate.text = [AppMethod getStringDefault:@"default_TotalRate"];
    _TotalReview.text = [AppMethod getStringDefault:@"default_TotalReview"];
    _Overall.text = [AppMethod getStringDefault:@"default_OverAll"];
    
    float abc = [[AppMethod getStringDefault:@"default_OverAll"] floatValue];
 
    [_myrateview setValue:abc];
    
   }
-(void)RatingBarMethod

{
    _myrateview.maximumValue = 5;
    _myrateview.minimumValue = 0;
    _myrateview.value = 0.0f;
    _myrateview.allowsHalfStars = YES;
    _myrateview.emptyStarImage = [[UIImage imageNamed:@"heart-empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _myrateview.filledStarImage = [[UIImage imageNamed:@"heart-full"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
 

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
