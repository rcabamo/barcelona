//
//  RURAppDelegate.m
//  FinalBattleHack
//
//  Created by Ricardo Caballero on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURAppDelegate.h"

#import "RURAssembly.h"

#import <Typhoon/Typhoon.h>

@implementation RURAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupApp];
    return YES;
}
							
- (void)setupApp
{
    [self setupTyphoon];
}

- (void)setupTyphoon
{
    // Load shared objects context
    TyphoonComponentFactory *factory = [[TyphoonBlockComponentFactory alloc] initWithAssembly:[RURAssembly assembly]];
    
    TyphoonPropertyPlaceholderConfigurer *configurer = [TyphoonPropertyPlaceholderConfigurer configurer];
    [configurer usePropertyStyleResource:[TyphoonBundleResource withName:@"woo_dev.properties"]];
    
    [factory attachPostProcessor:configurer];
    
    [factory makeDefault];
}

@end
