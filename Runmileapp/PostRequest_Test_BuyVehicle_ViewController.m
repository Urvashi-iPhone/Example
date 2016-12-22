//
//  PostRequest_Test_BuyVehicle_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/8/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "PostRequest_Test_BuyVehicle_ViewController.h"
#import "SWRevealViewController.h"
#import "AppMethod.h"
@interface PostRequest_Test_BuyVehicle_ViewController ()<SwipeViewDataSource, SwipeViewDelegate>

@end

@implementation PostRequest_Test_BuyVehicle_ViewController

- (void)dealloc
{
    _viewSwipe.delegate = nil;
    _viewSwipe.dataSource = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@",_vehicledata);
      _viewSwipe.pagingEnabled = YES;
    
    _border1.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _border1.layer.borderWidth = 1.0f;
    _border1.layer.cornerRadius = 10;
        _border2.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _border2.layer.borderWidth = 1.0f;
    _border2.layer.cornerRadius = 10;
    
    _imgview.layer.borderColor = [[UIColor blueColor]CGColor];
    _imgview.layer.borderWidth = 1.0f;
  
    
    
    self.TitleName.textColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    self.TitleName.labelSpacing = 30; // distance between start and end labels
    self.TitleName.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.TitleName.scrollSpeed = 30; // pixels per second
    self.TitleName.textAlignment = NSTextAlignmentCenter; // centers text when no auto-scrolling is applied
    self.TitleName.fadeLength = 12.f;
    self.TitleName.scrollDirection = CBAutoScrollDirectionLeft;
    [self.TitleName observeApplicationNotifications];
    
    self.companyName.textColor = [UIColor colorWithRed:29/255.0f green:29/255.0f blue:38/255.0f alpha:1.0f];
    self.companyName.labelSpacing = 30; // distance between start and end labels
    self.companyName.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.companyName.scrollSpeed = 30; // pixels per second
    self.companyName.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.companyName.fadeLength = 12.f;
    self.companyName.scrollDirection = CBAutoScrollDirectionLeft;
    [self.companyName observeApplicationNotifications];
    
    self.OwnerName.textColor = [UIColor colorWithRed:29/255.0f green:29/255.0f blue:38/255.0f alpha:1.0f];
    self.OwnerName.labelSpacing = 30; // distance between start and end labels
    self.OwnerName.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.OwnerName.scrollSpeed = 30; // pixels per second
    self.OwnerName.textAlignment = NSTextAlignmentRight; // centers text when no auto-scrolling is applied
    self.OwnerName.fadeLength = 12.f;
    self.OwnerName.scrollDirection = CBAutoScrollDirectionLeft;
    [self.OwnerName observeApplicationNotifications];
    
  
    
    
    //scrollview
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlview.contentSize = contentRect.size;
    
    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    adon_dic = [[NSDictionary alloc]init];
    [self Get_adondata];
    [self Get_Currency];

    NSDictionary *vehicledata = _vehicledata;
    VehicleimageList = [[NSMutableArray alloc]init];
    imgposition = 0;
    
    _TitleName.text = [vehicledata valueForKey:@"name"];
    _comment.text = [vehicledata valueForKey:@"additonal_info"];
    _brand.text=[vehicledata valueForKey:@"brand"];
      
    if ([[NSString stringWithFormat:@"%@",[vehicledata valueForKey:@"is_new"]] isEqualToString:@"1"])
    {
        _vehicle.text = @"New";
    }
    else
    {
        _vehicle.text = @"Old";
    }

    _version.text=[vehicledata valueForKey:@"version"];
    _color.text=[vehicledata valueForKey:@"color"];
    _makeYear.text=[NSString stringWithFormat:@"%@",[vehicledata valueForKey:@"make_year"]];
    _YearRegistration.text=[NSString stringWithFormat:@"%@",[vehicledata valueForKey:@"year_registration"]];
    _NoofOwners.text=[NSString stringWithFormat:@"%@",[vehicledata valueForKey:@"no_of_owners"]];
    _KmDriven.text=[NSString stringWithFormat:@"%@",[vehicledata valueForKey:@"km_driven"]];
    _City.text=[vehicledata valueForKey:@"city"];
    _PUC.text=[vehicledata valueForKey:@"puc"];
    _RegistationRTO.text=[vehicledata valueForKey:@"rigister_rto"];
    _InsuranceValid.text=[NSString stringWithFormat:@"%@",[vehicledata valueForKey:@"insurance_valid"]];
    
    NSString *curr = [NSString stringWithFormat:@"%@ %@",[Currency valueForKey:@"symbol"],[vehicledata valueForKey:@"price"]];
                                        
                                                          
    
    _Price.text = curr;
    

    _Additional_Info.text=[vehicledata valueForKey:@"additonal_info"];
    _Type.text=[[vehicledata valueForKey:@"vehicle_type_id"]valueForKey:@"type"];
    
    NSString *capacity = [NSString stringWithFormat:@"%@ %@",[vehicledata valueForKey:@"capacity"],[vehicledata valueForKey:@"capacity_unit"]];
    _capacity.text=capacity;
    
    if ([[NSString stringWithFormat:@"%@",[vehicledata valueForKey:@"status"]] isEqualToString:@"1"])
    {
        _status.text = @"Inactive";
    }
    else
    {
        _status.text = @"Active";
    }

    _companyName.text=[[vehicledata valueForKey:@"contact"]valueForKey:@"company_name"];
    NSString *ownrname = [NSString stringWithFormat:@"%@ %@",[[vehicledata valueForKey:@"contact"]valueForKey:@"firstname"],[[vehicledata valueForKey:@"contact"]valueForKey:@"lastname"]];
    _OwnerName.text=ownrname;
    _Mobile.text=[[vehicledata valueForKey:@"contact"]valueForKey:@"mobile"];
    _Email.text=[[vehicledata valueForKey:@"contact"]valueForKey:@"email"];
    
    if ([vehicledata valueForKey:@"images"] != nil && [[vehicledata valueForKey:@"images"] count] > 0)
    {
        for (int i =0; i<[[vehicledata valueForKey:@"images"] count]; i++) {
            NSURL *url = [NSURL URLWithString:[[vehicledata valueForKey:@"images"] objectAtIndex:i]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [[UIImage alloc] initWithData:data];
            if (img == nil) {
                img = [UIImage imageNamed:@"app_icon.png"];
            }
            [VehicleimageList addObject:img];
        }
      
    }
    
  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //return the total number of items in the carousel
    return [VehicleimageList count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView *img = nil;
    
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:self.viewSwipe.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
        UIView *imgborder = [[UIView alloc] initWithFrame:self.viewSwipe.bounds];
        imgborder.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        float img_x = (self.viewSwipe.frame.size.width/2)-(self.viewSwipe.frame.size.height/2);
        
        img = [[UIImageView alloc]initWithFrame:CGRectMake(img_x, 0, self.viewSwipe.frame.size.height, self.viewSwipe.frame.size.height)];
        img.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        img.image = [VehicleimageList objectAtIndex:index];
        
        img.tag = 1;
        [view addSubview:img];
        
    }
    else
    {
        //get a reference to the label in the recycled view
        img = (UIImageView *)[view viewWithTag:1];
    }
    
    img.image = [VehicleimageList objectAtIndex:index];
    
    return view;
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.viewSwipe.bounds.size;
}

-(void)Get_adondata
{
    
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
    adon_dic = [[NSMutableDictionary alloc] initWithDictionary:[dic objectForKey:@"data"]copyItems:YES];
    
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
