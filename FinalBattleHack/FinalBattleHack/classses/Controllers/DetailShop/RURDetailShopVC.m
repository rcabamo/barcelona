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
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

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
        NSArray *pr = [[NSArray alloc] initWithObjects:@{@"name":@"Name product", @"desc":@"desc product",  @"image":@"http://www.albertdaviddesign.com/wp-content/uploads/2013/09/test.gif", @"price":@"112"}, @{@"name":@"Name product", @"desc":@"desc product",  @"image":@"http://www.albertdaviddesign.com/wp-content/uploads/2013/09/test.gif", @"price":@"112"}, nil];
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
