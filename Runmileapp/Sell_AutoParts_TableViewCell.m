//
//  Sell_AutoParts_TableViewCell.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/13/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "Sell_AutoParts_TableViewCell.h"

@implementation Sell_AutoParts_TableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    _imgview.layer.borderColor = [[UIColor blueColor]CGColor];
    _imgview.layer.borderWidth = 1.0f;
    _imgview.layer.cornerRadius = 15.0;
    _delete.layer.cornerRadius = 13.0;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
