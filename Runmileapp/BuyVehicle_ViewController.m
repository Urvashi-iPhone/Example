//
//  BuyVehicle_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/29/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "BuyVehicle_ViewController.h"
#import "httpws.h"
#import "SWRevealViewController.h"
#import "VehicleSearch_ViewController.h"
@interface BuyVehicle_ViewController ()

@end
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
@implementation BuyVehicle_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    
    // [[UINavigationBar appearance]setFrame:CGRectMake(0, 0,self.view.frame.size.width, 60)];
      _searchbtn.layer.cornerRadius = 19.0;
     [self.location addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.location addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    _table_data.hidden = YES;
    _tableborder.hidden = YES;
    _tableborder.layer.borderColor = [[UIColor grayColor]CGColor];
    _tableborder.layer.borderWidth = 1.0f;

   [self Tabbar_SwipeGesture];
//    UITapGestureRecognizer *m2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handle)];
//    _imgview.userInteractionEnabled=YES;
//    
//    [m2 setNumberOfTapsRequired:1];
//    
//    [self.imgview addGestureRecognizer:m2];
    
  }
//-(void)handle
//{
//    [self.imgview endEditing:YES];
//}
//
-(void)Tabbar_SwipeGesture
{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
}
-(IBAction)tappedRightButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    [self.tabBarController setSelectedIndex:selectedIndex + 1];
    
    CATransition *anim= [CATransition animation];
    [anim setType:kCATransitionPush];
    [anim setSubtype:kCATransitionFromRight];
    [anim setDuration:0.4];
    [anim setTimingFunction:[CAMediaTimingFunction functionWithName:
                             kCAMediaTimingFunctionEaseIn]];
    [self.tabBarController.view.layer addAnimation:anim forKey:@"fadeTransition"];
}

- (IBAction)tappedLeftButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    [self.tabBarController setSelectedIndex:selectedIndex - 1];
    
    CATransition *anim= [CATransition animation];
    [anim setType:kCATransitionPush];
    [anim setSubtype:kCATransitionFromLeft];
    
    [anim setDuration:0.4];
    [anim setTimingFunction:[CAMediaTimingFunction functionWithName:
                             kCAMediaTimingFunctionEaseIn]];
    [self.tabBarController.view.layer addAnimation:anim forKey:@"fadeTransition"];
}

-(void)radiobuttonSelected:(id)sender
{
    switch ([sender tag])
    {
        case 0:
            if([_r1 isSelected]==YES)
            {
                [_r1 setSelected:NO];
                [_r2 setSelected:YES];
            }
            else{
                [_r1 setSelected:YES];
                [_r2 setSelected:NO];
            }
            
            break;
        case 1:
            if([_r2 isSelected]==YES)
            {
                [_r2 setSelected:NO];
                [_r1 setSelected:YES];
            }
            else{
                [_r2 setSelected:YES];
                [_r1 setSelected:NO];
            }
            
            break;
        default:
            break;
    }
    
}
-(void)viewDidAppear:(BOOL)animated

{
    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
  //  [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [_r1 setTag:0];
    [_r1 setBackgroundImage:[UIImage imageNamed:@"radio.png"] forState:UIControlStateNormal];
    [_r1 setBackgroundImage:[UIImage imageNamed:@"radio-checked.png"] forState:UIControlStateSelected];
    [_r1 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
      [_r2 setTag:1];
    [_r2 setBackgroundImage:[UIImage imageNamed:@"radio.png"] forState:UIControlStateNormal];
    [_r2 setBackgroundImage:[UIImage imageNamed:@"radio-checked.png"] forState:UIControlStateSelected];
    [_r2 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isFilter)
    {
        return [searchArray count];
    }
    else
        return  [arrOfColor count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if(isFilter)
    {
        cell.textLabel.text=[searchArray objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text=[arrOfColor objectAtIndex:indexPath.row];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     _table_data.hidden = YES;
     _tableborder.hidden = YES;
     _location.text=[arrOfColor objectAtIndex:indexPath.row];
   
    
}
-(void)updateSearchArray:(NSString *)searchText
{
    if(searchText.length==0)
    {
        isFilter=NO;
    }
    else{
        
        isFilter=YES;
        searchArray=[[NSMutableArray alloc]init];
        for(NSString *string in arrOfColor)
        {
            
            NSRange stringRange=[string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(stringRange.location !=NSNotFound)
            {
                
                [searchArray addObject:string];
            }
        }
        [self.table_data reloadData];
        
    }
}

-(void)textFieldDidChange:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""])
    {
        _table_data.hidden = YES;
        _tableborder.hidden = YES;
    }
    else
    {
        _table_data.hidden = NO;
        _tableborder.hidden = NO;
    }
    
    searchTextString=textField.text;
    arrOfColor=[[NSMutableArray alloc]init];
    arrOfColor = [httpws getGooglePlace:searchTextString];
    [self.table_data reloadData];
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"%@",text);
    
    if([text length] == 0)
    {
        if([textView.text length] != 0)
        {
            return YES;
        }
    }
    else if([[textView text] length] > 139)
    {
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (IBAction)Searchbtn:(id)sender
{
    VehicleSearch_ViewController *vsearch = [self.storyboard instantiateViewControllerWithIdentifier:@"VehicleSearch_ViewController"];
    
    vsearch.pricemin = _price_min.text;
    vsearch.pricemax = _price_max.text;
    
    if([_r1 isSelected]==YES)
    {
        vsearch.type = @"1";
    }
    else{
        vsearch.type = @"2";
    }

   
    vsearch.locationsearch = _location.text;

    
    [self.navigationController pushViewController:vsearch animated:YES];
}






@end
