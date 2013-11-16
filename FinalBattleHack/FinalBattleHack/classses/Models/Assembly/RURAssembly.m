//
//  RURAssembly.m
//  FinalBattleHack
//
//  Created by Ricardo Caballero on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURAssembly.h"

#import "RURUser.h"

@implementation RURAssembly

- (id)user
{
    return [TyphoonDefinition withClass:[RURUser class] properties:^(TyphoonDefinition *definition) {
        definition.scope = TyphoonScopeSingleton;
    }];
}

@end
