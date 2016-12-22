//
//  Sell_AutoParts_ViewController.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/10/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "Sell_AutoParts_ViewController.h"
#import "SWRevealViewController.h"
#import "httpws.h"
#import "Constant.h"
#import "AppMethod.h"
#import "Sell_AutoParts_TableViewCell.h"
#import "Vehicle_Type_Capacity_New_TableViewCell.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "httpws.h"

@interface Sell_AutoParts_ViewController ()

@end
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@implementation Sell_AutoParts_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlview.contentSize = contentRect.size;
    
    
    _viewGallary.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];
    _viewGallary.layer.borderWidth= 1.0f;
    _viewGallary.layer.cornerRadius = 15.0;
    _camerabtn.layer.cornerRadius = 17.0;
    _galarybtn.layer.cornerRadius = 17.0;

    
    
    _border1.layer.borderColor = [[UIColor colorWithRed:203/255.0f green:65/255.0f blue:80/255.0f alpha:1.0f]CGColor];

    _border1.layer.borderWidth= 1.0f;
    _border1.layer.cornerRadius = 15.0;
    
      _border2.layer.borderColor = [[UIColor colorWithRed:252/255.0f green:176/255.0f blue:66/255.0f alpha:1.0f]CGColor];
    _border2.layer.borderWidth= 1.0f;
    _border2.layer.cornerRadius = 15.0;
      _imagelist = [[NSMutableArray alloc]init];
     _createbtn.layer.cornerRadius = 19.0;
     _Addimage.layer.cornerRadius = 19.0;
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
     adondata = [[NSDictionary alloc]init];
     brandtyp = [[NSMutableArray alloc]init];
    citytyp = [[NSMutableArray alloc]init];
     parttyp = [[NSMutableArray alloc]init];
      [self Get_Adondata];
      brand = @"";
     city = @"";
     parts_type = @"";
    _isnew_tabledata.hidden = YES;
    isNewtyp=[[NSArray alloc]initWithObjects:@"New",@"Old",nil];
    
    _status_tabledata.hidden = YES;
    statustyp=[[NSArray alloc]initWithObjects:@"Active",@"Inactive",nil];

    _viewGallary.hidden = YES;
    [self setupAlerts];
    [self Validation_Delegate];
    
    _PartsType.enabled = NO;
    _City.enabled = NO;
    _Brand.enabled =NO;
    
}
-(void)Validation_Delegate
{
    _Fname.delegate=self;
    _Fname.presentInView=self.view;
    
    _Lname.delegate=self;
    _Lname.presentInView=self.view;
    
    _Name.delegate=self;
    _Name.presentInView=self.view;
    
    _Email.delegate=self;
    _Email.presentInView=self.view;
    
    _Brand.delegate=self;
    _Brand.presentInView=self.view;
    
    _City.delegate=self;
    _City.presentInView=self.view;
    
    _PartsType.delegate=self;
    _PartsType.presentInView=self.view;
    
    _Manufacture.delegate=self;
    _Manufacture.presentInView=self.view;
    
    _VehicleModel.delegate=self;
    _VehicleModel.presentInView=self.view;
    
    _ModelNo.delegate=self;
    _ModelNo.presentInView=self.view;
    
    _Price.delegate=self;
    _Price.presentInView=self.view;
    
    _PartsDetail.delegate=self;
    _PartsDetail.presentInView=self.view;
    
    _Length.delegate=self;
    _Length.presentInView=self.view;
    
    _Width.delegate=self;
    _Width.presentInView=self.view;
    
    _height.delegate=self;
    _height.presentInView=self.view;
    
    _weight.delegate=self;
    _weight.presentInView=self.view;
    
}
-(void)setupAlerts
{
    
    [_Fname addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Firstname can not be blank."];
    
    [_Lname addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Lastname can not be blank."];
    
    [_Name addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Name can not be blank."];
    
    [_Email addRegx:REGEX_EMAIL withMsg:@"Enter valid email"];
    
    [_Brand addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Brand can not be blank."];
    
     [_City addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"City can not be blank."];
    
     [_PartsType addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Part Type can not be blank."];
    
    [_Manufacture addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Manufacture can not be blank."];
    
    [_VehicleModel addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Vehicle Model can not be blank."];
    
    [_ModelNo addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Model Number can not be blank."];
    
    [_Price addRegx:REGEX_FLOAT withMsg:@"Price can not be blank."];
    
    [_PartsDetail addRegx:REGEX_TEXTFIELD_LIMIT withMsg:@"Parts Details can not be blank."];
    
    [_Length addRegx:REGEX_FLOAT withMsg:@"Length can not be blank."];
    
    [_Width addRegx:REGEX_FLOAT withMsg:@"Width can not be blank."];
    
    [_height addRegx:REGEX_FLOAT withMsg:@"Height can not be blank."];
    
    [_weight addRegx:REGEX_FLOAT withMsg:@"Weight can not be blank."];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)Get_Adondata
{
    NSDictionary *dic = [AppMethod Parse_StringJson:[AppMethod getStringDefault:@"default_adon"]];
    adondata = [dic valueForKey:@"data"];
    
    [self jsonparsing_BrandType];
    _table_brand.hidden = YES;
    
    [self jsonparsing_cityType];
    _city_table.hidden = YES;
    
    [self jsonparsing_PartType];
    _table_parttype.hidden = YES;
    
}

-(void)jsonparsing_PartType
{
    
    parttypdata=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"parts_type"]copyItems:YES];
    
    for (int i=0; i<[parttypdata count];i++)
    {
        NSDictionary *dic12 = [parttypdata objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [parttyp addObject:str1];
    }
    [_table_parttype reloadData];
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
-(void)jsonparsing_BrandType
{
    
    brandtypedata=[[NSMutableArray alloc] initWithArray:[adondata objectForKey:@"dealer_brand"]copyItems:YES];
    
    for (int i=0; i<[brandtypedata count];i++)
    {
        NSDictionary *dic12 = [brandtypedata objectAtIndex:i];
        NSString *str1 = [dic12 objectForKey:@"value"];
        
        [brandtyp addObject:str1];
    }
    [_table_brand reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _table_parts)
    {
        return _imagelist.count;
    }
    else if(tableView==_status_tabledata)
    {
        return [statustyp count];
    }
    else if (tableView == _table_brand)
    {
        return [brandtyp count];
    }
    else if(tableView==_city_table)
    {
        return [citytyp count];
    }
    else if (tableView==_table_parttype)
    {
        return [parttyp count];
    }
    else
    {
        return [isNewtyp count];
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _table_parts)
    {
        
        static NSString *table = @"cell12";
        Sell_AutoParts_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        
        cell.delete.tag=indexPath.row;
        cell.TakeImagebtn.tag = indexPath.row;
        cell.partsimg.image=[_imagelist objectAtIndex:indexPath.row];
        
        [cell.delete addTarget:self action:@selector(myDeleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.TakeImagebtn addTarget:self action:@selector(myCellButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
    }
    else if (tableView == _isnew_tabledata)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        
        cell.isnewlbl_autopart.text = [isNewtyp objectAtIndex:indexPath.row];
        return cell;
    }
    else if (tableView==_city_table)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
        }
        cell.citylbl_autoparts.text = [citytyp objectAtIndex:indexPath.row];
        return cell;
        
    }
    else if (tableView==_table_parttype)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
        }
        cell.partlbl_autoparts.text = [parttyp objectAtIndex:indexPath.row];
        
        return cell;
        
    }

    else if (tableView == _status_tabledata)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
            
        }
        
        cell.statuslbl_autopart.text = [statustyp objectAtIndex:indexPath.row];
        return cell;
    }
    else if (tableView==_table_brand)
    {
        static NSString *table = @"cell1";
        
        Vehicle_Type_Capacity_New_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table];
        //ipad tablview clear color
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
            
        }
        cell.brandtyp_parts.text = [brandtyp objectAtIndex:indexPath.row];
        
        return cell;
        
    }
    
    return nil;
    
}
-(void)myCellButtonPressed:(UIButton *)sender
{
    
    _viewGallary.hidden = NO;
    UIButton *senderButton = (UIButton *)sender;
    _vehicleimg_position = senderButton.tag;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _isnew_tabledata)
    {
        _IsNew.text=[isNewtyp objectAtIndex:indexPath.row];
        _isnew_tabledata.hidden = YES;
    }
    else if (tableView==_table_brand)
    {
        _Brand.text=[brandtyp objectAtIndex:indexPath.row];
        brand= [[[adondata valueForKey:@"dealer_brand"]objectAtIndex:indexPath.row] valueForKey:@"value"];
        _table_brand.hidden = YES;
    }
    else if (tableView==_city_table)
    {
        _City.text=[citytyp objectAtIndex:indexPath.row];
        city= [[[adondata valueForKey:@"city"]objectAtIndex:indexPath.row] valueForKey:@"value"];
        _city_table.hidden = YES;
    }
    else if (tableView==_table_parttype)
    {
        _PartsType.text=[parttyp objectAtIndex:indexPath.row];
        parts_type= [[[adondata valueForKey:@"parts_type"]objectAtIndex:indexPath.row] valueForKey:@"id"];
        _table_parttype.hidden = YES;
    }
    else
    {
        _Status.text=[statustyp objectAtIndex:indexPath.row];
        _status_tabledata.hidden = YES;
    }
    
}

-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == _IsNew)
    {
        _isnew_tabledata.hidden = NO;
        
        [self.isnew_tabledata reloadData];
        
    }
    else if (textField == _Brand)
    {
        _table_brand.hidden = NO;
        
        [self.table_brand reloadData];
    }
    else if (textField == _City)
    {
        _city_table.hidden = NO;
        
        [self.city_table reloadData];
    }
    else if (textField == _PartsType)
    {
        _table_parttype.hidden = NO;
        
        [self.table_parttype reloadData];
        
    }
    else
    {
        _status_tabledata.hidden = NO;
        
        [self.status_tabledata reloadData];
    }
}
-(void)myDeleteButtonPressed:(UIButton *)sender
{
    UIButton *senderButton = (UIButton *)sender;
    [_imagelist removeObjectAtIndex:senderButton.tag];
    [_table_parts reloadData];
    // [self setTableViewheightOfTable:_table_parts ByArrayName:_imagelist];
}

- (IBAction)AddImageList:(id)sender
{
    [_imagelist addObject:[UIImage imageNamed:@"app_icon.png"]];
    [_table_parts reloadData];
    //  [self setTableViewheightOfTable:_table_parts ByArrayName:_imagelist];
    
}

- (IBAction)dropdoen_isnew:(id)sender
{
    _isnew_tabledata.hidden = NO;
}


- (IBAction)dropdown_status:(id)sender
{
    _status_tabledata.hidden = NO;
}



- (IBAction)createbtn:(id)sender
{
    c_name=_CompanyName.text;
    fname=_Fname.text;
    lname=_Lname.text;
    email=_Email.text;
    mobile=_Mobile.text;
    name=_Name.text;
    manufacture=_Manufacture.text;
    brand=_Brand.text;
    city=_City.text;
    parts_type=_PartsType.text;
    vehi_model=_VehicleModel.text;
    manufacture_year=_Manufacture_year.text;
    model_number=_ModelNo.text;
    price=_Price.text;
    parts_details=_PartsDetail.text;
    length=_Length.text;
    width=_Width.text;
    height=_height.text;
    weight=_weight.text;
    is_new=_IsNew.text;
    status=_Status.text;
    
    
    if([_Fname validate] & [_Lname validate] & [_Email validate] & [_Name validate] & [_Brand validate] &  [_VehicleModel validate] & [_ModelNo validate] & [_Price validate] & [_PartsDetail validate] & [_Length validate] & [_Width validate] & [_height validate] & [_weight validate])
    {
    
        if (!_termConditionCheck)
        {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:@"You must accept our term and condition!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [al show];
            return;
        }
        else
        {
            isTermAc = @"1";
        }
  
        setdic=[[NSMutableDictionary alloc]init];
        [setdic setObject:[AppMethod getStringDefault:@"default_id"] forKey:@"user_id"];
        [setdic setObject:c_name forKey:@"company_name"];
        [setdic setObject:fname forKey:@"firstname"];
        [setdic setObject:lname forKey:@"lastname"];
        [setdic setObject:email forKey:@"email"];
        [setdic setObject:mobile forKey:@"mobile"];
        [setdic setObject:name forKey:@"name"];
        [setdic setObject:manufacture forKey:@"manufacturer"];
        if ([brand isEqualToString:@""])
        {
            [setdic setObject:[[[adondata valueForKey:@"dealer_brand"]objectAtIndex:0] valueForKey:@"value"] forKey:@"brand"];
        }
        else
        {
            [setdic setObject:brand forKey:@"brand"];
        }
        if ([city isEqualToString:@""])
        {
            [setdic setObject:[[[adondata valueForKey:@"city"]objectAtIndex:0] valueForKey:@"value"] forKey:@"city"];
        }
        else
        {
            [setdic setObject:city forKey:@"city"];
        }
        if ([parts_type isEqualToString:@""])
        {
            [setdic setObject:[[[adondata valueForKey:@"parts_type"]objectAtIndex:0] valueForKey:@"value"] forKey:@"parts_type"];
        }
        else
        {
            [setdic setObject:brand forKey:@"brand"];
        }
        //[setdic setObject:parts_type forKey:@"parts_type"];
        [setdic setObject:vehi_model forKey:@"vehicle_model"];
        [setdic setObject:manufacture_year forKey:@"year_of_manufacture"];
        [setdic setObject:model_number forKey:@"model_no"];
        [setdic setObject:price forKey:@"price"];
        [setdic setObject:parts_details forKey:@"parts_detail"];
        [setdic setObject:length forKey:@"lenght"];
        [setdic setObject:width forKey:@"width"];
        [setdic setObject:height forKey:@"height"];
        [setdic setObject:weight forKey:@"weight"];
        [setdic setObject:isTermAc forKey:@"terms_condition"];
        
    
    NSMutableArray *imaglist = [[NSMutableArray alloc]init];
        
        if ([_imagelist count]>0)
        {
            for (int i = 0; i<[_imagelist count]; i++)
            {
                [imaglist addObject:[self imageToNSString:[_imagelist objectAtIndex:i]]];
            }
        }
        else
        {
            
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Add Minimum 1 Image." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [al show];
            return;
        }

   
    [setdic setObject:imaglist forKey:@"image"];

        if ([is_new isEqualToString:@"New"])
        {
            [setdic setObject:@"1" forKey:@"is_new"];
        }
        else
        {
            [setdic setObject:@"0" forKey:@"is_new"];
        }
        
        if ([status isEqualToString:@"Active"])
        {
            [setdic setObject:@"1" forKey:@"status"];
        }
        else
        {
            [setdic setObject:@"0" forKey:@"status"];
        }

        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [ProgressHUD show:@"Please wait..."];
        
        [manager.requestSerializer setValue:[AppMethod getStringDefault:@"default_access_token"] forHTTPHeaderField:@"TeckskyAuth"];
        
        NSString *tripurl= [baseurl stringByAppendingString:SellPartsurl];

        NSLog(@"%@",tripurl);
        
        [manager POST:tripurl parameters:setdic progress:nil success:^(NSURLSessionTask *task, id sellpart)
         
         {
              [ProgressHUD dismiss];
             BOOL boolean = [[sellpart valueForKey:@"status"] boolValue];
             if (boolean)
             {
                 UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:[sellpart valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                 al.tag = 1;
                 [al show];
             }
             else
             {
                 UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Success" message:[sellpart valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                 al.tag = 2;
                 [al show];
                 
             }
             

         }failure:^(NSURLSessionTask *operation, NSError *error)
         {
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Runmile" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
             [al show];
             [ProgressHUD dismiss];
         }];

        
  }
}

- (NSString *)imageToNSString:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {

        if (buttonIndex == 0)
        {
            SWRevealViewController *inq = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
            [self.navigationController pushViewController:inq animated:YES];
        }
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

- (IBAction)galarybtn:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    _viewGallary.hidden = YES;
}

- (IBAction)camerabtn:(id)sender
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    _viewGallary.hidden = YES;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    [_imagelist replaceObjectAtIndex:_vehicleimg_position withObject:chosenImage];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [_table_parts reloadData];
    
    
}
- (IBAction)closebtn:(id)sender
{
     _viewGallary.hidden = YES;
}

- (IBAction)uncheckbtn:(id)sender
{
  [_uncheckbtn addTarget:self action:@selector(ChkUnChk_TermCondition:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)ChkUnChk_TermCondition:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
    if (_termConditionCheck)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"uncheck.png"]forState:UIControlStateNormal];
        
        _termConditionCheck = NO;
        
    }
    else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"check.png"]forState:UIControlStateNormal];
        _termConditionCheck = YES;
    }
}

- (IBAction)dropdown_brand:(id)sender
{
    _table_brand.hidden = NO;
}

- (IBAction)dropdown_city:(id)sender;
{
    _city_table.hidden = NO;
}

- (IBAction)dropdown_parttype:(id)sender
{
    
        _table_parttype.hidden = NO;

}
@end