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

- (id)clientID {
    return [TyphoonDefinition withClass:[NSString class] initialization:^(TyphoonInitializer *initializer) {
        initializer.selector = @selector(stringWithString:);
        [initializer injectParameterAtIndex:0 withValueAsText:@"${paypal.clientID}" requiredTypeOrNil:[NSString class]];
    }];
}

- (id)secretID {
    return [TyphoonDefinition withClass:[NSString class] initialization:^(TyphoonInitializer *initializer) {
        initializer.selector = @selector(stringWithString:);
        [initializer injectParameterAtIndex:0 withValueAsText:@"${paypal.secretID}" requiredTypeOrNil:[NSString class]];
    }];
}

- (id)user
{
    return [TyphoonDefinition withClass:[RURUser class] properties:^(TyphoonDefinition *definition) {
        definition.scope = TyphoonScopeSingleton;
    }];
}

@end
