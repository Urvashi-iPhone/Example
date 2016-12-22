//
//  sidebarViewController.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/24/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sidebarViewController : UIViewController

{
    NSMutableDictionary *setdic;
    NSMutableString *email;
}
- (IBAction)insurance:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *Email;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UIView *sliderview;
@property (weak, nonatomic) IBOutlet UIButton *sellVehicle;
@property (weak, nonatomic) IBOutlet UIButton *AutoParts;

@property (weak, nonatomic) IBOutlet UIButton *offertransport;





@end
