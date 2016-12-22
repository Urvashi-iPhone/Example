//
//  ManagePartsAd_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/26/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagePartsAd_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableDictionary *setdic;
    NSDictionary *adon_dic;
    NSString *Currency;
    NSMutableArray *pager;
}
@property (weak, nonatomic) IBOutlet UITableView *table_data;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@property(nonatomic)int pageno;
@property(nonatomic)NSDictionary *dic1;
@property(nonatomic)NSDictionary *dic;


@end
