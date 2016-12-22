//
//  PostRequest_Test_Transport_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/8/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "PostRequest_Test_Transport_ViewController.h"
#import "Constant.h"
#import "AppMethod.h"
#import "httpws.h"
#import "SWRevealViewController.h"
#import "LoginViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"

@interface PostRequest_Test_Transport_ViewController ()<UITextFieldDelegate>

@end

@implementation PostRequest_Test_Transport_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  //   [[UINavigationBar appearance]setFrame:CGRectMake(0, 0,self.view.frame.size.width, 60)];
     _border1.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _border1.layer.borderWidth = 1.0f;
    _border1.layer.cornerRadius = 10;
      _border2.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _border2.layer.borderWidth = 1.0f;
    _border2.layer.cornerRadius = 10;
    
    _SubmitReview.layer.cornerRadius = 17.0;
    
    self.lableName.textColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    self.lableName.labelSpacing = 30; // distance between start and end labels
    self.lableName.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.lableName.scrollSpeed = 30; // pixels per second
    self.lableName.textAlignment = NSTextAlignmentCenter; // centers text when no auto-scrolling is applied
    self.lableName.fadeLength = 12.f;
    self.lableName.scrollDirection = CBAutoScrollDirectionLeft;
    [self.lableName observeApplicationNotifications];

    
    self.Website.textColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    self.Website.labelSpacing = 30; // distance between start and end labels
    self.Website.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.Website.scrollSpeed = 30; // pixels per second
    self.Website.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.Website.fadeLength = 12.f;
    self.Website.scrollDirection = CBAutoScrollDirectionLeft;
    [self.Website observeApplicationNotifications];
    
    
    //scrollview
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlview.contentSize = contentRect.size;
    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
  //  [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
  

    NSLog(@"%@",_transportdata);
    
    
    NSDictionary *transportdata = _transportdata;
    
    _lableName.text= [[transportdata valueForKey:@"profile"]valueForKey:@"company_name"];
    
    _CompanyName.text=[[transportdata valueForKey:@"profile"]valueForKey:@"company_name"];
    
    _FirstName.text=[[transportdata valueForKey:@"profile"]valueForKey:@"firstname"];
    
    _LastName.text=[[transportdata valueForKey:@"profile"]valueForKey:@"lastname"];
    
     _Website.text=[[transportdata valueForKey:@"profile"]valueForKey:@"website"];
    
    _PermitType.text=[[transportdata valueForKey:@"profile"]valueForKey:@"permit"];
    
    _Mobile.text=[NSString stringWithFormat:@"%@",[[transportdata valueForKey:@"profile"]valueForKey:@"mobile"]];
    
   _Landline.text=[NSString stringWithFormat:@"%@",[[transportdata valueForKey:@"profile"]valueForKey:@"landline"]];
     
//    if ([[[transportdata valueForKey:@"profile"] valueForKey:@"permit"] isEqualToString:@"1"])
//    {
//        _PermitType.text = @"State Permit";
//    }
//    else
//    {
//        _PermitType.text = @"All India Permit";
//    }
    _NoofVehicle.text=[NSString stringWithFormat:@"%@",[[transportdata valueForKey:@"profile"]valueForKey:@"no_of_vehicle"]];
    
    NSString *review = [NSString stringWithFormat:@"%@/%@",[[[transportdata valueForKey:@"profile"]valueForKey:@"review"]valueForKey:@"totalRate"],[[[transportdata valueForKey:@"profile"]valueForKey:@"review"]valueForKey:@"totalReview"]];
                  _Review.text=review;
    
    
    float abc = [[[[transportdata valueForKey:@"profile"] valueForKey:@"review"]valueForKey:@"overAll"] floatValue];
    
    
    [_rateview setValue:abc];

   
    NSString *htmlString = [[transportdata valueForKey:@"profile"]valueForKey:@"address"];
    
    _Address.text=[AppMethod convertHTML:htmlString];
    
    _WriteReview.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _WriteReview.layer.borderWidth = 1.0f;
    _WriteReview.layer.cornerRadius = 5;
    
    _WriteReview.text = @"Write a Review";
    _WriteReview.textColor = [UIColor lightGrayColor];
    _WriteReview.delegate = self;
    [self RatingBarMethod];
    [self setupAlerts];
    [self Validation_Delegate];
    
}


-(void)Validation_Delegate
{
    _ReviewName.delegate=self;
    _ReviewName.presentInView=self.view;
    
    _ReviewEmail.delegate=self;
    _ReviewEmail.presentInView=self.view;
    
    
}


-(void)setupAlerts
{
    
    [_ReviewName addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Name can not be blank."];
    
    [_ReviewEmail addRegx:REGEX_EMAIL withMsg:@"Enter valid email"];
 
}


-(void)RatingBarMethod

{    
    _rateview2.maximumValue = 5;
    _rateview2.minimumValue = 0;
    _rateview2.value = 0.0f;
    _rateview2.allowsHalfStars = YES;
    _rateview2.emptyStarImage = [[UIImage imageNamed:@"heart-empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _rateview2.filledStarImage = [[UIImage imageNamed:@"heart-full"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
}


- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    _WriteReview.text = @"";
    _WriteReview.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(_WriteReview.text.length == 0)
    {
        _WriteReview.textColor = [UIColor lightGrayColor];
        _WriteReview.text = @"Write a Review";
        [_WriteReview resignFirstResponder];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

- (IBAction)SubmitReview:(id)sender
{

    
    write_review=_WriteReview.text;
    name = _ReviewName.text;
    email =_ReviewEmail.text;
    
    
    if ([_ReviewName validate] && [_ReviewEmail validate])
    {
 
        setdic=[[NSMutableDictionary alloc]init];
        [setdic setObject:[_transportdata valueForKey:@"id"] forKey:@"user_id"];
        [setdic setObject:write_review forKey:@"description"];
        [setdic setObject:name forKey:@"name"];
        [setdic setObject:email forKey:@"email"];
        rating = [[NSNumber numberWithFloat:_rateview2.value] stringValue];
        [setdic setObject:rating forKey:@"rate"];
        

        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [ProgressHUD show:@"Please wait..."];
        
        [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
        
        NSString *tripurl= [baseurl stringByAppendingString:TransportReviewurl];
        
     
        
        [manager POST:tripurl parameters:setdic progress:nil success:^(NSURLSessionTask *task, id review)
         
         {
             BOOL boolean = [[review valueForKey:@"status"] boolValue];
             if (boolean)
             {
                 UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[review valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                 [al show];
                 
             }
             else
             {
                 UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[review valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                 [al show];
             }
             [ProgressHUD dismiss];
             
         }failure:^(NSURLSessionTask *operation, NSError *error)
         {
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
             [al show];
             [ProgressHUD dismiss];
         }];
        _WriteReview.text=@"";
       _ReviewName.text=@"";
        _ReviewEmail.text=@"";
     
    }
}

- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
