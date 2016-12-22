//
//  AppMethod.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/3/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "AppMethod.h"
#import "Reachability.h"
#import <UIKit/UIKit.h>

@implementation AppMethod

+(void)setStringDefault:(NSString *)key :(NSString *)value
{
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
+(NSString*)getStringDefault:(NSString *)key
{
    NSString *value=[[NSUserDefaults standardUserDefaults]stringForKey:key];
    return value;
}


//for address
+(NSString *)convertHTML:(NSString *)html
{
    
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        
        [myScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@"\n"];
    }
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}


+(void)setArrayDefault:(NSMutableArray *)key :(NSMutableArray *)value
{
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+(NSMutableArray*)getArrayDefault:(NSMutableArray *)key
{
    NSMutableArray *value = [[NSUserDefaults standardUserDefaults]arrayForKey:key];
    return value;
}

+(NSInteger)Check_Internet;
{
    Reachability *IsReachable = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStats = [IsReachable currentReachabilityStatus];
    
    if (internetStats == NotReachable)
    {
        return 0;
    }
    else
    {
        return 1;
    }
}
+(NSString*)Parse_jsonToString:(NSDictionary*)Data
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:Data
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
+(NSDictionary *)Parse_StringJson:(NSString *)Jsonstring
{
    //NSString *json = [AppMethod getStringDefault:@"default_adon"];
    
    NSError *error;
    NSData *data = [Jsonstring dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *adondata = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return adondata;
}



+(NSDate *)getDateFromString:(NSString *)dateFormate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormate];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}
+(NSString *)getDateInFormate:(NSDate *)date:(NSString *)requiredFormate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:requiredFormate];
    NSString *newDateString = [dateFormatter stringFromDate:date];
    return newDateString;
}


@end
