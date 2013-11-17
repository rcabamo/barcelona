//
//  RURDetailShopVC.h
//  FinalBattleHack
//
//  Created by Oriol Capdevila on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RURDetailShopVC : UIViewController <UIImagePickerControllerDelegate>

- (id)initWithShop:(PFObject *)shop;

- (IBAction)takePicture:(id)sender;
@end
