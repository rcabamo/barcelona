//
//  RURData.h
//  FinalBattleHack
//
//  Created by Raimon Lapuente on 17/11/2013.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RURData : NSObject

@property NSDictionary *objects;

- (id) initCustom;
- (NSDictionary *) getProductWithKey:(NSString *) key;

@end
