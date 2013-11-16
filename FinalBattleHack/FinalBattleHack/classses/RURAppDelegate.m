//
//  RURAppDelegate.m
//  FinalBattleHack
//
//  Created by Ricardo Caballero on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURAppDelegate.h"

#import "RURAssembly.h"

#import <MSDynamicsDrawerViewController/MSDynamicsDrawerViewController.h>

#import <Typhoon/Typhoon.h>

@implementation RURAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setup
    [self setupApp];
    
    // Init VC's
    MSDynamicsDrawerViewController *rootVC = [MSDynamicsDrawerViewController new];
    
    self.window.rootViewController = rootVC;
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
