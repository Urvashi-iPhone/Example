//
//  Hire_ViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/29/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Hire_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString *from,*to,*date;
    NSMutableDictionary *setdic;
    NSMutableArray *arrOfColor;
    NSMutableArray *searchArray;
    NSString *searchTextString;
    BOOL isFilter;
    int txtenable;
    
    CGFloat animatedDistance;
}

@property (weak, nonatomic) IBOutlet UIButton *searchbtn;
- (IBAction)searchbtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *From;
@property (weak, nonatomic) IBOutlet UITableView *tabledata;

@property (weak, nonatomic) IBOutlet UITextField *To;




@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@property (strong, nonatomic) IBOutlet UIView *imgview;
@property (weak, nonatomic) IBOutlet UIView *tableborder;

//datepicker
@property (weak, nonatomic) IBOutlet UITextField *datepickertxt;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIToolbar *donebtn;
@property (weak, nonatomic) IBOutlet UIToolbar *cancelbtn;

@end
