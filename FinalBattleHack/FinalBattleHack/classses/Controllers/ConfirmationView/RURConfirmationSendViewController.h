//
//  RURConfirmationSendViewController.h
//  FinalBattleHack
//
//  Created by Raimon Lapuente on 17/11/2013.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RURConfirmationSendViewController : UIViewController <UIAlertViewDelegate>
- (IBAction)pickUpClick:(id)sender;
- (IBAction)sendClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *pickUpButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (nonatomic, strong) NSDictionary *item, *payment;
@end
