//
//  RURConfirmationSendViewController.m
//  FinalBattleHack
//
//  Created by Raimon Lapuente on 17/11/2013.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURConfirmationSendViewController.h"

//#import <sendgrid/sendgrid.h>

@interface RURConfirmationSendViewController ()

@property NSDictionary *info;

@end

@implementation RURConfirmationSendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithData:(NSDictionary *) data
{
    self = [super init];
    if (self) {
        _info = data;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_pickUpButton setBackgroundImage:[UIImage imageNamed:@"backgroundSelected"] forState:UIControlStateSelected];
    [_sendButton setBackgroundImage:[UIImage imageNamed:@"backgroundSelected"] forState:UIControlStateSelected];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"windowBackground"]];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    
    //[self sendShopEmail:@"shop@gmail.com" userEmail:@"rcabamo@gmail.com" body:@"" subject:@""];
}

#pragma mark - Sendgrid

- (void)sendShopEmail:(NSString *)shopEmail userEmail:(NSString *)userEmail body:(NSString *)body subject:(NSString *)subject
{
//    sendgrid *msg = [sendgrid user:@"rcabamo" andPass:@"pepito"];
//    
//    msg.to = userEmail;
//    msg.subject = subject;
//    msg.from = shopEmail;
//    msg.text = body;
//    
//    [msg sendWithWeb];
}

- (IBAction)pickUpClick:(id)sender {
    [_pickUpButton setSelected:YES];
    [_sendButton setSelected:NO];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ar = [NSMutableArray arrayWithArray:[def objectForKey:@"purchasesarray"]];
    [ar addObject: [NSString stringWithFormat:@"%@ (%@)", [self.item objectForKey:@"name"], [self.item objectForKey:@"prize"]]];
    [def setObject:ar forKey:@"purchasesarray"];
    [def synchronize];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congrats!" message:[NSString stringWithFormat:@"You have buyed an awesome %@\nYou will recieve an email from Sendgrid ASAP!", [self.item objectForKey:@"name"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)sendClick:(id)sender {
    [_pickUpButton setSelected:NO];
    [_sendButton setSelected:YES];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ar = [NSMutableArray arrayWithArray:[def objectForKey:@"purchasesarray"]];
    [ar addObject:[self.item objectForKey:@"name"]];
    [def setObject:ar forKey:@"purchasesarray"];
    [def synchronize];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congrats!" message:[NSString stringWithFormat:@"You have buyed an awesome %@\nYou will recieve an email from Sendgrid ASAP!", [self.item objectForKey:@"name"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popToRootViewControllerAnimated:FALSE];
}
@end
