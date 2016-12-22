//
//  TransportCompanySearch_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/7/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import <MessageUI/MessageUI.h>
@interface TransportCompanySearch_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,MFMailComposeViewControllerDelegate
>
{
    NSMutableArray *pager;
    NSMutableDictionary *setdic;
    
    NSMutableArray *service,*servicetype,*clickflag;
    NSMutableArray *permit,*permittype;
    
    NSDictionary *adon_dic;
    NSMutableArray *citytyp,*citytypdata;
      //filter_parameter
    NSString *company_name,*city,*permit_type,*transport_type,*rate,*run_mile_approve;
    NSMutableArray *transport_typelist;

}

@property (weak, nonatomic) IBOutlet UITableView *table_transport;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menutbn;
- (IBAction)Transport_filter:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view_filter;
@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;

@property(nonatomic)int pageno;
@property(nonatomic)NSDictionary *dic1;
@property(nonatomic)NSDictionary *dic;

@property (weak, nonatomic) IBOutlet UITextField *permitType;

@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITableView *permittype_tabledata;



@property (weak, nonatomic) IBOutlet UITableView *table_service;
@property (weak, nonatomic) IBOutlet UIButton *Runmile_unCheckbtn;
@property (weak, nonatomic) IBOutlet UIButton *dropdownbtn;
- (IBAction)clearbtn:(id)sender;
- (IBAction)applybtn:(id)sender;

@property (weak, nonatomic) IBOutlet HCSStarRatingView *rateview;

@property(nonatomic)NSString *cnamesearch,*citysearch;

- (IBAction)dropdown_city:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *city_table;
@end
