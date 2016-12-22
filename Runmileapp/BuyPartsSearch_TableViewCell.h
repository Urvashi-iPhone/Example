//
//  BuyPartsSearch_TableViewCell.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/7/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBAutoScrollLabel.h"
@interface BuyPartsSearch_TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIView *imgview;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *partType;

@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *Manufacture;

@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *VehicleModel;

@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *YearofManufacture;
@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *PartsDetail;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *dollar;
@property (weak, nonatomic) IBOutlet UIButton *contactbtn;
- (IBAction)contactbtn:(id)sender;

@end
