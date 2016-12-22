//
//  ContactUs_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/24/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "ContactUs_ViewController.h"
#import "httpws.h"
#import "AppMethod.h"
#import "Constant.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"

@interface ContactUs_ViewController ()

@end
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
@implementation ContactUs_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    _submitbtn.layer.cornerRadius = 15.0;
    _inquiry.layer.cornerRadius = 5;
    _inquiry.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _inquiry.layer.borderWidth = 1.0f;
    
    
//    _inquiry.delegate = self;
//    _inquiry.text = @"Inquiry";
//    _inquiry.textColor = [UIColor lightGrayColor];
    
    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    [self setupAlerts];
    [self Validation_Delegate];
    }
-(void)Validation_Delegate
{
    _name.delegate=self;
    _email.delegate=self;
     _inquirytxt.delegate=self;
    
    _name.presentInView=self.view;
    _email.presentInView=self.view;
     _inquirytxt.presentInView=self.view;
  
    
    
}
-(void)setupAlerts
{
    [_name addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Name can not be blank."];
    
    [_email addRegx:REGEX_EMAIL withMsg:@"Enter valid email"];
    
    [_inquirytxt addRegx:REGEX_TEXTVIEW withMsg:@"Inquiry can not be blank."];
    
}

//- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
//{
//    _inquiry.text = @"";
//    _inquiry.textColor = [UIColor blackColor];
//    return YES;
//}
//
//-(void) textViewDidChange:(UITextView *)textView
//{
//    if(_inquiry.text.length == 0)
//    {
//        _inquiry.textColor = [UIColor lightGrayColor];
//        _inquiry.text = @"Inquiry";
//        [_inquiry resignFirstResponder];
//    }
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitbtn:(id)sender
{
    name=_name.text;
    email=_email.text;
    sub=_subject.text;
    inquiry=_inquiry.text;
    
    _inquirytxt.hidden = false;
    _inquirytxt.text = _inquiry.text;
    
    if([_name validate] & [_email validate]  & [_inquirytxt validate])
    {
        

        setdic=[[NSMutableDictionary alloc]init];
        [setdic setObject:name forKey:@"name"];
        [setdic setObject:email forKey:@"email"];
        [setdic setObject:sub forKey:@"subject"];
        [setdic setObject:inquiry forKey:@"body"];
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
         [ProgressHUD show:@"Please wait..."];
        
        NSLog(@"%@",[AppMethod getStringDefault:@"default_access_token"] );
        [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
        [manager POST:[baseurl stringByAppendingString:ContactUsurl] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)

         {
             BOOL boolean=[[dic12 valueForKey:@"status"]boolValue];
             if(boolean)
             {
                 UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:[dic12 valueForKey:@"message"]delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
                 [al show];
             }
              [ProgressHUD dismiss];
         }
        failure:^(NSURLSessionTask *operation, NSError *error)
         {
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
             [al show];
              [ProgressHUD dismiss];
         }];

    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        SWRevealViewController *inq = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        [self.navigationController pushViewController:inq animated:YES];
    }
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
    
    UITextField *add1 = (UITextField *)textField;
    if (add1.tag == 1)
    {
        _inquirytxt.hidden = YES;
        [_inquiry becomeFirstResponder];
    }
  
    
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
