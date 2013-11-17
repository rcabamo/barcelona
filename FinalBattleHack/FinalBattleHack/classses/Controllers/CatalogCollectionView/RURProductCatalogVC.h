//
//  RURProductCatalogVC.h
//  FinalBattleHack
//
//  Created by Oriol Capdevila on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RURProductCatalogVC : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *items;
@end
