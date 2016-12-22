//
//  PartsDetail_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/29/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartsDetail_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;
@property (weak, nonatomic) IBOutlet UIView *viewborder2;

@property (weak, nonatomic) IBOutlet UIView *viewborder1;

@property (weak, nonatomic) IBOutlet UITableView *table_data;
@property (weak, nonatomic) IBOutlet UIButton *registerbtn;
- (IBAction)registerbtn:(id)sender;

@end
