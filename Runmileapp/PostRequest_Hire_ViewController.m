//
//  PostRequest_Hire_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/5/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "PostRequest_Hire_ViewController.h"
#import "httpws.h";
#import "Constant.h";
#import "AppMethod.h";
#import "SWRevealViewController.h"
#import "HireSearch_ViewController.h"
#import "CargoType_TableViewCell.h"
#import "Buy_Parts_ViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"

@interface PostRequest_Hire_ViewController ()

@end
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@implementation PostRequest_Hire_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    _submitbtn.layer.cornerRadius = 17;
    //scrollview
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlview.contentSize = contentRect.size;
    
    adon_dic = [[NSDictionary alloc]init];
    cargo_type_id = @"";
    cargo = [[NSMutableArray alloc]init];
    
    [self Get_adondata];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    _datepicker.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1.0f];
    _toolbar.hidden = true;
    _datepicker.hidden = true;
    

    [_StartTime setDelegate:self];
    [_EndTime setDelegate:self];
    _StartTime.tag = 1;
    _EndTime.tag = 2;
    
    _border1.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];
    _border1.layer.cornerRadius = 10.0;
    _border1.layer.borderWidth = 1.0f;

    _border2.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _border2.layer.cornerRadius = 10.0;
    _border2.layer.borderWidth = 1.0f;
    
    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self setupAlerts];
    [self Validation_Delegate];
    
   
    
}
- (IBAction)Start_click:(id)sender
{
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
                _donebtn.tag = 1;
                _cancelbtn.tag = 1;
    [_datepicker setDate:[NSDate date]];
    _StartTime.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datepicker.date]];
                _datepicker.hidden = false;
                _toolbar.hidden = false;
            _StartTime.enabled = NO;
  
}

- (IBAction)End_click:(id)sender
{
    _EndTime.enabled = NO;
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
                _donebtn.tag = 2;
                _cancelbtn.tag = 2;
    [_datepicker setDate:[NSDate date]];
    _EndTime.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datepicker.date]];
                _datepicker.hidden = false;
                _toolbar.hidden = false;
    
}


- (IBAction)Donebtn:(id)sender
{
    UIButton *done = (UIButton*)sender;
    
    if (done.tag == 1)
    {
        _datepicker.hidden = true;
        _toolbar.hidden = true;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        _StartTime.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datepicker.date]];
         _StartTime.enabled = YES;
    }
    else
    {
        _datepicker.hidden = true;
        _toolbar.hidden = true;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        _EndTime.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datepicker.date]];
         _EndTime.enabled = YES;
    }
    
    
    
}


- (IBAction)canclebtn:(id)sender
{
    UIButton *cancle = (UIButton *)sender;
    
    if (cancle.tag == 1)
    {
        _datepicker.hidden = true;
        _toolbar.hidden = true;
        _StartTime.text = @"";
          _StartTime.enabled = YES;
    }
    else
    {
        _datepicker.hidden = true;
        _toolbar.hidden = true;
        _EndTime.text = @"";
          _EndTime.enabled = YES;
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    UITextField *txt = (UITextField *)textField;
    
    if (txt.tag == 1 || txt.tag == 2)
    {
        return NO;
    }
    else{
        return YES;
    }
}



-(void)Validation_Delegate
{
    _name.delegate = self;
    _Email.delegate=self;
    _AddressLine1.delegate=self;
    _AddressLine2.delegate=self;
    _FromAddress.delegate=self;
    _ToAddress.delegate=self;
     _Mobile.delegate=self;
    
    _name.presentInView=self.view;
    _Email.presentInView=self.view;
   
    _AddressLine1.presentInView=self.view;
    _AddressLine2.presentInView=self.view;
    _FromAddress.presentInView=self.view;
    _ToAddress.presentInView=self.view;
     _Mobile.presentInView=self.view;
}
-(void)setupAlerts
{
    [_name addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Name can not be blank."];
    
    [_Email addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    
    [_AddressLine1 addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Addressline1 can not be blank."];
    
    [_AddressLine2 addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Addressline2 can not be blank."];
    
    [_FromAddress addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"From Address can not be blank."];
    
    [_ToAddress addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"To Address can not be blank."];
    
     [_Mobile addRegx:REGEX_PHONE_NUMBER withMsg:@"Mobile Number can not be blank."];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)Get_adondata
{
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
    adon_dic = [dic valueForKey:@"data"];
    [self jsonparsing_CargoType];
     _cargo_tabledata.hidden = YES;
    
//    //   NSDictionary *dic = [AppMethod Parse_Adondata];
//    //adon_dic = [[NSMutableDictionary alloc] initWithDictionary:[dic objectForKey:@"data"]copyItems:YES];
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    [ProgressHUD show:@"Please wait..."];
//    [manager GET:[baseurl stringByAppendingString:AddOnurl] parameters:nil progress:nil success:^(NSURLSessionTask *task, id hireresponse)
//     {
//         
//         adon_dic = [hireresponse valueForKey:@"data"];
//         [self jsonparsing_CargoType];
//         _cargo_tabledata.hidden = YES;
//         [ProgressHUD dismiss];
//         
//     } failure:^(NSURLSessionTask *operation, NSError *error)
//     {
//         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//         [al show];
//         [ProgressHUD dismiss];
//     }];
    
}
-(void)jsonparsing_CargoType
{
    
    cargotype=[[NSMutableArray alloc] initWithArray:[adon_dic objectForKey:@"cargo_type"]copyItems:YES];
    
    for (int i=0; i<[cargotype count];i++)
    {
        NSDictionary *dic12 = [cargotype objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [cargo addObject:str1];
    }
    [_cargo_tabledata reloadData];
}

-(void)textFieldDidChange:(UITextField *)textField
{
    
    _cargo_tabledata.hidden = NO;
    
    [self.cargo_tabledata reloadData];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cargo count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *table = @"cell12";
        
        CargoType_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
    
        cell.cargotype_lbl.text = [cargo objectAtIndex:indexPath.row];
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        _cargotyptxt.text=[cargo objectAtIndex:indexPath.row];
        cargo_type_id = [[[adon_dic valueForKey:@"cargo_type"]objectAtIndex:indexPath.row] valueForKey:@"id"];
        _cargo_tabledata.hidden = YES;
   
}



- (IBAction)submitbtn:(id)sender
{
    
    name = _name.text;
    c_name= _CompanyName.text;
    email=_Email.text;
    mobile=_Mobile.text;
    landline=_Landline.text;
    address1=_AddressLine1.text;
    address2=_AddressLine2.text;
    from_add=_FromAddress.text;
    to_add=_ToAddress.text;
    start_time=_StartTime.text;
    end_time=_EndTime.text;
    Approx_distance=_ApproxDistance.text;
    price=_Price.text;
    //cargo_type=.text;
    part_load_available=_PartLoadAvailable.text;
    
    if([_name validate] & [_Email validate] & [_AddressLine1 validate] & [_AddressLine2 validate] & [_FromAddress validate] & [_ToAddress validate] & [_Mobile validate])
  {

        setdic = [[NSMutableDictionary alloc]init];
        [setdic setObject:name forKey:@"name"];
        [setdic setObject:c_name forKey:@"company_name"];
        [setdic setObject:email forKey:@"email"];
        [setdic setObject:mobile forKey:@"mobile"];
        [setdic setObject:landline forKey:@"landline"];
        [setdic setObject:address1 forKey:@"addressline1"];
        [setdic setObject:address2 forKey:@"addressline2"];
        [setdic setObject:from_add forKey:@"from_address"];
        [setdic setObject:to_add forKey:@"to_address"];
        [setdic setObject:start_time forKey:@"start_time"];
        [setdic setObject:end_time forKey:@"end_time"];
        [setdic setObject:Approx_distance forKey:@"apprx_distance"];
        [setdic setObject:price forKey:@"price"];
    
    if ([cargo_type_id isEqualToString:@""])
    {
        [setdic setObject:[[[adon_dic valueForKey:@"cargo_type"]objectAtIndex:0]valueForKey:@"id"] forKey:@"cargo_type_id"];
    }
    else
    {
        [setdic setObject:cargo_type_id forKey:@"cargo_type_id"];
    }
    
     
    
        [setdic setObject:part_load_available forKey:@"part_load_available"];
      
      AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
      [ProgressHUD show:@"Please wait..."];
     
      [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
      [manager POST:[baseurl stringByAppendingString:tripPostRequest] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
       
       {
           BOOL boolean = [[dic12 valueForKey:@"status"] boolValue];
           if (boolean)
           {
               UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:[dic12 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
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

- (IBAction)dropdown_cargo:(id)sender
{
    _cargo_tabledata.hidden = NO;
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

- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
