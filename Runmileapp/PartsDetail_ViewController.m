//
//  PartsDetail_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/29/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "PartsDetail_ViewController.h"
#import "PartsDetail_TableViewCell.h"

@interface PartsDetail_ViewController ()

@end

@implementation PartsDetail_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrlview.contentSize = CGSizeMake(320, 1400);
    
    
    _viewborder1.layer.borderColor=[[UIColor redColor]CGColor];
    _viewborder1.layer.borderWidth= 1.0f;
    _viewborder1.layer.cornerRadius = 15.0;
    
    
    _viewborder2.layer.borderColor = [[UIColor redColor]CGColor];
    _viewborder2.layer.borderWidth = 1.0f;
    _viewborder2.layer.cornerRadius = 15.0;
    
    _registerbtn.layer.cornerRadius = 15.0;
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *table = @"cell21";
    
    PartsDetail_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
    return cell;
    
    
}

- (IBAction)registerbtn:(id)sender
{
    
}
@end
