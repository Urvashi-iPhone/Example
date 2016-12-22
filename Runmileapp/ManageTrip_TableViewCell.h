//
//  ManageTrip_TableViewCell.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/24/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageTrip_TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *Tripid;

@property (weak, nonatomic) IBOutlet UILabel *fromAdd;
@property (weak, nonatomic) IBOutlet UILabel *ToAdd;
@property (weak, nonatomic) IBOutlet UILabel *StartTim;
@property (weak, nonatomic) IBOutlet UILabel *EndTime;
@property (weak, nonatomic) IBOutlet UILabel *Price;

@property (weak, nonatomic) IBOutlet UILabel *Status;

@property (weak, nonatomic) IBOutlet UIButton *showbtn;
@property (weak, nonatomic) IBOutlet UIButton *editbtn;
@property (weak, nonatomic) IBOutlet UIButton *deletebtn;

@end
