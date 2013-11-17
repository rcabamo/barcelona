//
//  RURDetailShopVC.m
//  FinalBattleHack
//
//  Created by Oriol Capdevila on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURDetailShopVC.h"

#import "RURProductCatalogVC.h"

@interface RURDetailShopVC ()

@property (nonatomic, strong) PFObject *shop;

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
        self.shop = shop;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup view
    // title
    self.titleLabel.text = [self.shop stringForField:@"name"];
    self.descriptionTextView.text = [self.shop stringForField:@"description"];
    [self.shop imageWithSize:self.imageView.frame.size success:^(UIImage *img) {
        self.imageView.image = img;
    }];
}

- (IBAction)openProductsVC:(id)sender
{
    NSArray *array = [[self.shop joinResultForField:@"products"] objects];
    
    RURProductCatalogVC *controller = [[RURProductCatalogVC alloc] initWithItems:[[self.shop joinResultForField:@"products"] objects]];
    
    [self.navigationController pushViewController:controller animated:YES];
}


@end
