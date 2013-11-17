//
//  RUR_Shop.h
//  FinalBattleHack
//
//  Created by Oriol Capdevila on 17/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RUR_Shop : NSObject
@property (nonatomic, strong) NSString *name, *desc, *address;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic) float lat;
@property (nonatomic) float lon;
@end
