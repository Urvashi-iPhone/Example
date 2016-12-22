//
//  ServiceDetails_TableViewCell.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/29/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceDetails_TableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *lblServiceName;

@property (weak, nonatomic) IBOutlet UIButton *servicecheckbtn;

@property (weak, nonatomic) IBOutlet UIView *viewservicedata;


- (IBAction)servicecheckbtn:(id)sender;


@end
