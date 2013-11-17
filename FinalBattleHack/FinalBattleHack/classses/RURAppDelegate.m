//
//  RURAppDelegate.m
//  FinalBattleHack
//
//  Created by Ricardo Caballero on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURAppDelegate.h"

#import "RURShopsMapVC.h"
#import "RURPurchasesVC.h"
#import "RURProfileVC.h"
#import "RURProductCatalogVC.h"

#import "RURDetailShopVC.h"
#import <MSDynamicsDrawerViewController/MSDynamicsDrawerViewController.h>

@implementation RURAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setup
    [self setupApp];
    
    // Init VC's
    RURProfileVC *profileVC = [[RURProfileVC alloc] init];
    RURPurchasesVC *purchasesVC = [[RURPurchasesVC alloc] init];
    UINavigationController *shopsVC = [[UINavigationController alloc] initWithRootViewController:[[RURShopsMapVC alloc] init]];
//    UINavigationController *shopsVC = [[UINavigationController alloc] initWithRootViewController:[[RURDetailShopVC alloc] initWithShop:nil]];
    shopsVC.navigationBar.translucent = NO;
    
    self.dynamicsDrawerViewController = [MSDynamicsDrawerViewController new];
    [self.dynamicsDrawerViewController addStylersFromArray:@[[MSDynamicsDrawerScaleStyler styler], [MSDynamicsDrawerFadeStyler styler]] forDirection:MSDynamicsDrawerDirectionLeft];
    [self.dynamicsDrawerViewController addStylersFromArray:@[[MSDynamicsDrawerParallaxStyler styler]] forDirection:MSDynamicsDrawerDirectionRight];
    
    // Set main controller
    [self.dynamicsDrawerViewController setPaneViewController:shopsVC animated:NO completion:nil];
    
    // Set lateral controllers
    [self.dynamicsDrawerViewController setDrawerViewController:purchasesVC forDirection:MSDynamicsDrawerDirectionLeft];
    [self.dynamicsDrawerViewController setDrawerViewController:profileVC forDirection:MSDynamicsDrawerDirectionRight];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.tintColor = [UIColor blackColor];
    self.window.rootViewController = self.dynamicsDrawerViewController;
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"windowBackground"]];
    [self.window addSubview:backgroundView];
    [self.window sendSubviewToBack:backgroundView];
    
    NSLog(@"clientID: %@", [[TyphoonComponentFactory defaultFactory] paypalClientID]);
    NSLog(@"secretID: %@", [[TyphoonComponentFactory defaultFactory] paypalSecretID]);
    
    NSMutableArray *purchases = [NSMutableArray arrayWithObjects:@"Object 1", @"Object 2", @"Object 3", nil];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:purchases forKey:@"purchasesarray"];
    [def synchronize];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - Private Methods
							
- (void)setupApp
{
    [self setupTyphoon];
    [self setupParse];
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

- (void)setupParse
{
    [Parse setApplicationId:[[TyphoonComponentFactory defaultFactory] parseAppID]
                  clientKey:[[TyphoonComponentFactory defaultFactory] parseClientKey]];
}

@end
