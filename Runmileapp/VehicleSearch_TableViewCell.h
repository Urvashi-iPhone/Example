//
//  VehicleSearch_TableViewCell.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/7/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehicleSearch_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIView *imgview;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *kms;
@property (weak, nonatomic) IBOutlet UILabel *NoofOwners;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *FualType;
@property (weak, nonatomic) IBOutlet UILabel *Capacity;
@property (weak, nonatomic) IBOutlet UILabel *Color;
@property (weak, nonatomic) IBOutlet UILabel *Price;
@property (weak, nonatomic) IBOutlet UIButton *Contactbtn;
- (IBAction)Contactbtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *noofowner;

@property (weak, nonatomic) IBOutlet UIButton *uncheckbtn;


@property (weak, nonatomic) IBOutlet UILabel *Fualtypelbl;

@property (weak, nonatomic) IBOutlet UIButton *uncheck_fual;


@end
