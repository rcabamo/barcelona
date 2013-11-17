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
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productDescription;

- (IBAction)payWithPP:(id)sender;
- (IBAction)addToChart:(id)sender;
@end
