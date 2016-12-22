//
//  ManageVehicleAd_TableViewCell.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/26/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageVehicleAd_TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *brand;
@property (weak, nonatomic) IBOutlet UILabel *version;
@property (weak, nonatomic) IBOutlet UILabel *kmdriven;
@property (weak, nonatomic) IBOutlet UILabel *registerRTO;

- (IBAction)showbtn:(id)sender;

- (IBAction)editbtn:(id)sender;
- (IBAction)deletebtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *showbtn;
@property (weak, nonatomic) IBOutlet UIButton *editbtn;
@property (weak, nonatomic) IBOutlet UIButton *deletebtn;

@end
