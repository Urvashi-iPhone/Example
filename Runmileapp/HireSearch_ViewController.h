//
//  HireSearch_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/5/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HireSearch_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray *pager,*vehicletype;
    NSMutableDictionary *setdic;
    NSMutableString *titlename;
    NSMutableDictionary *price_range,*capacity_range;
    NSMutableArray *cargo,*cargotype;
    NSMutableArray *hireser1,*hireser_type,*clickflag;
    
    NSDictionary *vehicle_list;
    NSMutableArray *vehiclelist;
    NSMutableString *cargolist;
    
    NSDictionary *adon_dic;
    
    //filter_parameter
    
    NSString *from_address,*to_address,*start_time,*capacity,*price,*is_gps_enable,*cargo_type,*part_load_available,*Currency;
    
    NSMutableArray *vehicle_typelist;
    
}

//datepicker

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UITextField *startDateRange;



@property (weak, nonatomic) IBOutlet UITableView *table_trip;
- (IBAction)post_Require_Here:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *post_required_here;
@property(nonatomic)int pageno;
@property(nonatomic)NSDictionary *dic1;
@property(nonatomic)NSDictionary *dic;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;

- (IBAction)hire_filter:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *view_filter;

@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;


@property (weak, nonatomic) IBOutlet UISlider *CapacitySlider;

@property (weak, nonatomic) IBOutlet UILabel *Capacitylbl1;

@property (weak, nonatomic) IBOutlet UILabel *Capacitylbl2;

@property (weak, nonatomic) IBOutlet UILabel *Pricelbl2;
@property (weak, nonatomic) IBOutlet UILabel *Pricelbl1;
@property (weak, nonatomic) IBOutlet UISlider *PriceSlider;
- (IBAction)PriceSlider:(UISlider *)sender;
- (IBAction)CapacitySlider:(UISlider *)sender;


@property (weak, nonatomic) IBOutlet UITableView *Table_VehicleType;
@property (weak, nonatomic) IBOutlet UIButton *IsGPS_uncheckbtn;
@property (weak, nonatomic) IBOutlet UIButton *IsGPS_checkbtn2;
@property (weak, nonatomic) IBOutlet UITextField *CargoType;
- (IBAction)dropdown_cargo:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *cargo_tabledata;

@property (weak, nonatomic) IBOutlet UITextField *PastLoad;

- (IBAction)clearbtn:(id)sender;

- (IBAction)Applybtn:(id)sender;
@property (nonatomic)NSString *Fromsearch;
@property (nonatomic)NSString *Tosearch;
@property (nonatomic)NSString *Datesearch;

@property(nonatomic)NSDictionary *sliderdic;

@end
