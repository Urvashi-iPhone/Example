//
//  ManageTrip_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/24/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageTrip_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableDictionary *setdic;
    NSMutableArray *pager;
}
@property (weak, nonatomic) IBOutlet UITableView *table_data;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;

@property(nonatomic)int pageno;
@property(nonatomic)NSDictionary *dic1;
@property(nonatomic)NSDictionary *dic;

@end
