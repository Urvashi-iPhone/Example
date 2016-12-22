//
//  HireSearch_TableViewCell.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/5/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "HireSearch_TableViewCell.h"


@implementation HireSearch_TableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _imgview.layer.borderColor = [[UIColor colorWithRed:133/255.0f green:133/255.0f blue:133/255.0f alpha:1.0f]CGColor];
    _imgview.layer.borderWidth = 2.0f;
    _contactbtn.layer.cornerRadius = 17.0;
    
    _rateview.maximumValue = 5;
    _rateview.minimumValue = 0;
    _rateview.value = 0.0f;
    _rateview.allowsHalfStars = YES;
   _rateview.emptyStarImage = [[UIImage imageNamed:@"heart-empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _rateview.filledStarImage = [[UIImage imageNamed:@"heart-full"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
   
    self.from.textColor = [UIColor colorWithRed:29/255.0f green:29/255.0f blue:38/255.0f alpha:1.0f];
    self.from.labelSpacing = 30; // distance between start and end labels
    self.from.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.from.scrollSpeed = 30; // pixels per second
    self.from.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.from.fadeLength = 12.f;
    self.from.scrollDirection = CBAutoScrollDirectionLeft;
    [self.from observeApplicationNotifications];
    
    
    self.to.textColor = [UIColor colorWithRed:29/255.0f green:29/255.0f blue:38/255.0f alpha:1.0f];
    self.to.labelSpacing = 30; // distance between start and end labels
    self.to.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.to.scrollSpeed = 30; // pixels per second
    self.to.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.to.fadeLength = 12.f;
    self.to.scrollDirection = CBAutoScrollDirectionLeft;
    [self.to observeApplicationNotifications];
    
}

- (IBAction)contactbtn:(id)sender
{
      
}

@end
