//
//  MyAccount_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/24/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "MyAccount_ViewController.h"
#import "MyProfile_ViewController.h"
#import "ManageVehicleAd_ViewController.h"
#import "ManagePartsAd_ViewController.h"
#import "SWRevealViewController.h"
#import "LoginViewController.h"
#import "sell_vehicle_ViewController.h"
#import "Sell_AutoParts_ViewController.h"
#import "httpws.h"
#import "Constant.h"
#import "AppMethod.h"
#import "Edit_Profile_ViewController.h"
#import "ManageTrip_ViewController.h"
#import "Offer_Transport_ViewController.h"
#import "ProgressHUD.h"
#import <AFNetworking.h>

@interface MyAccount_ViewController ()<UITextFieldDelegate>

@end

@implementation MyAccount_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    _Menubtn.target = self.revealViewController;
    _Menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    _changepswView.hidden = YES;
    
    _Manage_Trip.enabled = NO;
    _Create_Trip.enabled = NO;
    _Manage_Vehicle.enabled = NO;
    _Create_Vehicle.enabled = NO;
    _Manage_Parts.enabled = NO;
    _Create_Parts.enabled = NO;
    
    NSString *strdata=[NSString stringWithFormat:@"%@",[AppMethod getArrayDefault:@"default_role"]];
    
    
    for (int i = 0; i<[[AppMethod getArrayDefault:@"default_role"] count]; i++)
    {
        NSString *abc = [[AppMethod getArrayDefault:@"default_role"] objectAtIndex:i];
        
        if ([abc isEqualToString:@"user"])
        {
            
            
        }
        else if ([abc isEqualToString:@"dealer"])
        {
            _Manage_Vehicle.enabled = YES;
            _Create_Vehicle.enabled = YES;
            
        }
        else if ([abc isEqualToString:@"seller"])
        {
            _Manage_Vehicle.enabled = YES;
            _Create_Vehicle.enabled = YES;
            _Manage_Parts.enabled = YES;
            _Create_Parts.enabled = YES;
            
        }
        else if ([abc isEqualToString:@"parts_dealer"])
        {
           
            _Manage_Parts.enabled = YES;
            _Create_Parts.enabled = YES;
           
        }
        else if ([abc isEqualToString:@"transporter"])
        {
            _Manage_Trip.enabled = YES;
            _Create_Trip.enabled = YES;
        }
        
    }
    [self setupAlerts];
    [self Validation_Delegate];

    
    // Do any additional setup after loading the view.
}

-(void)Validation_Delegate
{
    _oldpsw.delegate=self;
    _newpsw.delegate=self;
    _conformpsw.delegate=self;
    
    
    _oldpsw.presentInView=self.view;
    _newpsw.presentInView=self.view;
    _conformpsw.presentInView=self.view;
    
}
-(void)setupAlerts
{
    [_oldpsw addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Old Password can not be blank."];
    
    [_newpsw addRegx:REGEX_PASSWORD_LIMIT withMsg:@"New Password can not be blank."];
    
    [_conformpsw addConfirmValidationTo:_newpsw withMsg:@"Confirm password didn't match"];

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)ManageTrip:(id)sender
{
    ManageTrip_ViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"ManageTrip_ViewController"];
    
    
    [self.navigationController pushViewController:tab animated:YES];
}

- (IBAction)Profile:(id)sender
{
    MyProfile_ViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfile_ViewController"];


    [self.navigationController pushViewController:tab animated:YES];
}

- (IBAction)Edit_Profile:(id)sender
{
    Edit_Profile_ViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"Edit_Profile_ViewController"];
    [self.navigationController pushViewController:tab animated:YES];
}

- (IBAction)ManageVehicle:(id)sender
{
    
    ManageVehicleAd_ViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"ManageVehicleAd_ViewController"];
    
    [self.navigationController pushViewController:tab animated:YES];

}

- (IBAction)CreateVehicle:(id)sender
{
    sell_vehicle_ViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"sell_vehicle_ViewController"];
    [self.navigationController pushViewController:tab animated:YES];
}

- (IBAction)manageParts:(id)sender
{
    ManagePartsAd_ViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"ManagePartsAd_ViewController"];
    [self.navigationController pushViewController:tab animated:YES];
}

- (IBAction)CreateParts:(id)sender
{
    Sell_AutoParts_ViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"Sell_AutoParts_ViewController"];
    [self.navigationController pushViewController:tab animated:YES];
}

- (IBAction)CreateTrip:(id)sender
{
    Offer_Transport_ViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"Offer_Transport_ViewController"];
    [self.navigationController pushViewController:tab animated:YES];
}


- (IBAction)Logout:(id)sender
{
    [AppMethod  setStringDefault:@"default_id" : @""];
    [AppMethod  setStringDefault:@"default_access_token" :@""];
    [AppMethod  setStringDefault:@"default_email" :@""];
    [AppMethod  setStringDefault:@"default_fname" :@""];
    [AppMethod  setStringDefault:@"default_lname" :@""];
    [AppMethod  setStringDefault:@"default_profileImage" :@""];
    
    
    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Run Mile" message:@"Do you really want to Logout? " delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles:@"YES", nil];
    [al show];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController presentationController];
        
    }
    else
    {
        LoginViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:tab animated:YES];
    }
}
- (IBAction)ChangePassword:(id)sender
{
    _changepswView.hidden = NO;
    
    _oldpsw.text =@"";
    _newpsw.text = @"";
    _conformpsw.text = @"";
}

- (IBAction)submitbtn:(id)sender
{
    
    OldPass = _oldpsw.text;
    NewPass = _newpsw.text;
    ConformPass = _conformpsw.text;
    
    if ([_oldpsw validate] & [_newpsw validate] & [_conformpsw validate])
    {

         changepass = [[NSMutableDictionary alloc]init];
        
        [changepass setObject:[AppMethod getStringDefault:@"default_id"] forKey:@"user_id"];
        [changepass setObject:OldPass forKey:@"old_password"];
        [changepass setObject:NewPass forKey:@"new_password"];
      
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
          [ProgressHUD show:@"Please wait..."];
        NSLog(@"%@",[AppMethod getStringDefault:@"default_access_token"]);
        [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
        
        
        [manager POST:[baseurl stringByAppendingString:ChangePassurl] parameters:changepass progress:nil success:^(NSURLSessionTask *task, id dicpass1)
         
         {
             
             BOOL boolean = [[dicpass1 valueForKey:@"status"]boolValue];
             if (boolean)
             {
                 UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:[dicpass1 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                 [al show];
                 _changepswView.hidden = YES;
             }
             else
             {
                 UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[dicpass1 valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                 [al show];
                 _changepswView.hidden = YES;
             }
             [ProgressHUD dismiss];

         }failure:^(NSURLSessionTask *operation, NSError *error)
         {
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
             [al show];
             [ProgressHUD dismiss];
         }];
        
        
      }
}
- (IBAction)canclebtn:(id)sender
{
    _changepswView.hidden = YES;
    [self.navigationController presentedViewController];
}
@end
