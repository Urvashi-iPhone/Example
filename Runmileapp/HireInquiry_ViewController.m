//
//  HireInquiry_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/6/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//
#import "HireInquiry_ViewController.h"
#import "httpws.h"
#import "Constant.h"
#import "AppMethod.h"
#import "HireSearch_ViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"

@interface HireInquiry_ViewController ()

@end
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@implementation HireInquiry_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"tripid = %@",_tripid);
    
    _inquiryBtn.layer.cornerRadius = 17;
    _closeBtn.layer.cornerRadius = 17;
    _inquiryDescription.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _inquiryDescription.layer.borderWidth = 1.0f;
    _inquiryDescription.layer.cornerRadius = 5;
//    
//    _inquiryDescription.text = @"Description";
//    _inquiryDescription.textColor = [UIColor lightGrayColor];
//    _inquiryDescription.delegate = self;
    
    _inqDescriptionTxt.tag = 1;
    [self setupAlerts];
    [self Validation_Delegate];
    
}
-(void)Validation_Delegate
{
    _inquiryName.delegate=self;
    _inquiryEmail.delegate=self;
    _inquiryTitle.delegate=self;
    _inqDescriptionTxt.delegate=self;
     _inquiryPhone.delegate=self;
    
    _inquiryName.presentInView=self.view;
    _inquiryEmail.presentInView=self.view;
    _inquiryTitle.presentInView=self.view;
      _inqDescriptionTxt.presentInView=self.view;
     _inquiryPhone.presentInView=self.view;
}
-(void)setupAlerts
{
    [_inquiryName addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Name can not be blank."];
    
    [_inquiryEmail addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    
    [_inquiryTitle addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Title can not be blank."];
    
    [_inqDescriptionTxt addRegx:REGEX_TEXTVIEW withMsg:@"Inquiry can not be blank."];
    
      [_inquiryPhone addRegx:REGEX_PHONE_NUMBER withMsg:@"Phone cannot be blank."];
}
//- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
//{
//    _inquiryDescription.text = @"";
//    _inquiryDescription.textColor = [UIColor blackColor];
//    return YES;
//}
//
//-(void) textViewDidChange:(UITextView *)textView
//{
//    if(_inquiryDescription.text.length == 0)
//    {
//        _inquiryDescription.textColor = [UIColor lightGrayColor];
//        _inquiryDescription.text = @"Description";
//        [_inquiryDescription resignFirstResponder];
//    }
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)inquiryName:(id)sender
{
    name = _inquiryName.text;
    email =_inquiryEmail.text;
    phone=_inquiryPhone.text;
    title=_inquiryTitle.text;
    description = _inquiryDescription.text;
    
    _inqDescriptionTxt.hidden = false;
    _inqDescriptionTxt.text = _inquiryDescription.text;
    
    if([_inquiryName validate] & [_inquiryEmail validate] & [_inquiryTitle validate]  & [_inqDescriptionTxt validate]  & [_inquiryPhone validate])
    {

        setdic=[[NSMutableDictionary alloc]init];
        [setdic setObject:_tripid forKey:@"trip_id"];
        [setdic setObject:name forKey:@"name"];
        [setdic setObject:email forKey:@"email"];
        [setdic setObject:phone forKey:@"phone"];
        [setdic setObject:title forKey:@"title"];
        [setdic setObject:description forKey:@"description"];
  
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
         [ProgressHUD show:@"Please wait..."];
        
        [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
        [manager POST:[baseurl stringByAppendingString:HireInquiry] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
         
        {
            
            BOOL boolean = [[dic12 valueForKey:@"status"] boolValue];
            if (boolean)
            {
                UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[dic12 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [al show];
                
            }
            [ProgressHUD dismiss];

        } failure:^(NSURLSessionTask *operation, NSError *error)
         {
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
             [al show];
            [ProgressHUD dismiss];
         }];
        
        
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
//        HireSearch_ViewController *inq = [self.storyboard instantiateViewControllerWithIdentifier:@"HireSearch_ViewController"];
//        [self.navigationController pushViewController:inq animated:YES];
        
         [self.navigationController popViewControllerAnimated:YES];
    }
}


- (IBAction)closebtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
        _inqDescriptionTxt.hidden = YES;
        [_inquiryDescription becomeFirstResponder];
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
