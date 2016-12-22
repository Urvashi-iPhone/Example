//
//  Buy_Parts_Filter_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/16/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Buy_Parts_Filter_ViewController : UIViewController


{
    NSString *part_type,*year_manu,*price_rng,*brand,*city;
    
    NSDictionary *price_range;
    NSMutableArray *pager;
    NSMutableDictionary *setdic;

}

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

@property(nonatomic)int pageno;
@property(nonatomic)NSDictionary *dic1;
@property(nonatomic)NSDictionary *dic;


@end
