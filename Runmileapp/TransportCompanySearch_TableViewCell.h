//
//  TransportCompanySearch_TableViewCell.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/7/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "CBAutoScrollLabel.h"

@interface TransportCompanySearch_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UIView *imgview;

@property (weak, nonatomic) IBOutlet UILabel *mobile;
@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *name;


@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *email;

@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *website;
@property (weak, nonatomic) IBOutlet UILabel *transporttype;

@property (weak, nonatomic) IBOutlet UIButton *uncheckbtn;
@property (weak, nonatomic) IBOutlet UILabel *permitlbl;

@property (weak, nonatomic) IBOutlet HCSStarRatingView *rateview;


@property (weak, nonatomic) IBOutlet UILabel *permit;


@end
