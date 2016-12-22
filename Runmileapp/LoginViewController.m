//
//  LoginViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/23/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "LoginViewController.h"

#import "SignUp1_ViewController.h"
#import "Hire_ViewController.h"
#import "httpws.h"
#import "Constant.h"
#import "tabbarcontroller.h"
#import "AppMethod.h"
#import "SWRevealViewController.h"
#import "sidebarViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"


@interface LoginViewController ()<UITextFieldDelegate>

@end


static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden=YES;
    _Forgptpass_View.hidden = YES;
    _bgimg.layer.cornerRadius=58.0;
    _loginbtn.layer.cornerRadius = 17.0;
    
    
    _Submit.layer.cornerRadius = 19.0;
    _Canclebtn.layer.cornerRadius = 19.0;
   // [self setupAlerts];
    
    
    [_uname setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
   [_pass setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    // Do any additional setup after loading the view, typically from a nib.
    
    _pass.delegate=self;
    _pass.presentInView=self.view;
    
    _uname.delegate=self;
    _uname.presentInView=self.view;
    
    _Email.delegate=self;
    _Email.presentInView=self.view;

    
     [self setupAlerts];
    
    
    UITapGestureRecognizer *m2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handle)];
    _imgview.userInteractionEnabled=YES;
    
    [m2 setNumberOfTapsRequired:1];
    
    [self.imgview addGestureRecognizer:m2];
    
}

-(void)handle
{
    [self.imgview endEditing:YES];
}


-(void)setupAlerts
{
    [_pass addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password can not be blank."];
    
    [_uname addRegx:REGEX_USERNAME withMsg:@"Enter Valid User Name Or Email."];
    
    [_Email addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginbtn:(id)sender
{
    username = _uname.text;
    password = _pass.text;
    
    if ([_uname validate] && [_pass validate])
    {
        setdic = [[NSMutableDictionary alloc]init];
        [setdic setObject:username forKey:@"email"];
        [setdic setObject:password forKey:@"password"];
        
        NSMutableDictionary *device = [[NSMutableDictionary alloc]init];
        [device setObject:@"abcd" forKey:@"udid"];
        [device setObject:@"abc" forKey:@"token"];
        [device setObject:@"phone" forKey:@"type"];
        [device setObject:@"ios" forKey:@"os"];
        [setdic setObject:device forKey:@"device"];
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [ProgressHUD show:@"Please wait..."];

        
        [manager POST:[baseurl stringByAppendingString:loginurl] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
        {
            BOOL boolean = [[dic12 valueForKey:@"status"]boolValue];
            
            if (boolean)
            {
                SWRevealViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];

            NSMutableDictionary *data = [dic12 valueForKey:@"data"];
            
            [AppMethod  setStringDefault:@"default_id" :[data valueForKey:@"id"]];
            
            [AppMethod  setStringDefault:@"default_access_token" :[data valueForKey:@"access_token"]];
            [AppMethod  setStringDefault:@"default_email" :[data valueForKey:@"email"]];
            
            [AppMethod  setStringDefault:@"default_fname" :[data valueForKey:@"firstname"]];
            [AppMethod  setStringDefault:@"default_lname" :[data valueForKey:@"lastname"]];
            [AppMethod  setStringDefault:@"default_profileImage" :[data valueForKey:@"avatar"]];
            
            
            [AppMethod  setStringDefault:@"default_Companyname" :[[data valueForKey:@"profile"] valueForKey:@"company_name"]];
            
            [AppMethod  setStringDefault:@"default_Mobile" :[[data valueForKey:@"profile"]valueForKey:@"mobile"]];
            [AppMethod  setStringDefault:@"default_Landline" :[[data valueForKey:@"profile"]valueForKey:@"landline"]];
            
            [AppMethod  setStringDefault:@"default_Permit" :[[data valueForKey:@"profile"]valueForKey:@"permit"]];
            
            [AppMethod  setStringDefault:@"default_noofVehicle" :[[data valueForKey:@"profile"]valueForKey:@"no_of_vehicle"]];
            [AppMethod  setStringDefault:@"default_website" :[[data valueForKey:@"profile"]valueForKey:@"website"]];
            [AppMethod  setStringDefault:@"default_locale" :[[data valueForKey:@"profile"]valueForKey:@"locale"]];
            
            [AppMethod  setStringDefault:@"default_Gender" :[[data valueForKey:@"profile"]valueForKey:@"gender"] ];
            
            
            
            [AppMethod  setStringDefault:@"default_RunmileApprove" :[[data valueForKey:@"profile"]valueForKey:@"approve"]];
            [AppMethod  setStringDefault:@"default_ContactPref" :[[data valueForKey:@"profile"]valueForKey:@"contact_preference"]];
            [AppMethod  setStringDefault:@"default_Address" :[[data valueForKey:@"profile"]valueForKey:@"address"]];
            
            [AppMethod  setStringDefault:@"default_AddressLine1" :[[data valueForKey:@"profile"]valueForKey:@"addressline1"]];
            
            [AppMethod  setStringDefault:@"default_AddressLine2" :[[data valueForKey:@"profile"]valueForKey:@"addressline2"]];
            [AppMethod  setStringDefault:@"default_pincode" :[[data valueForKey:@"profile"]valueForKey:@"pincode"]];
            [AppMethod  setStringDefault:@"default_City" :[[data valueForKey:@"profile"]valueForKey:@"city"]];
            
            [AppMethod  setStringDefault:@"default_State" :[[data valueForKey:@"profile"]valueForKey:@"state"]];
            
            
            [AppMethod  setStringDefault:@"default_Country" :[[data valueForKey:@"profile"]valueForKey:@"country"]];
            
            [AppMethod setStringDefault:@"default_TotalRate" :[[[data valueForKey:@"profile"] valueForKey:@"review"]objectForKey:@"totalRate"]];
            [AppMethod  setStringDefault:@"default_TotalReview" :[[[data valueForKey:@"profile"] valueForKey:@"review"]valueForKey:@"totalReview"]];
            [AppMethod  setStringDefault:@"default_OverAll" :[[[data valueForKey:@"profile"] valueForKey:@"review"] valueForKey:@"overAll"]];
                [AppMethod  setStringDefault:@"default_role" :[data valueForKey:@"role"]];
                NSString *roleStr = [AppMethod Parse_jsonToString:[data valueForKey:@"role"] ];
            [AppMethod  setStringDefault:@"default_role_json" :roleStr];
            [self.navigationController pushViewController:tab animated:YES];
            }
            else
            {
                UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[dic12 valueForKey:@"message"] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
                [al show];
            }
            [ProgressHUD dismiss];

        } failure:^(NSURLSessionTask *operation, NSError *error) {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
            [al show];
            [ProgressHUD dismiss];
        }];
    }
    
}

- (IBAction)signup:(id)sender
{
    SignUp1_ViewController *cnumber=[self.storyboard instantiateViewControllerWithIdentifier:@"SignUp1_ViewController"];
    
    [self.navigationController pushViewController:cnumber animated:YES];
}


- (IBAction)Submit:(id)sender
{
    Email = _Email.text;
    if ([_Email validate])
    {
        
   
         setdic = [[NSMutableDictionary alloc]init];
      //  setpass = [[NSMutableDictionary alloc]init];
        [setdic setObject:Email forKey:@"email"];
        
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
                [ProgressHUD show:@"Please wait..."];
        
                [manager POST:[baseurl stringByAppendingString:forgotpassurl] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dicpass1)
                 {
                     BOOL boolean = [[dicpass1 valueForKey:@"status"]boolValue];
                     if (boolean)
                     {
                         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[dicpass1 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                         [al show];
                         _Forgptpass_View.hidden = YES;
                     }
                     else
                     {
                         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[dicpass1 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                         [al show];
                         _Forgptpass_View.hidden = YES;
                     }
                     [ProgressHUD dismiss];

                 }failure:^(NSURLSessionTask *operation, NSError *error) {
                                 UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                                 [al show];
                     [ProgressHUD dismiss];
                             }];

//        NSMutableDictionary *dicpass1 = [httpws httpPostWithauth:[baseurl stringByAppendingString:forgotpassurl] :setpass :[AppMethod getStringDefault:@"default_access_token"]];
        
       // NSDictionary *dicpass = [[NSDictionary alloc]initWithDictionary:[dicpass1 objectForKey:@"data"]copyItems:YES];
           }

        
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        [manager POST:[baseurl stringByAppendingString:forgotpassurl] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
//        {
//            BOOL boolean = [[dic12 valueForKey:@"status"]boolValue];
//            if (boolean)
//            {
//                UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:[dic12 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//                [al show];
//                _Forgptpass_View.hidden = YES;
//            }
//            else
//            {
//                UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[dic12 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//                [al show];
//                _Forgptpass_View.hidden = YES;
//            }
//
//        }failure:^(NSURLSessionTask *operation, NSError *error) {
//            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//            [al show];
//        }];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController presentationController];
 
    }
}

- (IBAction)Canclebtn:(id)sender
{
    _Forgptpass_View.hidden = YES;
}

- (IBAction)ForgotPass:(id)sender
{
    _Forgptpass_View.hidden = NO;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"%@",text);
    
    if([text length] == 0)
    {
        if([textView.text length] != 0)
        {
            return YES;
        }
    }
    else if([[textView text] length] > 139)
    {
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

@end
