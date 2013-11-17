//
//  RURRestManager.h
//  FinalBattleHack
//
//  Created by Raimon Lapuente on 17/11/2013.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TTB_Rest_PROTOCOL <NSObject>
@optional
- (void) weGotAnswer:(NSDictionary *)json;
@end

@interface RURRestManager : NSObject

@property id del;

+ (RURRestManager *) sharedInstance;

- (void) sendImage:(UIImage *)image;


@end
