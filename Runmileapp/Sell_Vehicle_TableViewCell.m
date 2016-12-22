//
//  Sell_Vehicle_TableViewCell.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/13/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "Sell_Vehicle_TableViewCell.h"

@implementation Sell_Vehicle_TableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    _imgview.layer.borderColor = [[UIColor blueColor]CGColor];
    _imgview.layer.borderWidth = 1.0f;
    _deletebtn.layer.cornerRadius = 13.0;
    
    
    _border1.layer.borderColor = [[UIColor blueColor]CGColor];
    _border1.layer.borderWidth= 1.0f;
    _border1.layer.cornerRadius = 15.0;

   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

   
}

@end
