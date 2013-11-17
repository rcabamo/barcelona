//
//  RURConfirmationSendViewController.m
//  FinalBattleHack
//
//  Created by Raimon Lapuente on 17/11/2013.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURConfirmationSendViewController.h"

#import <sendgrid/sendgrid.h>
#import <QuartzCore/QuartzCore.h>

@interface RURConfirmationSendViewController ()

@property NSDictionary *info;
@property (nonatomic, strong) IBOutlet UIView *holderView;
@property (nonatomic, strong) IBOutlet UILabel *infoPurchase;

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
    self.holderView.layer.cornerRadius = 15;
    self.holderView.layer.shadowColor = [[UIColor blackColor]CGColor];
    self.holderView.layer.shadowOpacity = 1;
    self.holderView.layer.shadowOffset = CGSizeMake(0, 0);
    self.holderView.layer.shadowRadius = 10.0f;
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"windowBackground"]];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    
    [self.infoPurchase setText:[NSString stringWithFormat:@"Item Buyed: %@\nPrice: $%@\nOn Date: %@", [self.item objectForKey:@"name"], [self.item objectForKey:@"price"], [[[self.payment objectForKey:@"proof_of_payment"] objectForKey:@"adaptive_payment"] objectForKey:@"timestamp"]]];
    [self sendShopEmail:@"shop@gmail.com" userEmail:@"rcabamo@gmail.com" body:@"" subject:@"Invoice"];
}

#pragma mark - Sendgrid

- (void)sendShopEmail:(NSString *)shopEmail userEmail:(NSString *)userEmail body:(NSString *)body subject:(NSString *)subject
{
    sendgrid *msg = [sendgrid user:@"rcabamo" andPass:@"pepito"];
    
    msg.to = userEmail;
    msg.subject = subject;
    msg.from = shopEmail;
    msg.text = body;
    msg.html = [NSString stringWithFormat:@"<h1> Hello Ricardo!</h1>\n \
    <p>You buy a %@. You can pick up the item in the store or send you at home.</p>\
                <p>Thanks for your trust.</p>", [self.item objectForKey:@"name"]];
    [msg sendWithWeb];
}

- (IBAction)pickUpClick:(id)sender {
    [_pickUpButton setSelected:YES];
    [_sendButton setSelected:NO];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ar = [NSMutableArray arrayWithArray:[def objectForKey:@"purchasesarray"]];
    [ar addObject: [NSString stringWithFormat:@"%@ ($%@)", [self.item objectForKey:@"name"], [self.item objectForKey:@"price"]]];
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
    [ar addObject: [NSString stringWithFormat:@"%@ ($%@)", [self.item objectForKey:@"name"], [self.item objectForKey:@"price"]]];
    [def setObject:ar forKey:@"purchasesarray"];
    [def synchronize];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congrats!" message:[NSString stringWithFormat:@"You have buyed an awesome %@\nYou will recieve an email from Sendgrid ASAP!", [self.item objectForKey:@"name"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popToRootViewControllerAnimated:FALSE];
}
@end
