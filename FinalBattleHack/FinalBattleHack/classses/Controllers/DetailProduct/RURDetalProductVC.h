//
//  RURDetalProductVC.h
//  FinalBattleHack
//
//  Created by Oriol Capdevila on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalPaymentViewController.h"

@interface RURDetalProductVC : UIViewController <PayPalPaymentDelegate>
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *productDescription;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;

- (IBAction)payWithPP:(id)sender;
- (IBAction)addToChart:(id)sender;

- (id) initWithProduct:(PFObject *)info;
- (id) initWithDictionary:(NSDictionary*)info;
@end
