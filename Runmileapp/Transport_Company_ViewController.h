//
//  Transport_Company_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/29/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Transport_Company_ViewController : UIViewController
{
    NSMutableArray *arrOfColor;
    NSMutableArray *searchArray;
    NSString *searchTextString,*transporttype;
    BOOL isFilter;
     NSMutableArray *transporttyp,*transporttypdata;
    NSDictionary *adondata;
     CGFloat animatedDistance;
    
}
@property (weak, nonatomic) IBOutlet UITableView *table_data;
@property (weak, nonatomic) IBOutlet UIButton *searchbtn;
@property (weak, nonatomic) IBOutlet UITextField *companyName;
@property (weak, nonatomic) IBOutlet UITextField *City;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
- (IBAction)Searchbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *tableborder;
@property (weak, nonatomic) IBOutlet UITextField *transporttype;
@property (weak, nonatomic) IBOutlet UITableView *table_transporttype;
@end
