//
//  PostRequest_Test_Parts_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/8/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "PostRequest_Test_Parts_ViewController.h"
#import "SWRevealViewController.h"
#import "AppMethod.h"

@interface PostRequest_Test_Parts_ViewController ()
@end

@implementation PostRequest_Test_Parts_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    _border1.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _border1.layer.borderWidth = 1.0f;
    _border1.layer.cornerRadius = 10;
    _border2.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _border2.layer.borderWidth = 1.0f;
    _border2.layer.cornerRadius = 10;
    _imgview.layer.borderColor = [[UIColor colorWithRed:133/255.0f green:133/255.0f blue:133/255.0f alpha:1.0f]CGColor];

    _imgview.layer.borderWidth = 2.0f;
    
    
    self.TitleName.textColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    self.TitleName.labelSpacing = 30; // distance between start and end labels
    self.TitleName.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.TitleName.scrollSpeed = 30; // pixels per second
    self.TitleName.textAlignment = NSTextAlignmentCenter; // centers text when no auto-scrolling is applied
    self.TitleName.fadeLength = 12.f;
    self.TitleName.scrollDirection = CBAutoScrollDirectionLeft;
    [self.TitleName observeApplicationNotifications];

    
    
    //scrollview
    CGRect contentRect = CGRectZero;
    
    for (UIView *view in self.scrlview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlview.contentSize = contentRect.size;

    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
  //  NSLog(@"%@",_buypartsdata);
    adon_dic = [[NSDictionary alloc]init];
    [self Get_adondata];
    

    
    NSDictionary *buypartsdata = _buypartsdata;
    
    _TitleName.text = [buypartsdata valueForKey:@"name"];
    
    _name.text=[buypartsdata valueForKey:@"name"];
    _Manufacture.text=[buypartsdata valueForKey:@"manufacturer"];
    _parttype.text=[buypartsdata valueForKey:@"parts_type"];
    _VehicleModel.text=[buypartsdata valueForKey:@"vehicle_model"];
    _yearofManufacture.text=[NSString stringWithFormat:@"%@",[buypartsdata valueForKey:@"year_of_manufacture"]];
    _modelno.text=[buypartsdata valueForKey:@"model_no"];
    
    NSString *curr = [NSString stringWithFormat:@"%@ %@",[Currency valueForKey:@"symbol"],[buypartsdata valueForKey:@"price"]];
    
    _price.text = curr;

    _part_Detail.text=[buypartsdata valueForKey:@"parts_detail"];
    _length.text=[NSString stringWithFormat:@"%@",[buypartsdata valueForKey:@"lenght"]];
    _width.text=[NSString stringWithFormat:@"%@",[buypartsdata valueForKey:@"width"]];
    _height.text=[NSString stringWithFormat:@"%@",[buypartsdata valueForKey:@"height"]];
    _weight.text=[NSString stringWithFormat:@"%@",[buypartsdata valueForKey:@"weight"]];
    _companyName.text=[[buypartsdata valueForKey:@"contact"]valueForKey:@"company_name"];
    
    NSString *ownrname = [NSString stringWithFormat:@"%@ %@",[[buypartsdata valueForKey:@"contact"]valueForKey:@"firstname"],[[buypartsdata valueForKey:@"contact"]valueForKey:@"lastname"]];
    
    _OwnerName.text=ownrname;
    
    _Mobile.text=[[buypartsdata valueForKey:@"contact"]valueForKey:@"mobile"];
    _Email.text=[[buypartsdata valueForKey:@"contact"]valueForKey:@"email"];
    
    if ([[buypartsdata valueForKey:@"images"] count]>0)
    {
        NSString *imgurl = [[buypartsdata valueForKey:@"images"]objectAtIndex:0];
        
        _img.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgurl]]];
    }
    
    UITapGestureRecognizer *tapGestureRecognizeremail = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didRecognizeTapGesturemobileemail:)];
    tapGestureRecognizeremail.numberOfTapsRequired = 1;
    [_Email addGestureRecognizer:tapGestureRecognizeremail];
    _Email.userInteractionEnabled = YES;
   
}
- (void)didRecognizeTapGesturemobileemail:(UITapGestureRecognizer*)gesture
{
    UILabel *emailurl = [gesture view];
      NSLog(@"%@",[emailurl text]);
    
    MFMailComposeViewController *mailcontroler = [[MFMailComposeViewController alloc] init];
    [mailcontroler setMailComposeDelegate:self];
    NSArray *emailarray = [[NSArray alloc] initWithObjects:[emailurl text], nil];
    [mailcontroler setToRecipients:emailarray];
//    [mailcontroler setSubject:@"helo"];
    
    [self presentViewController:mailcontroler animated:YES completion:nil];
    
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)Get_adondata
{
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
     adon_dic = [dic valueForKey:@"data"];
    [self Get_Currency];
    
}
-(void)Get_Currency
{
    
    Currency = [adon_dic objectForKey:@"currency"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
