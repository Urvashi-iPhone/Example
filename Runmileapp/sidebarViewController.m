//
//  sidebarViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/24/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "sidebarViewController.h"
#import "sell_vehicle_ViewController.h"
#import "ContactUs_ViewController.h"
#import "SWRevealViewController.h"
#import "AppMethod.h"
#import "Sell_Autoparts_ViewController.h"
#import "InsuranceViewController.h"
#import "FinanceViewController.h"
#import "MyAccount_ViewController.h"
#import "Service_ViewController.h"
#import "Other_Transport_ViewController.h"
#import "httpws.h"
#import "Constant.h"
#import "AppMethod.h"
#import "LoginViewController.h"

@interface sidebarViewController ()

@end

@implementation sidebarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    _img.layer.cornerRadius = _img.frame.size.height /2;
   _img.layer.masksToBounds = YES;
    _img.layer.borderWidth = 0;
    
     NSString *username = [NSString stringWithFormat:@"%@ %@",[AppMethod getStringDefault:@"default_fname"],[AppMethod getStringDefault:@"default_lname"]];

    _Name.text = username;
    _Email.text = [AppMethod getStringDefault:@"default_email"];
    
    
    
    NSString *imgurl = [AppMethod getStringDefault:@"default_profileImage"];
    _img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgurl]]];
    

    
    NSString *strdata=[NSString stringWithFormat:@"%@",[AppMethod getArrayDefault:@"default_role"]];
    
    _sellVehicle.enabled = NO;
    _AutoParts.enabled = NO;
    _offertransport.enabled = NO;
    
    
    for (int i = 0; i<[[AppMethod getArrayDefault:@"default_role"] count]; i++)
    {
        NSString *abc = [[AppMethod getArrayDefault:@"default_role"] objectAtIndex:i];
        
        if ([abc isEqualToString:@"user"])
        {
           
        }
        else if ([abc isEqualToString:@"dealer"])
        {
            _sellVehicle.enabled = YES;
        }
        else if ([abc isEqualToString:@"seller"])
        {
            _sellVehicle.enabled = YES;
             _AutoParts.enabled = YES;
        }
        else if ([abc isEqualToString:@"parts_dealer"])
        {
             _AutoParts.enabled = YES;
            
        }
        else if ([abc isEqualToString:@"transporter"])
        {
            _offertransport.enabled = YES;
        }
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  
}

- (IBAction)sell_your_vehicle:(id)sender
{
}
- (IBAction)sell_your_autoparts:(id)sender
{
}
- (IBAction)finance:(id)sender
{
}

- (IBAction)insurance:(id)sender
{

}

- (IBAction)other_transport:(id)sender
{

}
- (IBAction)service:(id)sender
{

}

- (IBAction)my_account:(id)sender
{

}


- (IBAction)contact_us:(id)sender
{
    

}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] )
    {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
    
}


@end
