//
//  VehicleSearch_TableViewCell.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/7/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "VehicleSearch_TableViewCell.h"

@implementation VehicleSearch_TableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
   

    _imgview.layer.borderWidth = 2.0f;
    
    _Contactbtn.layer.cornerRadius = 17.0;
    _imgview.layer.borderColor =  [[UIColor colorWithRed:133/255.0f green:133/255.0f blue:133/255.0f alpha:1.0f]CGColor];
    
}

- (IBAction)Contactbtn:(id)sender
{
}
@end
