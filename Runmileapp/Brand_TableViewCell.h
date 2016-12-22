//
//  Brand_TableViewCell.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/29/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Brand_TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblBrandname;

@property (weak, nonatomic) IBOutlet UIButton *brandcheckbtn;
- (IBAction)brandcheckbtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *countrylbl;


@end
