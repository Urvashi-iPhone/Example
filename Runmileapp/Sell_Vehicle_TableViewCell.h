//
//  Sell_Vehicle_TableViewCell.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/13/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Sell_Vehicle_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Vehicleimg;
@property (weak, nonatomic) IBOutlet UIButton *deletebtn;
@property (weak, nonatomic) IBOutlet UIView *imgview;


@property (weak, nonatomic) IBOutlet UIImageView *vehicleimg_edit;

@property (weak, nonatomic) IBOutlet UIButton *deletebtn_edit;

@property (weak, nonatomic) IBOutlet UIButton *Takeimagebtn;

@property (weak, nonatomic) IBOutlet UIView *border1;


@property (weak, nonatomic) IBOutlet UIButton *Takeimagebtn_edit;

@end
