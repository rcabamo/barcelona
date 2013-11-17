//
//  RURProfileVC.m
//  FinalBattleHack
//
//  Created by Ricardo Caballero on 17/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURProfileVC.h"

@interface RURProfileVC ()
@property (nonatomic, strong) IBOutlet UIButton *avatar;
@property (nonatomic, strong) IBOutlet UITextField *userInfo;

@end

@implementation RURProfileVC

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
    self.title = @"Profile";
    
    self.avatar.layer.cornerRadius = 62;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
