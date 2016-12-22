//
//  Sell_AutoParts_TableViewCell.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/13/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Sell_AutoParts_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *imgview;

@property (weak, nonatomic) IBOutlet UIImageView *partsimg;
@property (weak, nonatomic) IBOutlet UIButton *delete;
@property (weak, nonatomic) IBOutlet UIButton *TakeImagebtn;
- (IBAction)TakeImagebtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *TakeImagebtn_edit;

@end
