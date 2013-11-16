//
//  RURAppDelegate.m
//  FinalBattleHack
//
//  Created by Ricardo Caballero on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURAppDelegate.h"

#import "RURAssembly.h"

#import "RURShopsMapVC.h"
#import "RURPurchasesVC.h"
#import "RURProfileVC.h"

#import <MSDynamicsDrawerViewController/MSDynamicsDrawerViewController.h>
#import <Typhoon/Typhoon.h>

@implementation RURAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setup
    [self setupApp];
    
    // Init VC's
    RURProfileVC *profileVC = [[RURProfileVC alloc] init];
    RURPurchasesVC *purchasesVC = [[RURPurchasesVC alloc] init];
    RURShopsMapVC *shopsVC = [[RURShopsMapVC alloc] init];
    
    self.dynamicsDrawerViewController = [MSDynamicsDrawerViewController new];
    [self.dynamicsDrawerViewController addStylersFromArray:@[[MSDynamicsDrawerScaleStyler styler], [MSDynamicsDrawerFadeStyler styler]] forDirection:MSDynamicsDrawerDirectionLeft];
    [self.dynamicsDrawerViewController addStylersFromArray:@[[MSDynamicsDrawerParallaxStyler styler]] forDirection:MSDynamicsDrawerDirectionRight];
    
    // Set main controller
    [self.dynamicsDrawerViewController setPaneViewController:[[UINavigationController alloc] initWithRootViewController:shopsVC] animated:NO completion:nil];
    
    // Set lateral controllers
    [self.dynamicsDrawerViewController setDrawerViewController:purchasesVC forDirection:MSDynamicsDrawerDirectionLeft];
    [self.dynamicsDrawerViewController setDrawerViewController:profileVC forDirection:MSDynamicsDrawerDirectionRight];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.dynamicsDrawerViewController;
    [self.window makeKeyAndVisible];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"windowBackground"]];
    [self.window addSubview:backgroundView];
    [self.window sendSubviewToBack:backgroundView];
    
    NSLog(@"clientID: %@", [[TyphoonComponentFactory defaultFactory] clientID]);
    NSLog(@"secretID: %@", [[TyphoonComponentFactory defaultFactory] secretID]);
    
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
