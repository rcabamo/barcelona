//
//  RURDetalProductVC.m
//  FinalBattleHack
//
//  Created by Oriol Capdevila on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURDetalProductVC.h"
#import "PayPalPaymentViewController.h"

@interface RURDetalProductVC ()

@end

@implementation RURDetalProductVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [PayPalPaymentViewController setEnvironment:PayPalEnvironmentNoNetwork];
}

- (IBAction)payWithPP:(id)sender {
    PayPalPayment *payment = [[PayPalPayment alloc]init];
    payment.currencyCode = @"USD";
    payment.amount = (NSDecimalNumber *) @60;
    payment.shortDescription = @"Nice Apple magic mouse!";
}

#pragma mark - PayPal Delegate

- (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment
{
    NSLog(@"payment was completed with info %@",completedPayment);
}

- (void)payPalPaymentDidCancel
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"PayPal was cancelled");
    }];
}

@end
