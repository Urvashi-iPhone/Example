//
//  TransportCompanySearch_TableViewCell.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/7/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "TransportCompanySearch_TableViewCell.h"


@implementation TransportCompanySearch_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
     _imgview.layer.borderColor = [[UIColor colorWithRed:133/255.0f green:133/255.0f blue:133/255.0f alpha:1.0f]CGColor];
    _imgview.layer.borderWidth = 2.0f;
    
    self.email.textColor = [UIColor colorWithRed:29/255.0f green:29/255.0f blue:38/255.0f alpha:1.0f];
    self.email.labelSpacing = 30; // distance between start and end labels
    self.email.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.email.scrollSpeed = 30; // pixels per second
    self.email.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.email.fadeLength = 12.f;
    self.email.scrollDirection = CBAutoScrollDirectionLeft;
    [self.email observeApplicationNotifications];
    
    self.website.textColor = [UIColor colorWithRed:29/255.0f green:29/255.0f blue:38/255.0f alpha:1.0f];
    self.website.labelSpacing = 30; // distance between start and end labels
    self.website.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.website.scrollSpeed = 30; // pixels per second
    self.website.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.website.fadeLength = 12.f;
    self.website.scrollDirection = CBAutoScrollDirectionLeft;
    [self.website observeApplicationNotifications];
    
    self.name.textColor = [UIColor colorWithRed:0/255.0f green:84/255.0f blue:164/255.0f alpha:1.0f];
    self.name.labelSpacing = 30; // distance between start and end labels
    self.name.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.name.scrollSpeed = 30; // pixels per second
    self.name.textAlignment = NSTextAlignmentLeft; // centers text when no auto-scrolling is applied
    self.name.fadeLength = 12.f;
    self.name.scrollDirection = CBAutoScrollDirectionLeft;
    [self.name observeApplicationNotifications];

    
    _rateview.maximumValue = 5;
    _rateview.minimumValue = 0;
    _rateview.value = 0.0f;
    _rateview.allowsHalfStars = YES;
    _rateview.emptyStarImage = [[UIImage imageNamed:@"heart-empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _rateview.filledStarImage = [[UIImage imageNamed:@"heart-full"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
  
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

 
}

@end
