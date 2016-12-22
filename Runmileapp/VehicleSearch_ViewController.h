//
//  VehicleSearch_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/7/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehicleSearch_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *pager,*ownerlist,*fualtyp;
    NSMutableDictionary *setdic;
    NSDictionary *vehicle_owner;
    NSMutableDictionary *price_range,*capacity,*kmDriven,*adon_dic;
  
    NSMutableArray *clickflag;
    
    NSDictionary *filter_dic;
   //filter_parametr
    NSMutableArray *Owner_typelist;
    NSMutableArray *citytyp,*citytypdata;
     NSMutableArray *brandtyp,*brandtypedata;
   NSString *fual,*noofown,*price,*kmdriv,*brand,*capaci,*city,*Currency;

    
}
@property (weak, nonatomic) IBOutlet UIButton *PostRequireHere;
- (IBAction)PostRequireHere:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *table_vehicle;
@property(nonatomic)int pageno;
@property(nonatomic)NSDictionary *dic1;
@property(nonatomic)NSDictionary *dic;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
- (IBAction)vehicle_filter:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view_filter;

@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;


//filter

@property (weak, nonatomic) IBOutlet UITextField *fual_type;
- (IBAction)dropdown_fualType:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *FualType_tabledata;


- (IBAction)price_Slider:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *price_slider;
@property (weak, nonatomic) IBOutlet UILabel *pricelbl1;
@property (weak, nonatomic) IBOutlet UILabel *pricelbl2;

@property (weak, nonatomic) IBOutlet UISlider *kmDriven_Slider;
- (IBAction)kmDriven_Slider:(UISlider *)sender;

@property (weak, nonatomic) IBOutlet UILabel *kmDrivenlbl1;

@property (weak, nonatomic) IBOutlet UILabel *kmDrivenlbl2;
@property (weak, nonatomic) IBOutlet UITextField *brand;

@property (weak, nonatomic) IBOutlet UISlider *capacitySlider;
- (IBAction)capacitySlider:(UISlider *)sender;

@property (weak, nonatomic) IBOutlet UILabel *capacitylbl1;
@property (weak, nonatomic) IBOutlet UILabel *capacitylbl2;
@property (weak, nonatomic) IBOutlet UITextField *city;

- (IBAction)clearbtn:(id)sender;

- (IBAction)Applybtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *table_noofOwner;

@property (nonatomic)NSString *pricemin,*pricemax,*locationsearch,*type;

- (IBAction)dropdown_city:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *city_table;
@property (weak, nonatomic) IBOutlet UITableView *table_brand;
@end
