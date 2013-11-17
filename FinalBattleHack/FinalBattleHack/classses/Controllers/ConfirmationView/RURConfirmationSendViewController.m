//
//  RURConfirmationSendViewController.m
//  FinalBattleHack
//
//  Created by Raimon Lapuente on 17/11/2013.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURConfirmationSendViewController.h"

#import <sendgrid/sendgrid.h>

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
}

#pragma mark - Sendgrid

- (void)sendShopEmail:(NSString *)shopEmail userEmail:(NSString *)userEmail body:(NSString *)body subject:(NSString *)subject
{
    sendgrid *msg = [sendgrid user:@"rcabamo" andPass:@"pepito"];
    
    msg.to = userEmail;
    msg.subject = subject;
    msg.from = shopEmail;
    msg.text = body;
    
    [msg sendWithWeb];
}

- (IBAction)pickUpClick:(id)sender {
    [_pickUpButton setSelected:YES];
    [_sendButton setSelected:NO];
}

- (IBAction)sendClick:(id)sender {
    [_pickUpButton setSelected:NO];
    [_sendButton setSelected:YES];
}
@end
