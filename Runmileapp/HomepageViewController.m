//
//  HomepageViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/24/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "HomepageViewController.h"
#import "SWRevealViewController.h"
@interface HomepageViewController ()

@end

@implementation HomepageViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
 //[[UINavigationBar appearance]setFrame:CGRectMake(0, 0,self.view.frame.size.width, 60)];
    self.scrlview.contentSize = CGSizeMake(1400, 624);
   
   
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:203.0/255.0 green:65.0/255.0 blue:80.0/255.0 alpha:1.0]];

         [self.navigationItem setTitle:@"Search"];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];

    
    // Change button color
[_menubtn setTintColor:[UIColor whiteColor]];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    // Do any additional setup after loading the view.
    
    
    //segment size change
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:12.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    
    
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
