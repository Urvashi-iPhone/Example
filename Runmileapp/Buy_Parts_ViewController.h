//
//  Buy_Parts_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/29/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Buy_Parts_ViewController : UIViewController
{
     CGFloat animatedDistance;
    NSString *parttype;
    NSMutableArray *parttyp,*parttypdata;
        NSDictionary *adon_dic;
}
@property (weak, nonatomic) IBOutlet UIButton *searchbtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;

@property (weak, nonatomic) IBOutlet UITextField *parttype;

@property (weak, nonatomic) IBOutlet UITextField *keyword;
@property (weak, nonatomic) IBOutlet UITextField *manufacture;
@property (weak, nonatomic) IBOutlet UITextField *year_manufacture;
@property (weak, nonatomic) IBOutlet UITextField *vehicle_model;

- (IBAction)Searchbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *table_parttype;
@property (weak, nonatomic) IBOutlet UIButton *r1;
@property (weak, nonatomic) IBOutlet UIButton *r2;
-(void)radiobuttonSelected:(id)sender;

@end
