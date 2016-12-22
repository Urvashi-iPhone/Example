//
//  BuyPartsSearch_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/7/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BuyPartsSearch_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *pager;
    NSMutableDictionary *setdic;
     NSMutableArray *citytyp,*citytypdata;
   
    NSDictionary *price_range;
    //filter_parametr
     NSString *part_type,*keyword,*manufacture,*year_manu,*vehiclemodel,*price_rng,*brand,*city;
    
    NSMutableArray *parttyp,*parttypdata;
    NSDictionary *adon_dic;
    NSString *currency;
      NSMutableArray *brandtyp,*brandtypedata;

}
@property (weak, nonatomic) IBOutlet UITableView *table_parts;
@property(nonatomic)int pageno;
@property(nonatomic)NSDictionary *dic1;
@property(nonatomic)NSDictionary *dic;

@property (weak, nonatomic) IBOutlet UIButton *PostRequestbtn;
- (IBAction)PostRequestbtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;

- (IBAction)filter_parts:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewfilter;


//filter
@property(nonatomic)NSDictionary *sliderdic;
@property (weak, nonatomic) IBOutlet UITextField *partsType;

@property (weak, nonatomic) IBOutlet UITextField *Yearofmanufacture;
@property (weak, nonatomic) IBOutlet UISlider *price;
@property (weak, nonatomic) IBOutlet UILabel *pricelbl1;

@property (weak, nonatomic) IBOutlet UILabel *pricelbl2;

@property (weak, nonatomic) IBOutlet UITextField *brand;
@property (weak, nonatomic) IBOutlet UITextField *city;

- (IBAction)clearbtn:(id)sender;
- (IBAction)Applybtn:(id)sender;

- (IBAction)SlidervalueChange:(UISlider *)sender;

@property(nonatomic)NSString *parttypsearch;
@property(nonatomic)NSString *keywordsearch;
@property(nonatomic)NSString *manufacturesearch;
@property(nonatomic)NSString *yearmanufacturesearch;
@property(nonatomic)NSString *vehiclemodelpsearch;
@property (weak, nonatomic) IBOutlet UITableView *table_parttype;

- (IBAction)dropdown_city:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *city_table;
@property (nonatomic)NSString *type;
- (IBAction)dropdown_brand:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *table_brand;

@end
