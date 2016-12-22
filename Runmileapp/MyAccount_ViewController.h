//
//  MyAccount_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/24/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

#define REGEX_TEXTFIELD_LIMIT @"^[A-Za-z0-9]{1}+[A-Za-z0-9 .]{1,}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"[A-Za-z0-9]{6,20}"



@interface MyAccount_ViewController : UIViewController
{
    NSMutableString *user_id,*OldPass,*NewPass,*ConformPass;
    NSMutableDictionary *changepass;
}

@property (weak, nonatomic) IBOutlet UIButton *Manage_Vehicle;

@property (weak, nonatomic) IBOutlet UIButton *Create_Vehicle;

@property (weak, nonatomic) IBOutlet UIButton *Manage_Parts;
@property (weak, nonatomic) IBOutlet UIButton *Create_Parts;

@property (weak, nonatomic) IBOutlet UIButton *Manage_Trip;

@property (weak, nonatomic) IBOutlet UIButton *Create_Trip;

- (IBAction)ManageTrip:(id)sender;
- (IBAction)Profile:(id)sender;
- (IBAction)ManageVehicle:(id)sender;
- (IBAction)CreateVehicle:(id)sender;
- (IBAction)manageParts:(id)sender;
- (IBAction)CreateParts:(id)sender;
- (IBAction)CreateTrip:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Menubtn;
- (IBAction)Logout:(id)sender;

@property (weak, nonatomic) IBOutlet TextFieldValidator *oldpsw;
@property (weak, nonatomic) IBOutlet TextFieldValidator *newpsw;
@property (weak, nonatomic) IBOutlet TextFieldValidator *conformpsw;
@property (weak, nonatomic) IBOutlet UIButton *submitbtn;
- (IBAction)ChangePassword:(id)sender;

- (IBAction)submitbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *canclebtn;
- (IBAction)canclebtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *changepswView;
@end
