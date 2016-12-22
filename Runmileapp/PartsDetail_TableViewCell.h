//
//  PartsDetail_TableViewCell.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/29/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartsDetail_TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblpartsname;

- (IBAction)partscheckbtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *partscheckbtn;

@end
