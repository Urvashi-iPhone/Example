//
//  PostRequestTest_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/6/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "PostRequestTest_ViewController.h"
#import "SWRevealViewController.h"
@interface PostRequestTest_ViewController ()

@end

@implementation PostRequestTest_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.TitleName.textColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    self.TitleName.labelSpacing = 30; // distance between start and end labels
    self.TitleName.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.TitleName.scrollSpeed = 30; // pixels per second
    self.TitleName.textAlignment = NSTextAlignmentCenter; // centers text when no auto-scrolling is applied
    self.TitleName.fadeLength = 12.f;
    self.TitleName.scrollDirection = CBAutoScrollDirectionLeft;
    [self.TitleName observeApplicationNotifications];
    
    
    self.FromAddress.textColor = [UIColor colorWithRed:29/255.0f green:29/255.0f blue:38/255.0f alpha:1.0f];
    self.FromAddress.labelSpacing = 30; // distance between start and end labels
    self.FromAddress.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.FromAddress.scrollSpeed = 30; // pixels per second
    self.FromAddress.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.FromAddress.fadeLength = 12.f;
    self.FromAddress.scrollDirection = CBAutoScrollDirectionLeft;
    [self.FromAddress observeApplicationNotifications];

    
    self.ToAddress.textColor = [UIColor colorWithRed:29/255.0f green:29/255.0f blue:38/255.0f alpha:1.0f];
    self.ToAddress.labelSpacing = 30; // distance between start and end labels
    self.ToAddress.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.ToAddress.scrollSpeed = 30; // pixels per second
    self.ToAddress.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.ToAddress.fadeLength = 12.f;
    self.ToAddress.scrollDirection = CBAutoScrollDirectionLeft;
    [self.ToAddress observeApplicationNotifications];

    
    self.companyName.textColor = [UIColor colorWithRed:29/255.0f green:29/255.0f blue:38/255.0f alpha:1.0f];
    self.companyName.labelSpacing = 30; // distance between start and end labels
    self.companyName.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.companyName.scrollSpeed = 30; // pixels per second
    self.companyName.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.companyName.fadeLength = 12.f;
    self.companyName.scrollDirection = CBAutoScrollDirectionLeft;
    [self.companyName observeApplicationNotifications];
    
    self.ownerName.textColor = [UIColor colorWithRed:29/255.0f green:29/255.0f blue:38/255.0f alpha:1.0f];
    self.ownerName.labelSpacing = 30; // distance between start and end labels
    self.ownerName.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.ownerName.scrollSpeed = 30; // pixels per second
    self.ownerName.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.ownerName.fadeLength = 12.f;
    self.ownerName.scrollDirection = CBAutoScrollDirectionLeft;
    [self.ownerName observeApplicationNotifications];
    
    self.email.textColor = [UIColor colorWithRed:29/255.0f green:29/255.0f blue:38/255.0f alpha:1.0f];
    self.email.labelSpacing = 30; // distance between start and end labels
    self.email.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.email.scrollSpeed = 30; // pixels per second
    self.email.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.email.fadeLength = 12.f;
    self.email.scrollDirection = CBAutoScrollDirectionLeft;
    [self.email observeApplicationNotifications];
    
    //scrollview
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlview.contentSize = contentRect.size;
    
    _border1.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];

    _border1.layer.borderWidth = 1.0f;
    _border1.layer.cornerRadius = 10;
   
    _border2.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _border2.layer.borderWidth = 1.0f;
    _border2.layer.cornerRadius = 10;
    
    _border3.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];
    _border3.layer.borderWidth = 1.0f;
    _border3.layer.cornerRadius = 10;
    
    _borderimg.layer.borderColor = [[UIColor colorWithRed:133/255.0f green:133/255.0f blue:133/255.0f alpha:1.0f]CGColor];

    _borderimg.layer.borderWidth = 2.0f;
   // _borderimg.layer.cornerRadius = 17;
    
    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
//    [[self navigationController] setNavigationBarHidden:YES animated:YES];
   
      NSDictionary *tripdata = _tripdata;
    
     _companyName.text = [[tripdata valueForKey:@"contact"] valueForKey:@"company_name"];
    
     _ownerName.text = [NSString stringWithFormat:@"%@ %@",[[tripdata valueForKey:@"contact"] valueForKey:@"firstname"],[[tripdata valueForKey:@"contact"] valueForKey:@"lastname"]];
    
     _mobile.text = [[tripdata valueForKey:@"contact"] valueForKey:@"mobile"];
     _email.text = [[tripdata valueForKey:@"contact"] valueForKey:@"email"];
    
     _TitleName.text = [tripdata valueForKey:@"title"];
     _FromAddress.text = [tripdata valueForKey:@"from_address"];
     _ToAddress.text = [tripdata valueForKey:@"to_address"];
     _StartTime.text = [tripdata valueForKey:@"start_time"];
     _EndTime.text = [tripdata valueForKey:@"end_time"];
     _Approx.text = [tripdata valueForKey:@"apprx_distance"];
     _CargoType.text = [tripdata valueForKey:@"cargo_type_id"];
     _PartAvailable.text = [tripdata valueForKey:@"part_load_available"];
     _Description.text = [tripdata valueForKey:@"description"];
     _Loading.text = [tripdata valueForKey:@"loading_adddress"];
     _Unloading.text = [tripdata valueForKey:@"unloading_address"];
    
  
    if ([[NSString stringWithFormat:@"%@",[tripdata valueForKey:@"status"]] isEqualToString:@"1"])
    {
        _ActiveStatus.text = @"Yes";
    }
    else
    {
        _ActiveStatus.text = @"No";
    }
    
     _LastUpdate.text = [tripdata valueForKey:@"updated_at"];
     _Brand.text = [[tripdata valueForKey:@"vehicle"] valueForKey:@"brand"];
     _Model.text = [[tripdata valueForKey:@"vehicle"] valueForKey:@"model"];
     _Capacity.text = [NSString stringWithFormat:@"%@",[[tripdata valueForKey:@"vehicle"] valueForKey:@"capacity"] ];
    
    if ([[[tripdata valueForKey:@"vehicle"] valueForKey:@"permit"] isEqualToString:@"1"])
    {
        _Permit.text = @"All India Permit";
    }
    else
    {
        _Permit.text = @"State Permit";
    }
    
     _VehicleType.text = [[tripdata valueForKey:@"vehicle"] valueForKey:@"vehicle_type_id"];
     _GPS.text = [[tripdata valueForKey:@"vehicle"] valueForKey:@"is_gps_enable"];
     _VehicleNo.text = [[tripdata valueForKey:@"vehicle"] valueForKey:@"vehicle_no"];
     _img.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[tripdata valueForKey:@"vehicle"]valueForKey:@"image"]]]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}
- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
