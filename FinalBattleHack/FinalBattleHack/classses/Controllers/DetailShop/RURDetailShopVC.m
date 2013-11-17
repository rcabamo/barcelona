//
//  RURDetailShopVC.m
//  FinalBattleHack
//
//  Created by Oriol Capdevila on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURDetailShopVC.h"

@interface RURDetailShopVC ()

@property (nonatomic, strong) BBObject *shop;

// view
@property (nonatomic, weak) IBOutlet UIView *titleView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;

@end

@implementation RURDetailShopVC

- (id)initWithShop:(BBObject *)shop
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
    self.titleLabel.text = [self.shop stringForField:@"name"];
    self.descriptionTextView.text = [self.shop stringForField:@"description"];
    [self.shop imageWithSize:self.imageView.frame.size success:^(UIImage *img) {
        self.imageView.image = img;
    }];
//    [self.imageView setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil];
}


@end
