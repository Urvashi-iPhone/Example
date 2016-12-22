//
//  Transport_Company_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/29/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "Transport_Company_ViewController.h"
#import "httpws.h"
#import "SWRevealViewController.h"
#import "TransportCompanySearch_ViewController.h"
#import "AppMethod.h"
#import "Vehicle_Type_Capacity_New_TableViewCell.h"
@interface Transport_Company_ViewController ()

@end
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
@implementation Transport_Company_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     //[[UINavigationBar appearance]setFrame:CGRectMake(0, 0,self.view.frame.size.width, 60)];
    
     adondata = [[NSDictionary alloc]init];
    transporttyp = [[NSMutableArray alloc]init];
    [self Get_Adondata];

    
    [self.City addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
   

    _searchbtn.layer.cornerRadius = 19.0;
    _tableborder.layer.borderColor = [[UIColor grayColor]CGColor];
    _tableborder.layer.borderWidth = 1.0f;
    
    _table_data.hidden = YES;
    _tableborder.hidden = YES;
    
      [self Tabbar_SwipeGesture];
     transporttype = @"";
    // Do any additional setup after loading the view.
}
-(void)Get_Adondata
{
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
    adondata = [dic valueForKey:@"data"];
    
   
    
    [self jsonparsing_TransportType];
    _table_transporttype.hidden = YES;
    
}

-(void)jsonparsing_TransportType
{
    
    transporttypdata=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"transporter_service"]copyItems:YES];
    
    for (int i=0; i<[transporttypdata count];i++)
    {
        NSDictionary *dic12 = [transporttypdata objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [transporttyp addObject:str1];
    }
    [_table_transporttype reloadData];
}
-(void)textFieldDidChange:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""])
    {
        _table_data.hidden = YES;
        _tableborder.hidden = YES;
    }
    else if (textField == _transporttype)
    {
        _table_transporttype.hidden = NO;
        
        [self.table_transporttype reloadData];
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

-(void)viewDidAppear:(BOOL)animated
{
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
   // [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
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
    else if(tableView==_table_transporttype)
    {
        return [transporttyp count];
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
   if (tableView==_table_transporttype)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
        }
        cell.transportTypelbl.text = [transporttyp objectAtIndex:indexPath.row];
        
        return cell;
        
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
   if (tableView == _table_transporttype)
    {
        _transporttype.text=[transporttyp objectAtIndex:indexPath.row];
         transporttype= [[[adondata valueForKey:@"transporter_service"]objectAtIndex:indexPath.row] valueForKey:@"id"];
        _table_transporttype.hidden = YES;
    }

    _table_data.hidden = YES;
     _tableborder.hidden = YES;
    _City.text=[arrOfColor objectAtIndex:indexPath.row];
    
    
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
    TransportCompanySearch_ViewController *cmpny = [self.storyboard instantiateViewControllerWithIdentifier:@"TransportCompanySearch_ViewController"];
    
    cmpny.cnamesearch = _companyName.text;
    cmpny.citysearch = _City.text;
    
    [self.navigationController pushViewController:cmpny animated:YES];
}
- (IBAction)dropdown_transport:(id)sender
{
    _table_transporttype.hidden = NO;
}

@end
