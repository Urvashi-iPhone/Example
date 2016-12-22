//
//  FinanceViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 8/24/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "FinanceViewController.h"
#import "httpws.h"
#import "AppMethod.h"
#import "Constant.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "Vehicle_Type_Capacity_New_TableViewCell.h"

@interface FinanceViewController ()

@end

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
@implementation FinanceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlview.contentSize = contentRect.size;
    
    _viewborder1.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];

    _viewborder1.layer.borderWidth= 1.0f;
    _viewborder1.layer.cornerRadius = 15.0;
    _submitbtn.layer.cornerRadius = 17.0;
    
    _Add1.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _Add1.layer.borderWidth = 1.0f;
    _Add1.layer.cornerRadius = 5;
    
    _Add2.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _Add2.layer.borderWidth = 1.0f;
    _Add2.layer.cornerRadius = 5;
    
    _Comment.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _Comment.layer.borderWidth = 1.0f;
    _Comment.layer.cornerRadius = 5;
    
 
    _financetbl.hidden = YES;
    financearr=[[NSMutableArray alloc]initWithObjects:@"Public Finance",@"Private Finance",@"Personal Finance",@"Corporate Finance",nil];
//    _Add1.delegate = self;
//    _Add1.text = @"Address Line1";
//  _Add1.textColor = [UIColor lightGrayColor];
//
//    _Add2.delegate = self;
//    _Add2.text = @"Address Line2";
//    _Add2.textColor = [UIColor lightGrayColor];
//    
//    _Comment.delegate = self;
//    _Comment.text = @"Comment";
//    _Comment.textColor = [UIColor lightGrayColor];
    _FinanceType.enabled = NO;
    
    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    adondata = [[NSDictionary alloc]init];
    citytyp = [[NSMutableArray alloc]init];
     [self Get_Adondata];
     city = @"";
    
    [self Validation_Delegate];
    [self setupAlerts];

    
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    CGFloat navBarHeight = 55;
//    
//    [[UINavigationBar appearance]setFrame:CGRectMake(0, 0,self.view.frame.size.width, navBarHeight)];
// 
//}
-(void)Validation_Delegate
{
    _name.delegate=self;
    _Email.delegate=self;
    _FinanceType.delegate=self;
    _RequiredAmt.delegate=self;
    _add1txt.delegate = self;
    _add2txt.delegate = self;
    _commenttxt.delegate = self;
    
    _name.presentInView=self.view;
    _Email.presentInView=self.view;
    _FinanceType.presentInView=self.view;
    _RequiredAmt.presentInView=self.view;
    _add1txt.presentInView=self.view;
    _add2txt.presentInView=self.view;
    _commenttxt.presentInView = self.view;
}
-(void)setupAlerts
{
    [_name addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Name can not be blank."];
    
    [_Email addRegx:REGEX_EMAIL withMsg:@"Enter valid email"];
    
    [_FinanceType addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Insurance Type can not be blank."];
    
    [_RequiredAmt addRegx:REGEX_FLOAT withMsg:@"Required Amount can not be blank."];
    
    [_add1txt addRegx:REGEX_TEXTVIEW withMsg:@"Address1 can not be blank."];
    
    [_add2txt addRegx:REGEX_TEXTVIEW withMsg:@"Address2 can not be blank."];
    
    [_commenttxt addRegx:REGEX_TEXTVIEW withMsg:@"Comment can not be blank."];
    

}

-(void)Get_Adondata
{
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
    adondata = [dic valueForKey:@"data"];
    
    [self jsonparsing_cityType];
    _city_table.hidden = YES;
    
}
-(void)jsonparsing_cityType
{
    
    citytypdata=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"city"]copyItems:YES];
    
    for (int i=0; i<[citytypdata count];i++)
    {
        NSDictionary *dic12 = [citytypdata objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [citytyp addObject:str1];
    }
    [_city_table reloadData];
}
-(void)textFieldDidChange:(UITextField *)textField
{
     if (textField == _City)
    {
        _city_table.hidden = NO;
        
        [self.city_table reloadData];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   if(tableView==_city_table)
    {
        return [citytyp count];
    }
   else
   {
       return [financearr count];
   }
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_city_table)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
        }
        cell.citylbl_finance.text = [citytyp objectAtIndex:indexPath.row];
        return cell;
        
    }
    else
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:table];
            
        }
        
        
        cell.fianancLbl.text = [financearr objectAtIndex:indexPath.row];
        
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_city_table)
    {
        _City.text=[citytyp objectAtIndex:indexPath.row];
        city= [[[adondata valueForKey:@"city"]objectAtIndex:indexPath.row] valueForKey:@"value"];
        _city_table.hidden = YES;
    }
    else
    {
    _FinanceType.text=[financearr objectAtIndex:indexPath.row];
    _financetbl.hidden = YES;
    }
    
}

//- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
//{
//    if (textView == _Add1)
//    {
//        _Add1.text = @"";
//        _Add1.textColor = [UIColor blackColor];
//        return YES;
//
//    }
//    else if (textView == _Add2)
//    {
//    _Add2.text = @"";
//    _Add2.textColor = [UIColor blackColor];
//    return YES;
//    }
//    else
//    {
//        _Comment.text = @"";
//        _Comment.textColor = [UIColor blackColor];
//        return YES;
//    }
//    return nil;
//}
//
//-(void) textViewDidChange:(UITextView *)textView
//{
//    if (textView == _Add1)
//    {
//        if(_Add1.text.length == 0)
//        {
//            _Add1.textColor = [UIColor lightGrayColor];
//            _Add1.text = @"Address Line1";
//            [_Add1 resignFirstResponder];
//        }
//
//    }
//    else if (textView == _Add2)
//    {
//        if(_Add2.text.length == 0)
//        {
//            _Add2.textColor = [UIColor lightGrayColor];
//            _Add2.text = @"Address Line2";
//            [_Add2 resignFirstResponder];
//        }
// 
//    }
//    else
//    {
//    if(_Comment.text.length == 0)
//    {
//        _Comment.textColor = [UIColor lightGrayColor];
//        _Comment.text = @"Comment";
//        [_Comment resignFirstResponder];
//    }
//    }
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)submitbtn:(id)sender
{
    
    name=_name.text;
    c_name=_CompanyName.text;
    email=_Email.text;
    mobile=_Mobile.text;
    landline=_Landline.text;
    fin_type=_FinanceType.text;
    address1=_Add1.text;
    address2=_Add2.text;
    req_amount=_RequiredAmt.text;
    city=_City.text;
    comme=_Comment.text;
    
    _add1txt.hidden = false;
    _add1txt.text = _Add1.text;
    
    _add2txt.hidden = false;
    _add2txt.text = _Add2.text;
    
    _commenttxt.hidden = false;
    _commenttxt.text = _Comment.text;
	
    if([_name validate] & [_Email validate] & [_FinanceType validate] & [_RequiredAmt validate] & [_add1txt validate] & [_add2txt validate] & [_commenttxt validate])
    {
        

		 setdic=[[NSMutableDictionary alloc]init];
		[setdic setObject:name forKey:@"name"];
		[setdic setObject:c_name forKey:@"company_name"];
		[setdic setObject:email forKey:@"email"];
		[setdic setObject:mobile forKey:@"mobile"];
		[setdic setObject:landline forKey:@"landline"];
		[setdic setObject:fin_type forKey:@"finance_type"];
		[setdic setObject:address1 forKey:@"addressline1"];
		[setdic setObject:address2 forKey:@"addressline2"];
		[setdic setObject:req_amount forKey:@"required_amount"];
		[setdic setObject:city forKey:@"city"];
		[setdic setObject:comme forKey:@"comment"];
        
        if ([city isEqualToString:@""])
        {
            [setdic setObject:[[[adondata valueForKey:@"city"]objectAtIndex:0] valueForKey:@"value"] forKey:@"city"];
        }
        else
        {
            [setdic setObject:city forKey:@"city"];
        }
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [ProgressHUD show:@"Please wait..."];

       
        [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
        [manager POST:[baseurl stringByAppendingString:Financeurl] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
         
         {
		
		BOOL boolean=[[dic12 valueForKey:@"status"]boolValue];
             
		if(boolean)
		{
			UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[dic12 valueForKey:@"message"]delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
			[alt show];

		}
        [ProgressHUD dismiss];
         }
        failure:^(NSURLSessionTask *operation, NSError *error)
         {
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
             [al show];
              [ProgressHUD dismiss];
         }];

	}
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        SWRevealViewController *inq = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        [self.navigationController pushViewController:inq animated:YES];
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
    
    UITextField *add1 = (UITextField *)textField;
    
    
    if (add1.tag == 1)
    {
        _add1txt.hidden = YES;
        [_Add1 becomeFirstResponder];
    }
    else if (add1.tag == 2)
    {
        _add2txt.hidden = YES;
        [_Add2 becomeFirstResponder];
    }
    else if (add1.tag == 3)
    {
        _commenttxt.hidden = YES;
        [_Comment becomeFirstResponder];
    }

    
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


- (IBAction)dropdown_financTyp:(id)sender
{
    _financetbl.hidden = NO;

}
- (IBAction)dropdown_city:(id)sender
{
    _city_table.hidden = NO;
}
@end
