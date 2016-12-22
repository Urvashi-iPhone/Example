//
//  HireSearch_TableViewCell.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/5/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HCSStarRatingView.h"
#import "CBAutoScrollLabel.h"
@interface HireSearch_TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *imgview;
@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *from;
@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *to;


@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *startdate;
@property (weak, nonatomic) IBOutlet UILabel *vehicletyp;

@property (weak, nonatomic) IBOutlet UILabel *capacity;
@property (weak, nonatomic) IBOutlet UILabel *cargotyp;
@property (weak, nonatomic) IBOutlet UIImageView *imagetyp;

@property (weak, nonatomic) IBOutlet UILabel *doller;

@property (weak, nonatomic) IBOutlet UIView *inquiryview;

- (IBAction)contactbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *contactbtn;
@property (weak, nonatomic) IBOutlet UILabel *vehicleType;

@property (weak, nonatomic) IBOutlet UIButton *uncheckbtn;
@property (weak, nonatomic) IBOutlet UILabel *cargolbl;

@property (weak, nonatomic) IBOutlet HCSStarRatingView *rateview;

@end
