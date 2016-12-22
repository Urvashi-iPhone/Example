//
//  httpws.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/2/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "httpws.h"
#import "AppMethod.h"
#import <UIKit/UIKit.h>
#import <AFNetworking.h>

@implementation httpws

+(NSMutableArray*)getGooglePlace:(NSString *)searchTerm
{
    NSMutableArray *placelist=[[NSMutableArray alloc]init];
    
    searchTerm = [searchTerm stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    
    NSString *str1 = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=geocode&sensor=false&key=AIzaSyBEQouslAJ77Ybd-zGhfsIdNE21igskgU4" , searchTerm];
    
    NSURL *url1 = [NSURL URLWithString:str1];
    
    NSData *jsondata = [NSData dataWithContentsOfURL:url1];
    
    NSError *error;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsondata options:kNilOptions error:&error];
    
    
    NSMutableArray *predictions = [dic valueForKey:@"predictions"];
    for (int i=0; i<[predictions count]; i++)
    {
        NSDictionary *place = [predictions objectAtIndex:i];
        [placelist addObject:[place valueForKey:@"description"]];
    }
    return placelist;
}
/*

+(NSDictionary*)httpGet:(NSString *)url
{
//    __block NSDictionary *dic = [[NSDictionary alloc]init];
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task , id responseobject)
//     {
//         dic = responseobject;
//     }failure:^(NSURLSessionTask *operation, NSError *error){
//         dic = [NSDictionary dictionaryWithObjectsAndKeys:@"false",@"status",[error localizedDescription],@"message", nil];
//     }];
//
    
    if ([AppMethod Check_Internet]>0)
    {
        NSURL *url1 = [NSURL URLWithString:url];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        NSData *jsondata = [NSData dataWithContentsOfURL:url1];
        
        NSError *error;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsondata options:kNilOptions error:&error];
        
        if (dic != nil)
        {
            if ([dic objectForKey:@"status"])
            {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                return dic;
            }
            else
            {
                NSDictionary *errDic = [NSDictionary dictionaryWithObjectsAndKeys:@"false",@"status",@"Response Error",@"message", nil];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                return errDic;
            }
        }
        else
        {
            NSDictionary *errDic = [NSDictionary dictionaryWithObjectsAndKeys:@"false",@"status",@"Error",@"message", nil];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

            return errDic;
        }
        
    }
    else
    {
        NSDictionary *errDic = [NSDictionary dictionaryWithObjectsAndKeys:@"false",@"status",@"No Internet Connection",@"message", nil];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        return errDic;
    }
    //  return dic;
}
*/
+(NSDictionary*)httpPost:(NSString *)url :(NSDictionary *)jsondata
{
//    __block NSDictionary *dic = [[NSDictionary alloc]init];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    [manager.requestSerializer setValue:@"AHCR93YyMewtASDdhWMwDaFHO0o0RH4IdfPT-Nc2" forHTTPHeaderField:@"TeckskyAuth"];
//    
//    [manager POST:url parameters:jsondata progress:nil success:^(NSURLSessionTask *task, id responseObject)
//     {
//        dic = responseObject;
//        
//     } failure:^(NSURLSessionTask *operation, NSError *error)
//    {
//         dic = [NSDictionary dictionaryWithObjectsAndKeys:@"false",@"status",[error localizedDescription],@"message", nil];
//    }];
// 
//    
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSError *error2;
    
    NSData *jsondata2 = [NSJSONSerialization dataWithJSONObject:jsondata options:NSJSONWritingPrettyPrinted error:&error2];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [jsondata2 length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    [request setHTTPBody:jsondata2];
    
    NSURLResponse *response;
    
    NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSMutableDictionary *dic12 = [NSJSONSerialization JSONObjectWithData:POSTReply options:0 error:nil];
   // [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    return dic12;

}


+(NSDictionary*)httpPostWithauth:(NSString *)url :(NSDictionary *)jsondata :(NSString *)authstring
{
    
    //__block NSDictionary *dic = nil;
//     __block NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager.requestSerializer setValue:authstring forHTTPHeaderField:@"TeckskyAuth"];
//    
//    [manager POST:url parameters:jsondata progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        dic = responseObject;
//        //NSLog(@"JSON: %@", [response valueForKey:@"message"]);
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        dic = [NSDictionary dictionaryWithObjectsAndKeys:@"false",@"status",[error localizedDescription],@"message", nil];
//    }];
//
 //   [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSError *error2;
    
    NSData *jsondata2 = [NSJSONSerialization dataWithJSONObject:jsondata options:NSJSONWritingPrettyPrinted error:&error2];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [jsondata2 length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:authstring forHTTPHeaderField:@"TeckskyAuth"];
    
    
    [request setHTTPBody:jsondata2];
    
    NSURLResponse *response;
    
    NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSMutableDictionary *dic12 = [NSJSONSerialization JSONObjectWithData:POSTReply options:0 error:nil];
 //   [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    return dic12;
}
+(NSDictionary*)httpPutWithauth:(NSString *)url :(NSDictionary *)jsondata :(NSString *)authstring
{
    
//    __block NSDictionary *dic = [[NSDictionary alloc]init];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager PUT:url parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
//        dic = responseObject;
//        //NSLog(@"JSON: %@", [response valueForKey:@"message"]);
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        dic = [NSDictionary dictionaryWithObjectsAndKeys:@"false",@"status",[error localizedDescription],@"message", nil];
//    }];


    NSError *error2;
    
    NSData *jsondata2 = [NSJSONSerialization dataWithJSONObject:jsondata options:NSJSONWritingPrettyPrinted error:&error2];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [jsondata2 length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"PUT"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:authstring forHTTPHeaderField:@"TeckskyAuth"];
    
    
    [request setHTTPBody:jsondata2];
    
    NSURLResponse *response;
    
    NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSMutableDictionary *dic12 = [NSJSONSerialization JSONObjectWithData:POSTReply options:0 error:nil];
    
    return dic12;
}




+(NSDictionary*)httpDeletewithauth:(NSString *)url :(NSDictionary *)jsondata :(NSString *)authstring
{
    //    __block NSDictionary *dic = [[NSDictionary alloc]init];
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    [manager DELETE:url parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
    //        dic = responseObject;
    //        //NSLog(@"JSON: %@", [response valueForKey:@"message"]);
    //    } failure:^(NSURLSessionTask *operation, NSError *error) {
    //        dic = [NSDictionary dictionaryWithObjectsAndKeys:@"false",@"status",[error localizedDescription],@"message", nil];
    //    }];
    
    
    NSError *error2;
    
    NSData *jsondata2 = [NSJSONSerialization dataWithJSONObject:jsondata options:NSJSONWritingPrettyPrinted error:&error2];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [jsondata2 length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"DELETE"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:authstring forHTTPHeaderField:@"TeckskyAuth"];
    
    
    [request setHTTPBody:jsondata2];
    
    NSURLResponse *response;
    
    NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSMutableDictionary *dic12 = [NSJSONSerialization JSONObjectWithData:POSTReply options:0 error:nil];
    
    return dic12;
}

@end
