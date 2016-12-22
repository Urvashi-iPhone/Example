//
//  PostRequest_Test_Parts_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/8/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBAutoScrollLabel.h"
#import <MessageUI/MessageUI.h>
@interface PostRequest_Test_Parts_ViewController : UIViewController<MFMailComposeViewControllerDelegate>

{
    NSDictionary *adon_dic;
    NSString *Currency;
}

@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *TitleName;

@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;
@property (weak, nonatomic) IBOutlet UIView *imgview;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *OwnerName;
@property (weak, nonatomic) IBOutlet UILabel *Mobile;
@property (weak, nonatomic) IBOutlet UILabel *Email;
@property (weak, nonatomic) IBOutlet UIView *border1;
@property (weak, nonatomic) IBOutlet UIView *border2;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *Manufacture;
@property (weak, nonatomic) IBOutlet UILabel *parttype;
@property (weak, nonatomic) IBOutlet UILabel *VehicleModel;
@property (weak, nonatomic) IBOutlet UILabel *yearofManufacture;
@property (weak, nonatomic) IBOutlet UILabel *modelno;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *part_Detail;
@property (weak, nonatomic) IBOutlet UILabel *length;
@property (weak, nonatomic) IBOutlet UILabel *width;
@property (weak, nonatomic) IBOutlet UILabel *height;
@property (weak, nonatomic) IBOutlet UILabel *weight;

@property (nonatomic)NSDictionary *buypartsdata;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;

@end
