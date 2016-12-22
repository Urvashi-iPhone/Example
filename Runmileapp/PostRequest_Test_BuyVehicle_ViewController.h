//
//  PostRequest_Test_BuyVehicle_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/8/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
#import "CBAutoScrollLabel.h"
@interface PostRequest_Test_BuyVehicle_ViewController : UIViewController
{
    NSDictionary *adon_dic;
    NSString *Currency;
    
    NSMutableArray *VehicleimageList;
    int imgposition;
  
    
}

@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *TitleName;
@property (weak, nonatomic) IBOutlet SwipeView *viewSwipe;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIView *imgview;
@property (weak, nonatomic) IBOutlet UIView *border1;
@property (weak, nonatomic) IBOutlet UIView *border2;
@property (weak, nonatomic) IBOutlet UILabel *brand;

@property (weak, nonatomic) IBOutlet UILabel *vehicle;

@property (weak, nonatomic) IBOutlet UILabel *version;
@property (weak, nonatomic) IBOutlet UILabel *color;
@property (weak, nonatomic) IBOutlet UILabel *makeYear;
@property (weak, nonatomic) IBOutlet UILabel *YearRegistration;
@property (weak, nonatomic) IBOutlet UILabel *NoofOwners;
@property (weak, nonatomic) IBOutlet UILabel *KmDriven;
@property (weak, nonatomic) IBOutlet UILabel *City;
@property (weak, nonatomic) IBOutlet UILabel *PUC;
@property (weak, nonatomic) IBOutlet UILabel *RegistationRTO;
@property (weak, nonatomic) IBOutlet UILabel *InsuranceValid;

@property (weak, nonatomic) IBOutlet UILabel *Price;
@property (weak, nonatomic) IBOutlet UILabel *Additional_Info;
@property (weak, nonatomic) IBOutlet UILabel *Type;
@property (weak, nonatomic) IBOutlet UILabel *capacity;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *companyName;
@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *OwnerName;


@property (weak, nonatomic) IBOutlet UILabel *Mobile;
@property (weak, nonatomic) IBOutlet UILabel *Email;

@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;

@property (nonatomic)NSDictionary *vehicledata;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;


@end
