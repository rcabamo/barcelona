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

#import "RURProductCatalogVC.h"

@implementation RURAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setup
    [self setupApp];
    
    // Init VC's
    MSDynamicsDrawerViewController *rootVC = [MSDynamicsDrawerViewController new];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"windowBackground"]];
    [self.window addSubview:backgroundView];
    [self.window sendSubviewToBack:backgroundView];
    
    RURProductCatalogVC *catalog = [[RURProductCatalogVC alloc] initWithNibName:@"RURProductCatalogVC" bundle:nil];
    UINavigationController *navCatalog = [[UINavigationController alloc] initWithRootViewController:catalog];
    [navCatalog.navigationBar setTranslucent:NO];
    self.window.rootViewController = navCatalog;
    
    return YES;
}

#pragma mark - Private Methods
							
- (void)setupApp
{
    [self setupTyphoon];
}

- (void)setupTyphoon
{
    // Load shared objects context
    TyphoonComponentFactory *factory = [[TyphoonBlockComponentFactory alloc] initWithAssembly:[RURAssembly assembly]];
    
    TyphoonPropertyPlaceholderConfigurer *configurer = [TyphoonPropertyPlaceholderConfigurer configurer];
    [configurer usePropertyStyleResource:[TyphoonBundleResource withName:@"RUR_dev.properties"]];
    
    [factory attachPostProcessor:configurer];
    
    [factory makeDefault];
}

@end
