//
//  BuyVehicle_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/29/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyVehicle_ViewController : UIViewController

{
    NSMutableArray *arrOfColor;
    NSMutableArray *searchArray;
    NSString *searchTextString;
    BOOL isFilter;
     CGFloat animatedDistance;
    
}

@property (weak, nonatomic) IBOutlet UIButton *searchbtn;
- (IBAction)Searchbtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *price_min;

@property (weak, nonatomic) IBOutlet UITextField *price_max;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UITableView *table_data;

@property (weak, nonatomic) IBOutlet UIButton *r1;
@property (weak, nonatomic) IBOutlet UIButton *r2;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;

-(void)radiobuttonSelected:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *tableborder;

@property (strong, nonatomic) IBOutlet UIView *imgview;

@end
