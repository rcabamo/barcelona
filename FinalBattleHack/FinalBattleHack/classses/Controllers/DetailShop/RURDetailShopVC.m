//
//  RURDetailShopVC.m
//  FinalBattleHack
//
//  Created by Oriol Capdevila on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURDetailShopVC.h"
#import "RUR_Shop.h"
#import "RURProductCatalogVC.h"

@interface RURDetailShopVC ()

//@property (nonatomic, strong) PFObject *shop;
@property (nonatomic, strong) RUR_Shop *shop;
// view
@property (nonatomic, weak) IBOutlet UIView *titleView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *logoImage;

@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;

@end

@implementation RURDetailShopVC

- (id)initWithShop:(PFObject *)shop
{
    self = [super init];
    if (self) {
        //self.shop = shop;
        RUR_Shop *shopaux = [[RUR_Shop alloc] init];
        [shopaux setName:@"Test names"];
        [shopaux setDesc:@"Test desc"];
        [shopaux setAddress:@"Address Test"];
        [shopaux setLon:122.33];
        [shopaux setLat:37.89];
        NSArray *pr = [[NSArray alloc] initWithObjects:@{@"name":@"Magic Mouse!", @"desc":@"It began with iPhone. Then came iPod touch. Then MacBook Pro. Intuitive, smart, dynamic. Multi-Touch technology introduced a remarkably better way to interact with your portable devices — all using gestures. Now we’ve reached another milestone by bringing gestures to the desktop with a mouse that’s unlike anything ever before. It's called Magic Mouse. It's the world's first Multi-Touch mouse",  @"image":@"gestures_2x", @"price":@"60.0"}, @{@"name":@"Magic Mug!", @"desc":@"Magic mug it's unique in it's design. When you drop hot liquid on it, the legs begin to run in circles of about 30cm of radius. Be carefull where you place it, even being magic it breaks",  @"image":@"WhiteMugFront", @"price":@"23.0"}, nil];
        [shopaux setProducts:pr];
        self.shop = shopaux;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup view
    // title
    //self.titleLabel.text = [self.shop objectForKey:@"name"];
    //self.descriptionTextView.text = [self.shop objectForKey:@"description"];
    self.titleLabel.text = [self.shop name];
    self.descriptionTextView.text = [self.shop desc];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"windowBackground"]];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    
    UIImageView *rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RightRevealIcon.png"]];
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LeftRevealIcon.png"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.navigationItem.leftItemsSupplementBackButton = YES;
    //Image
}

- (IBAction)openProductsVC:(id)sender
{
    //NSArray *array = [[self.shop joinResultForField:@"products"] objects];
    
    //RURProductCatalogVC *controller = [[RURProductCatalogVC alloc] initWithItems:[[self.shop joinResultForField:@"products"] objects]];
    RURProductCatalogVC *controller = [[RURProductCatalogVC alloc] initWithItems:[self.shop products]];
    
    [self.navigationController pushViewController:controller animated:YES];
    //Get array products & create catalog controller
}


@end
