//
//  BuyParts_Inquiry_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/7/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "BuyParts_Inquiry_ViewController.h"
#import "Constant.h"
#import "httpws.h"
#import "AppMethod.h"
#import "BuyPartsSearch_ViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"

@interface BuyParts_Inquiry_ViewController ()

@end
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
@implementation BuyParts_Inquiry_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     //[[UINavigationBar appearance]setFrame:CGRectMake(0, 0,self.view.frame.size.width, 60)];
    _inquirybtn.layer.cornerRadius = 17;
     _closebtn.layer.cornerRadius = 17;
    
    _InquiryDescription.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _InquiryDescription.layer.borderWidth = 1.0f;
    _InquiryDescription.layer.cornerRadius = 5;
    
//    _InquiryDescription.text = @"Description";
//    _InquiryDescription.textColor = [UIColor lightGrayColor];
//    _InquiryDescription.delegate = self;
    
    _inqDescriptionTxt.tag = 1;
    [self setupAlerts];
    [self Validation_Delegate];

    // Do any additional setup after loading the view.
}
-(void)Validation_Delegate
{
    _InquiryName.delegate=self;
    _InquiryEmail.delegate=self;
    _InquiryTitle.delegate=self;
    _inqDescriptionTxt.delegate=self;
    _InquiryPhone.delegate=self;
    
    _InquiryName.presentInView=self.view;
    _InquiryEmail.presentInView=self.view;
    _InquiryTitle.presentInView=self.view;
    _inqDescriptionTxt.presentInView=self.view;
    _InquiryPhone.presentInView=self.view;
}
-(void)setupAlerts
{
    [_InquiryName addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Name can not be blank."];
    
    [_InquiryEmail addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    
    [_InquiryTitle addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Title can not be blank."];
    
     [_inqDescriptionTxt addRegx:REGEX_TEXTVIEW withMsg:@"Inquiry can not be blank."];
    
    [_InquiryPhone addRegx:REGEX_PHONE_NUMBER withMsg:@"Phone cannot be blank."];

}
//- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
//{
//    _InquiryDescription.text = @"";
//    _InquiryDescription.textColor = [UIColor blackColor];
//    return YES;
//}
//
//-(void) textViewDidChange:(UITextView *)textView
//{
//    if(_InquiryDescription.text.length == 0)
//    {
//        _InquiryDescription.textColor = [UIColor lightGrayColor];
//        _InquiryDescription.text = @"Description";
//        [_InquiryDescription resignFirstResponder];
//    }
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)inquirybtn:(id)sender
{
    name =_InquiryName.text;
    email =_InquiryEmail.text;
    phone=_InquiryPhone.text;
    title=_InquiryTitle.text;
    description =_InquiryDescription.text;
    
    
    _inqDescriptionTxt.hidden = false;
    _inqDescriptionTxt.text = _InquiryDescription.text;
    
    if([_InquiryName validate] & [_InquiryEmail validate] & [_InquiryTitle validate]  & [_inqDescriptionTxt validate] & [_InquiryPhone validate])
    {
        

        setdic=[[NSMutableDictionary alloc]init];
        [setdic setObject:_partid forKey:@"parts_id"];
        [setdic setObject:name forKey:@"name"];
        [setdic setObject:email forKey:@"email"];
        [setdic setObject:phone forKey:@"phone"];
        [setdic setObject:title forKey:@"title"];
        [setdic setObject:description forKey:@"description"];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [ProgressHUD show:@"Please wait..."];
        
        [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
        [manager POST:[baseurl stringByAppendingString:BuyPartsInquiry] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
         
         {
             BOOL boolean = [[dic12 valueForKey:@"status"] boolValue];
             if (boolean)
             {
                 UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[dic12 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                 [al show];
                 
             }
              [ProgressHUD dismiss];
         }failure:^(NSURLSessionTask *operation, NSError *error)
         {
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
             [al show];
              [ProgressHUD dismiss];
         }];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
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
        [_InquiryDescription becomeFirstResponder];
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
