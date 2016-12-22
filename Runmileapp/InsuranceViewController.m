//
//  InsuranceViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/24/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "InsuranceViewController.h"
#import "httpws.h"
#import "AppMethod.h"
#import "Constant.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"


@interface InsuranceViewController ()

@end

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
@implementation InsuranceViewController

- (void)viewDidLoad 
{
    [super viewDidLoad];

    
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlview.contentSize = contentRect.size;
    
    _Add1.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _Add1.layer.borderWidth = 1.0f;
    _Add1.layer.cornerRadius = 5;

    _viewborder1.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];

    _viewborder1.layer.borderWidth= 1.0f;
    _viewborder1.layer.cornerRadius = 15.0;
    _submitbtn.layer.cornerRadius = 17.0;
    
    
    _datePicker.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1.0f];
    
    _toolbar.hidden = true;
    _datePicker.hidden = true;
    [_insuranc_date_txt setDelegate:self];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didRecognizeTapGesture:)];
    [self.insuranc_date_txt.superview addGestureRecognizer:tapGesture];
  
    
//    _Add1.delegate = self;
//    //_Add1.text = @"Address Line1";
//    _Add1.textColor = [UIColor lightGrayColor];
//    

    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self setupAlerts];
    [self Validation_Delegate];

}

- (void)didRecognizeTapGesture:(UITapGestureRecognizer*)gesture
{
    CGPoint point = [gesture locationInView:gesture.view];
    
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        _insuranc_date_txt.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datePicker.date]];
        _datePicker.hidden = false;
        _toolbar.hidden = false;
    }
}


- (IBAction)canclebtn:(id)sender
{
    _datePicker.hidden = true;
    _toolbar.hidden = true;
    _insuranc_date_txt.text = @"";
}

- (IBAction)Donebtn:(id)sender
{
    _datePicker.hidden = true;
    _toolbar.hidden = true;
    
}
- (IBAction)datePickerChanged:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    _insuranc_date_txt.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datePicker.date]];
}



//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    return NO;
//}



-(void)Validation_Delegate
{
    _name.delegate=self;
    _vehicle.delegate = self;
    _existing_Insurance.delegate = self;
    _Email.delegate=self;
    _InsuranceType.delegate=self;
      _prefere_contact.delegate=self;
    _add1txt.delegate = self;
     _Mobile.delegate=self;
    _insuranc_date_txt.delegate=self;
    
    _name.presentInView=self.view;
     _vehicle.presentInView=self.view;
     _existing_Insurance.presentInView=self.view;
    _Email.presentInView=self.view;
    _InsuranceType.presentInView=self.view;
     _prefere_contact.presentInView=self.view;
    _add1txt.presentInView=self.view;
    _Mobile.presentInView=self.view;
     _insuranc_date_txt.presentInView=self.view;
    
    
}
-(void)setupAlerts
{
    [_name addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"User name can not be blank."];
    
    [_vehicle addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Vehicle can not be blank."];
    
    [_existing_Insurance addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Existing Insurer can not be blank."];
    
    [_Email addRegx:REGEX_EMAIL withMsg:@"Enter valid email"];
    
    [_InsuranceType addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Insurance Type can not be blank."];
    
    [_prefere_contact addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Preferred Time Of Contact can not be blank."];
    
    [_add1txt addRegx:REGEX_TEXTVIEW withMsg:@"Address1 can not be blank."];
    
     [_Mobile addRegx:REGEX_PHONE_NUMBER withMsg:@"Mobile Number can not be blank."];
    
     [_insuranc_date_txt addRegx:REGEX_DATE withMsg:@"Prev. Insurance Expiring Date cannot be blank."];
}


//- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
//{
//    if (textView == _Add1)
//    {
//        _Add1.text = @"";
//        _Add1.textColor = [UIColor blackColor];
//        return YES;
//        
//    }
//    else if (textView == _Add2)
//    {
//        _Add2.text = @"";
//        _Add2.textColor = [UIColor blackColor];
//        return YES;
//    }
//    else
//    {
//        _Comment.text = @"";
//        _Comment.textColor = [UIColor blackColor];
//        return YES;
//    }
//    return nil;
//}

//-(void) textViewDidChange:(UITextView *)textView
//{
//    if (textView == _Add1)
//    {
//        if(_Add1.text.length == 0)
//        {
//            _Add1.textColor = [UIColor lightGrayColor];
//            _Add1.text = @"Address Line1";
//            [_Add1 resignFirstResponder];
//        }
//        
//    }
//    else if (textView == _Add2)
//    {
//        if(_Add2.text.length == 0)
//        {
//            _Add2.textColor = [UIColor lightGrayColor];
//            _Add2.text = @"Address Line2";
//            [_Add2 resignFirstResponder];
//        }
//        
//    }
//    else
//    {
//        if(_Comment.text.length == 0)
//        {
//            _Comment.textColor = [UIColor lightGrayColor];
//            _Comment.text = @"Comment";
//            [_Comment resignFirstResponder];
//        }
//    }
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    UITextView *add1 = (UITextView *)textField;
//   
//    
//    if (add1.tag == 1)
//    {
//        _add1txt.hidden = YES;
//        [_Add1 becomeFirstResponder];
//    }
//    else if (add1.tag == 2)
//    {
//        _add2txt.hidden = YES;
//        [_Add2 becomeFirstResponder];
//    }
//}

- (IBAction)submitbtn:(id)sender
{
	name=_name.text;
	c_name=_CompanyName.text;
    vehicle = _vehicle.text;
    insuranc_date = _insuranc_date_txt.text;
    existing_insurer = _existing_Insurance.text;
	email=_Email.text;
	mobile=_Mobile.text;
	landline=_Landline.text;
	insurance_type=_InsuranceType.text;
    prefer_Contact = _prefere_contact.text;
	address1=_Add1.text;
	
    
    _add1txt.hidden = false;
    _add1txt.text = _Add1.text;
   
    
	if([_name validate] & [_Email validate] & [_InsuranceType validate] & [_vehicle validate] & [_existing_Insurance validate] & [_add1txt validate] & [_prefere_contact validate] & [_Mobile validate] & [_insuranc_date_txt validate])
	{
   
		setdic=[[NSMutableDictionary alloc]init];
		[setdic setObject:name forKey:@"name"];
		[setdic setObject:c_name forKey:@"company_name"];
        [setdic setObject:vehicle forKey:@"vehicle"];
        [setdic setObject:insuranc_date forKey:@"insurance_expire_date"];
        [setdic setObject:existing_insurer forKey:@"existing_insurer"];
		[setdic setObject:email forKey:@"email"];
		[setdic setObject:mobile forKey:@"mobile"];
		[setdic setObject:landline forKey:@"landline"];
		[setdic setObject:insurance_type forKey:@"insurance_type"];
        [setdic setObject:prefer_Contact forKey:@"prefered_time_of_contact"];
        [setdic setObject:address1 forKey:@"addressline1"];
		
		
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [ProgressHUD show:@"Please wait..."];

       [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
        
        [manager POST:[baseurl stringByAppendingString:Insuranceurl] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
        
    {
        
		BOOL boolean=[[dic12 valueForKey:@"status"]boolValue];
		if(boolean)
		{
			UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[dic12 valueForKey:@"message"]delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
			[alt show];

		}
         [ProgressHUD dismiss];
         }
         failure:^(NSURLSessionTask *operation, NSError *error)
             {
                 UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
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
    
    
    //textview validation
    UITextField *add1 = (UITextField *)textField;
    if (add1.tag == 1)
    {
        _add1txt.hidden = YES;
        [_Add1 becomeFirstResponder];
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


- (IBAction)btn_datepicker:(id)sender
{
    _toolbar.hidden = NO;
    _datePicker.hidden = NO;
}
@end
