//
//  RURUser.h
//  FinalBattleHack
//
//  Created by Ricardo Caballero on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RURUser : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, strong) NSArray *checkoutProducts;

@end
