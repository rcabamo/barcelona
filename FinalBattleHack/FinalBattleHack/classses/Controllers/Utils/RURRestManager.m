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
    NSData *imageData = UIImageJPEGRepresentation(image, 0.2);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"token": @"dbc9b45324694138"};
    //NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    [manager POST:catchoomUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"camCapture" mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        NSLog(@"Success: %@", responseObject);
        [_del weGotAnswer:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [_del weGotAnswer:nil];
        NSLog(@"Error: %@", error);
    }];
}

@end
