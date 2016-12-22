//
//  PostRequestTest_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/6/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBAutoScrollLabel.h"

@interface PostRequestTest_ViewController : UIViewController

@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *TitleName;
@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;
@property (weak, nonatomic) IBOutlet UIView *border1;
@property (weak, nonatomic) IBOutlet UIView *border2;
@property (weak, nonatomic) IBOutlet UIView *border3;
@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *FromAddress;
@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *ToAddress;


@property (weak, nonatomic) IBOutlet UILabel *StartTime;
@property (weak, nonatomic) IBOutlet UILabel *EndTime;
@property (weak, nonatomic) IBOutlet UILabel *Approx;

@property (weak, nonatomic) IBOutlet UILabel *CargoType;
@property (weak, nonatomic) IBOutlet UILabel *PartAvailable;
@property (weak, nonatomic) IBOutlet UILabel *Description;
@property (weak, nonatomic) IBOutlet UILabel *Loading;

@property (weak, nonatomic) IBOutlet UILabel *Unloading;



@property (weak, nonatomic) IBOutlet UILabel *LastUpdate;
@property (weak, nonatomic) IBOutlet UILabel *ActiveStatus;

@property (weak, nonatomic) IBOutlet UIView *borderimg;

@property (weak, nonatomic) IBOutlet UILabel *Brand;
@property (weak, nonatomic) IBOutlet UILabel *Model;
@property (weak, nonatomic) IBOutlet UILabel *Capacity;
@property (weak, nonatomic) IBOutlet UILabel *Permit;
@property (weak, nonatomic) IBOutlet UILabel *VehicleType;
@property (weak, nonatomic) IBOutlet UILabel *GPS;
@property (weak, nonatomic) IBOutlet UILabel *VehicleNo;
@property (nonatomic)NSDictionary *tripdata;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;

@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *companyName;
@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *ownerName;

@property (weak, nonatomic) IBOutlet UILabel *mobile;

@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *email;

@end
