//
//  RURDetalProductVC.m
//  FinalBattleHack
//
//  Created by Oriol Capdevila on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURDetalProductVC.h"
#import "PayPalPaymentViewController.h"
#import "RURConfirmationSendViewController.h"
@interface RURDetalProductVC ()

@property PFObject *product;
@property NSDictionary *prod;
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

- (id) initWithProduct:(PFObject *)info
{
    self = [super init];
    if (self) {
        _product = info;
    }
    return self;
}


- (id) initWithDictionary:(NSDictionary*)info {
    self = [super init];
    if (self) {
        _prod = info;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"windowBackground"]];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    
    [PayPalPaymentViewController setEnvironment:PayPalEnvironmentNoNetwork];
    
    [self.navigationItem setTitle:[_prod objectForKey:@"name"]];
    _productDescription.text = [_prod objectForKey:@"description"];
    _productPrice.text = [NSString stringWithFormat:@"%@ $",[_prod objectForKey:@"price"]];
    [_productImage setImage:[UIImage imageNamed:[_prod objectForKey:@"image"]]];
}

- (IBAction)payWithPP:(id)sender {
    PayPalPayment *payment = [[PayPalPayment alloc]init];
    payment.currencyCode = @"USD";
    payment.amount = (NSDecimalNumber *) [NSNumber numberWithInteger:[[_prod objectForKey:@"price"] intValue]];
    payment.shortDescription = @"Nice Apple magic mouse!";
    
    if (payment.processable) {
        PayPalPaymentViewController *paymentScreen = [[PayPalPaymentViewController alloc]initWithClientId:[[TyphoonComponentFactory defaultFactory] paypalClientID] receiverEmail:@"r.lapuente-facilitator@gmail.com" payerId:@"PLAYEDID" payment:payment delegate:self];
        [self presentViewController:paymentScreen animated:YES completion:nil];
    } else {
        NSLog(@"something went wrong");
    }
}

- (IBAction)addToChart:(id)sender {
    //code for add to chart
}

#pragma mark - PayPal Delegate

- (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment
{
    //payment dictionary payment{amount,currency_code,short_description
    //payment dictionary proof_of_payment{adaptative_payment{app_id,pay_key,payment:exec_status,timestamp}}
    NSDictionary *payment = completedPayment.confirmation;
    NSLog(@"Payment completed %@", payment);
    [self dismissViewControllerAnimated:YES completion:^{
        RURConfirmationSendViewController *confirm = [[RURConfirmationSendViewController alloc] initWithNibName:@"RURConfirmationSendViewController" bundle:nil];
        [self.navigationController pushViewController:confirm animated:YES];
    }];
    //dismiss screen to show confirmation paye + sending home/pick-up at shop
}

- (void)payPalPaymentDidCancel
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"PayPal was cancelled");
    }];
}

@end
