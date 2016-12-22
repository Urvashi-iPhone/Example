//
//  ManagePartsAd_TableViewCell.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/26/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagePartsAd_TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *vehicle_model;

@property (weak, nonatomic) IBOutlet UILabel *modelno;
@property (weak, nonatomic) IBOutlet UILabel *price;


@property (weak, nonatomic) IBOutlet UIButton *deletebtn;

@property (weak, nonatomic) IBOutlet UIButton *showbtn;
@property (weak, nonatomic) IBOutlet UIButton *editbtn;

@end
