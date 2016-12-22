//
//  Buy_Parts_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/29/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "Buy_Parts_ViewController.h"
#import "SWRevealViewController.h"
#import "BuyPartsSearch_ViewController.h"
#import "AppMethod.h"
#import "Vehicle_Type_Capacity_New_TableViewCell.h"
@interface Buy_Parts_ViewController ()

@end
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
@implementation Buy_Parts_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // [[UINavigationBar appearance]setFrame:CGRectMake(0, 0,self.view.frame.size.width, 60)];
    _searchbtn.layer.cornerRadius = 19.0;
  [self Tabbar_SwipeGesture];
     parttype = @"";
    parttyp = [[NSMutableArray alloc]init];
     [self Get_adondata];
    // Do any additional setup after loading the view.
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
    // [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [_r1 setTag:0];
    [_r1 setBackgroundImage:[UIImage imageNamed:@"radio.png"] forState:UIControlStateNormal];
    [_r1 setBackgroundImage:[UIImage imageNamed:@"radio-checked.png"] forState:UIControlStateSelected];
    [_r1 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [_r2 setTag:1];
    [_r2 setBackgroundImage:[UIImage imageNamed:@"radio.png"] forState:UIControlStateNormal];
    [_r2 setBackgroundImage:[UIImage imageNamed:@"radio-checked.png"] forState:UIControlStateSelected];
    [_r2 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)Get_adondata
{
    
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
    adon_dic = [dic valueForKey:@"data"];
    
    [self jsonparsing_PartType];
    _table_parttype.hidden = YES;
}
-(void)jsonparsing_PartType
{
    
    parttypdata=[[NSMutableArray alloc] initWithArray:[adon_dic objectForKey:@"parts_type"]copyItems:YES];
    
    for (int i=0; i<[parttypdata count];i++)
    {
        NSDictionary *dic12 = [parttypdata objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [parttyp addObject:str1];
    }
    [_table_parttype reloadData];
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
    
//    CATransition *anim= [CATransition animation];
//    [anim setType:kCATransitionPush];
//    [anim setSubtype:kCATransitionFromRight];
//    [anim setDuration:0.4];
//    [anim setTimingFunction:[CAMediaTimingFunction functionWithName:
//                             kCAMediaTimingFunctionEaseIn]];
//    [self.tabBarController.view.layer addAnimation:anim forKey:@"fadeTransition"];
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


- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == _parttype)
    {
        _table_parttype.hidden = NO;
        
        [self.table_parttype reloadData];
        
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
         return [parttyp count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
        }
        cell.partlbl_buypart.text = [parttyp objectAtIndex:indexPath.row];
        return cell;
        

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _parttype.text=[parttyp objectAtIndex:indexPath.row];
    parttype= [[[adon_dic valueForKey:@"parts_type"]objectAtIndex:indexPath.row] valueForKey:@"id"];
    _table_parttype.hidden = YES;
    
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
- (IBAction)dropdown_partTyp:(id)sender
{
   _table_parttype.hidden = NO; 
}

- (IBAction)Searchbtn:(id)sender
{
    
    BuyPartsSearch_ViewController *parts = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyPartsSearch_ViewController"];
    parts.parttypsearch = _parttype.text;
    parts.keywordsearch = _keyword.text;
    parts.manufacturesearch = _manufacture.text;
    parts.yearmanufacturesearch = _year_manufacture.text;
    parts.vehiclemodelpsearch = _vehicle_model.text;
    if([_r1 isSelected]==YES)
    {
        
        parts.type = @"1";
    }
    else{
        parts.type = @"2";
    }

    [self.navigationController pushViewController:parts animated:YES];
}
@end
