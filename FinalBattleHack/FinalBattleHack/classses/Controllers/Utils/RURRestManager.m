//
//  RURRestManager.m
//  FinalBattleHack
//
//  Created by Raimon Lapuente on 17/11/2013.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURRestManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation RURRestManager

NSString *const catchoomUrl = @"https://r.catchoom.com/v1/search";

+ (RURRestManager *) sharedInstance
{
    static RURRestManager *sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void) sendImage:(UIImage *)image
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"token": @"dbc9b45324694138"};
    //NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    [manager POST:catchoomUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:imageData name:@"image"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
