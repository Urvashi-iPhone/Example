//
//  BuyPartsSearch_TableViewCell.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/7/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "BuyPartsSearch_TableViewCell.h"

@implementation BuyPartsSearch_TableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
  
    _imgview.layer.borderColor = [[UIColor colorWithRed:133/255.0f green:133/255.0f blue:133/255.0f alpha:1.0f]CGColor];
    _imgview.layer.borderWidth = 2.0f;
    
    _contactbtn.layer.cornerRadius = 17.0;
    
    self.partType.textColor = [UIColor colorWithRed:29/255.0f green:29/255.0f blue:38/255.0f alpha:1.0f];
    self.partType.labelSpacing = 30; // distance between start and end labels
    self.partType.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.partType.scrollSpeed = 30; // pixels per second
    self.partType.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.partType.fadeLength = 12.f;
    self.partType.scrollDirection = CBAutoScrollDirectionLeft;
    [self.partType observeApplicationNotifications];
    
    self.Manufacture.textColor = [UIColor colorWithRed:29/255.0f green:29/255.0f blue:38/255.0f alpha:1.0f];
    self.Manufacture.labelSpacing = 30; // distance between start and end labels
    self.Manufacture.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.Manufacture.scrollSpeed = 30; // pixels per second
    self.Manufacture.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.Manufacture.fadeLength = 12.f;
    self.Manufacture.scrollDirection = CBAutoScrollDirectionLeft;
    [self.Manufacture observeApplicationNotifications];
    
    self.VehicleModel.textColor = [UIColor colorWithRed:29/255.0f green:29/255.0f blue:38/255.0f alpha:1.0f];
    self.VehicleModel.labelSpacing = 30; // distance between start and end labels
    self.VehicleModel.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.VehicleModel.scrollSpeed = 30; // pixels per second
    self.VehicleModel.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.VehicleModel.fadeLength = 12.f;
    self.VehicleModel.scrollDirection = CBAutoScrollDirectionLeft;
    [self.VehicleModel observeApplicationNotifications];
    
    self.YearofManufacture.textColor = [UIColor colorWithRed:29/255.0f green:29/255.0f blue:38/255.0f alpha:1.0f];
    self.YearofManufacture.labelSpacing = 30; // distance between start and end labels
    self.YearofManufacture.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.YearofManufacture.scrollSpeed = 30; // pixels per second
    self.YearofManufacture.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.YearofManufacture.fadeLength = 12.f;
    self.YearofManufacture.scrollDirection = CBAutoScrollDirectionLeft;
    [self.YearofManufacture observeApplicationNotifications];
    
    self.PartsDetail.textColor = [UIColor colorWithRed:29/255.0f green:29/255.0f blue:38/255.0f alpha:1.0f];
    self.PartsDetail.labelSpacing = 30; // distance between start and end labels
    self.PartsDetail.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.PartsDetail.scrollSpeed = 30; // pixels per second
    self.PartsDetail.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.PartsDetail.fadeLength = 12.f;
    self.PartsDetail.scrollDirection = CBAutoScrollDirectionLeft;
    [self.PartsDetail observeApplicationNotifications];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)contactbtn:(id)sender {
}
@end
