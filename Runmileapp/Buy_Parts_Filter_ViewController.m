//
//  Buy_Parts_Filter_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/16/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "Buy_Parts_Filter_ViewController.h"
#import "Constant.h"
#import "AppMethod.h"
#import "httpws.h"
#import "BuyPartsSearch_ViewController.h"

@interface Buy_Parts_Filter_ViewController ()

@end

@implementation Buy_Parts_Filter_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     pager=[[NSMutableArray alloc]init];
    
    NSDictionary *dic = [httpws httpGet:[baseurl stringByAppendingString:Filterurl]];
    
    NSDictionary *dic1 = [[NSMutableDictionary alloc] initWithDictionary:[dic objectForKey:@"data"]copyItems:YES];
    NSDictionary *dic2 = [[NSMutableDictionary alloc] initWithDictionary:[dic1 objectForKey:@"parts"]copyItems:YES];
    price_range = [[NSMutableDictionary alloc] initWithDictionary:[dic2 objectForKey:@"price_range"]copyItems:YES];
    [_price setMaximumValue:[[price_range valueForKey:@"max"]floatValue]];
    _pricelbl1.text = [NSString stringWithFormat:@"%@",[price_range valueForKey:@"min"]];
    _pricelbl2.text = [NSString stringWithFormat:@"%@",[price_range valueForKey:@"max"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



- (IBAction)clearbtn:(id)sender
{
    
}

- (IBAction)Applybtn:(id)sender
{
    part_type=_partsType.text;
    year_manu=_Yearofmanufacture.text;
//    price_rng=_price;
    brand=_brand.text;
    city=_city.text;
    
    if (part_type==nil && year_manu==nil && price_rng==nil && brand==nil && city==nil)
    {
        
    }
    else
    {
        setdic=[[NSMutableDictionary alloc]init];
        [setdic setObject:part_type forKey:@"parts_type"];
        [setdic setObject:year_manu forKey:@"year_manufacture"];
//        [setdic setObject:price_rng forKey:@"price"];
        [setdic setObject:brand forKey:@"brand"];
        [setdic setObject:city forKey:@"city"];
        
        NSString *access_token = [AppMethod getStringDefault:@"default_access_token"];
        
        NSMutableDictionary *dic12 = [httpws httpPostWithauth:[baseurl stringByAppendingString:BuyPartsSearchurl] :setdic :[AppMethod getStringDefault:@"default_access_token"]];
        
        NSDictionary *dic1 = [[NSDictionary alloc] initWithDictionary:[dic12 objectForKey:@"data"]copyItems:YES];
    
        NSMutableArray *pagerlist = [[NSMutableArray alloc] initWithArray:[dic1 valueForKey:@"pager"]copyItems:YES];
    
        for (int i=0; i<[pagerlist count]; i++)
        {
            [pager addObject:[pagerlist objectAtIndex:i]];
        
        }
        BOOL boolean = [[dic12 valueForKey:@"status"] boolValue];
        if (boolean)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (IBAction)SlidervalueChange:(UISlider *)sender
{
    NSLog(@"slider value = %f", sender.value);
    int value = (int)sender.value;
    _pricelbl1.text = [NSString stringWithFormat:@"%d",value];
  }


@end
