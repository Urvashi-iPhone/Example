//
//  Hire_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/29/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "Hire_ViewController.h"
#import "httpws.h"
#import "AppMethod.h"
#import "HireSearch_ViewController.h"
#import "Constant.h"
#import "SWRevealViewController.h"



@interface Hire_ViewController ()

@end

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@implementation Hire_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    _tableborder.layer.borderColor = [[UIColor grayColor]CGColor];
    _tableborder.layer.borderWidth = 1.0f;
   
    _datePicker.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1.0f];
    
    _searchbtn.layer.cornerRadius = 19.0;
    [[self navigationController]setNavigationBarHidden:YES animated:YES];
      
    
    [self.From addTarget:self action:@selector(textFieldDidChange_From:) forControlEvents:UIControlEventEditingChanged];
    [self.To addTarget:self action:@selector(textFieldDidChange_To:) forControlEvents:UIControlEventEditingChanged];
    
    _toolbar.hidden = true;
    _datePicker.hidden = true;
    [_datepickertxt setDelegate:self];

 
    NSString *access_token = [AppMethod getStringDefault:@"default_access_token"];

    _tabledata.hidden = YES;
    _tableborder.hidden = YES;
  
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didRecognizeTapGesture:)];
    [self.datepickertxt.superview addGestureRecognizer:tapGesture];
    
  [self Tabbar_SwipeGesture];
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
    
//    CATransition *anim= [CATransition animation];
//    [anim setType:kCATransitionPush];
//    [anim setSubtype:kCATransitionFromLeft];
//    
//    [anim setDuration:0.4];
//    [anim setTimingFunction:[CAMediaTimingFunction functionWithName:
//                             kCAMediaTimingFunctionEaseIn]];
//    [self.tabBarController.view.layer addAnimation:anim forKey:@"fadeTransition"];
}

//-(void)tapmethiod
//{
//        UITapGestureRecognizer *m2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handle)];
//        _imgview.userInteractionEnabled=YES;
//    
//        [m2 setNumberOfTapsRequired:1];
//    
//        [self.imgview addGestureRecognizer:m2];
//}
//
//
//-(void)handle
//{
//    [self.imgview endEditing:YES];
//}


//-(void)datepickerset
//{
//    
//    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
//    [datePicker setDate:[NSDate date]];
//    datePicker.datePickerMode = UIDatePickerModeDate;
//    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
//    [_datepickertxt setInputView:datePicker];
//  
//}
//
//-(void) dateTextField:(id)sender
//{
//    UIDatePicker *picker = (UIDatePicker*)_datepickertxt.inputView;
//    [picker setMaximumDate:[NSDate date]];
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    NSDate *eventDate = picker.date;
//    [dateFormat setDateFormat:@"dd-MM-yyyy"];
//    NSString *dateString = [dateFormat stringFromDate:eventDate];
//    _datepickertxt.text = [NSString stringWithFormat:@"%@"dateString];
//
//}
//

- (void)didRecognizeTapGesture:(UITapGestureRecognizer*)gesture
{
    CGPoint point = [gesture locationInView:gesture.view];
    
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        _datepickertxt.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datePicker.date]];
        _datePicker.hidden = false;
        _toolbar.hidden = false;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
   //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isFilter)
    {
        return [searchArray count];
    }
    else
    {
        return  [arrOfColor count];
    }
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
    
     _tabledata.hidden = YES;
    _tableborder.hidden = YES;
 
    if (txtenable == 1)
    {
        _From.text=[arrOfColor objectAtIndex:indexPath.row];
    }
    else
    {
        _To.text=[arrOfColor objectAtIndex:indexPath.row];
    }
    
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    [self.view endEditing:YES];
    _tabledata.hidden = NO;
    _tableborder.hidden = NO;
}


-(void)textFieldDidChange_From:(UITextField *)textField
{
    txtenable = 1;
    if ([textField.text isEqualToString:@""])
    {
        _tabledata.hidden = YES;
        _tableborder.hidden = YES;
    }
    else
    {
        _tabledata.hidden = NO;
        _tableborder.hidden = NO;
    }
    
    searchTextString=textField.text;
    arrOfColor=[[NSMutableArray alloc]init];
    arrOfColor = [httpws getGooglePlace:searchTextString];
    [self.tabledata reloadData];
}
-(void)textFieldDidChange_To:(UITextField *)textField
{
    txtenable = 2;
    if ([textField.text isEqualToString:@""])
    {
        _tabledata.hidden = YES;
        _tableborder.hidden = YES;
    }
    else
    {
        _tabledata.hidden = NO;
        _tableborder.hidden = NO;
    }
    searchTextString=textField.text;
    arrOfColor=[[NSMutableArray alloc]init];
    arrOfColor = [httpws getGooglePlace:searchTextString];
    [self.tabledata reloadData];

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
        [self.tabledata reloadData];
       
    }
}

- (IBAction)canclebtn:(id)sender
{
    _datePicker.hidden = true;
    _toolbar.hidden = true;
    _datepickertxt.text = @"";
}

- (IBAction)Donebtn:(id)sender
{
    _datePicker.hidden = true;
    _toolbar.hidden = true;
    
}
- (IBAction)datePickerChanged:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    _datepickertxt.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datePicker.date]];
}

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    return NO;
//}
//

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
- (IBAction)searchbtn:(id)sender
{
//    from = _From.text;
//    to = _To.text;
//    date = _datepickertxt.text;
    
//    setdic=[[NSMutableDictionary alloc]init];
//    
//    [setdic setObject:from forKey:@"from_address"];
//    [setdic setObject:to forKey:@"to_address"];
//    [setdic setObject:date forKey:@"start_time"];
    
    HireSearch_ViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"HireSearch_ViewController"];
    
    tab.Fromsearch = _From.text;
    tab.Tosearch = _To.text;
    tab.Datesearch = _datepickertxt.text;
    
    
    [self.navigationController pushViewController:tab animated:YES];
}


@end
