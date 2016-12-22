//
//  SignUp1_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/26/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "SignUp1_ViewController.h"
#import "SelectProfileTypeTableViewCell.h"
#import "SignUp2_ViewController.h"
#import "httpws.h"
#import "Constant.h"
#import "AppMethod.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"

@interface SignUp1_ViewController ()<UITextFieldDelegate>

@end

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@implementation SignUp1_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

   // self.navigationController.navigationBar.hidden=YES;
    //scrollview

    [_uname setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_email setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_pass setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_mobileno setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_cpass setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    _proceedbtn.layer.cornerRadius = 17.0;
    
    
    user = [[NSMutableArray alloc]init];
    clickflag = [[NSMutableArray alloc]init];
    adon_dic = [[NSDictionary alloc]init];
    
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
    adon_dic = [[NSMutableDictionary alloc] initWithDictionary:[dic objectForKey:@"data"]copyItems:YES];
    
    
    usertyp=[[NSMutableArray alloc] initWithArray:[adon_dic objectForKey:@"user_type"]copyItems:YES];
    
    for (int i=0; i<[usertyp count];i++)
    {
        NSDictionary *dic12 = [usertyp objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [user addObject:str1];
    }
    
    _uname.delegate=self;
    _uname.presentInView=self.view;
    
    _email.delegate=self;
    _email.presentInView=self.view;
   
    _pass.delegate=self;
    _pass.presentInView=self.view;
    
    _cpass.delegate=self;
    _cpass.presentInView=self.view;
    
    [self setupAlerts];
    
    
    UITapGestureRecognizer *m2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handle)];
    _imgview.userInteractionEnabled=YES;
    
    [m2 setNumberOfTapsRequired:1];
    
    [self.imgview addGestureRecognizer:m2];
    [self viewDidLayoutSubviews];
}

-(void)handle
{
    [self.imgview endEditing:YES];
}
-(void)viewDidLayoutSubviews
{
    CGFloat navBarHeight = 20.0f;
    CGRect frame = CGRectMake(0.0f, 0.0f, 520.0f, navBarHeight);
    [self.navigationController.navigationBar setFrame:frame];
}

-(void)setupAlerts
{
   [_uname addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Username can not be blank."];
    
    [_email addRegx:REGEX_EMAIL withMsg:@"Enter valid email"];
    
    [_pass addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password can not be blank."];
    
    [_cpass addConfirmValidationTo:_pass withMsg:@"Confirm password didn't match"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [user count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *table = @"cell12";
    
    SelectProfileTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
    
    //ipad tablview clear color
    
    [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
    if (cell == nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
    }
    
    cell.lablvalue.text=[user objectAtIndex:indexPath.row];
    
    cell.checkbtn.tag=indexPath.row;
    [cell.checkbtn addTarget:self action:@selector(ChkUnChk:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

-(void)ChkUnChk:(id)sender
{
    
    UIButton *btn=(UIButton *)sender;
    NSString *Str=[NSString stringWithFormat:@"%d",btn.tag];
    BOOL flag=   [clickflag containsObject:Str];
    
    if (flag==YES)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"uncheck.png"]forState:UIControlStateNormal];
        [clickflag removeObject:Str];
    }
    else
    {
        [clickflag addObject:Str];
        [btn setBackgroundImage:[UIImage imageNamed:@"check.png"]forState:UIControlStateNormal];
    }
}




- (IBAction)proceedbtn:(id)sender
{
    
    Email = _email.text;
    Pass =_pass.text;
    Username=_uname.text;
    Mobile=_mobileno.text;
    
    if ([clickflag count]<1)
    {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Select minimum one User Type" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [al show];
        return;
    }
    

    if([_email validate] & [_pass validate] & [_uname validate])
    {

        setdic=[[NSMutableDictionary alloc]init];
        [setdic setObject:Email forKey:@"email"];
        [setdic setObject:Pass forKey:@"password"];
        [setdic setObject:Username forKey:@"username"];
        [setdic setObject:Mobile forKey:@"mobile"];
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        for (int i=0; i<[clickflag count]; i++)
        {
            NSString *posabc=[[clickflag objectAtIndex:i]description];
            
            NSDictionary *dic12 = [usertyp objectAtIndex:[posabc intValue]];
            
            NSString *str21 = [dic12 objectForKey:@"id"];
            
            [array addObject:str21];
            
        }
        [setdic setObject:array forKey:@"user_type"];
        
        
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
         [ProgressHUD show:@"Please wait..."];
        [manager POST:[baseurl stringByAppendingString:Signup1url] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
         {
        
        BOOL boolean = [[dic12 valueForKey:@"status"] boolValue];
        
        if (boolean)
        {
            
            SignUp2_ViewController *sc=[self.storyboard instantiateViewControllerWithIdentifier:@"SignUp2_ViewController"];
            
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic12 options:NSJSONWritingPrettyPrinted error:&error];
            
            if (! jsonData)
            {
                NSLog(@"Got an error: %@", error);
            } else
            {
                sc.abcd= [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            }
            
            [self.navigationController pushViewController:sc animated:YES];
        }
        else
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[dic12 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [al show];
        }

             [ProgressHUD dismiss];
         }failure:^(NSURLSessionTask *operation, NSError *error)
        {
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
             [al show];
            [ProgressHUD dismiss];
         }];
        
    }
    
}

- (IBAction)backbtn:(id)sender
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
