//
//  RURProfileVC.m
//  FinalBattleHack
//
//  Created by Ricardo Caballero on 17/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURProfileVC.h"

#import <PNChart/PNChart.h>

@interface RURProfileVC ()

@property (nonatomic, strong) PFObject *user;

@property (nonatomic, strong) IBOutlet UIButton *avatar;
@property (nonatomic, strong) IBOutlet UITextField *userInfo;

@property (nonatomic, weak) IBOutlet UIScrollView *chartView;

@end

@implementation RURProfileVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self reloadProfile];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Profile";
    
    self.avatar.layer.cornerRadius = 62;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.borderColor = PNFreshGreen.CGColor;
    self.avatar.layer.borderWidth = 3;
    
    
    [self createChart];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self createChart];
}

- (void)createChart
{
    // Remove old views
    for (UIView *view in self.chartView.subviews) {
        [view removeFromSuperview];
    }
    
    //Add BarChart
	UILabel * barChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(248, 0, 248, 30)];
	barChartLabel.text = @"Monthly grouped";
	barChartLabel.textColor = PNFreshGreen;
	barChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
	barChartLabel.textAlignment = NSTextAlignmentCenter;
	
	PNChart * barChart = [[PNChart alloc] initWithFrame:CGRectMake(248, 35, 248, CGRectGetHeight(self.chartView.frame) - 30)];
	barChart.backgroundColor = [UIColor clearColor];
	barChart.type = PNBarType;
	[barChart setXLabels:@[@"NOV 3",@"NOV 4",@"NOV 5",@"NOV 6",@"NOV 7"]];
	[barChart setYValues:@[@10,@240,@120,@180,@300]];
	[barChart strokeChart];
	[self.chartView addSubview:barChartLabel];
	[self.chartView addSubview:barChart];
    
    //Add LineChart
	UILabel * lineChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 248, 30)];
	lineChartLabel.text = @"Amount";
	lineChartLabel.textColor = PNFreshGreen;
	lineChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
	lineChartLabel.textAlignment = NSTextAlignmentCenter;
	
	PNChart * lineChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 45, 248, CGRectGetHeight(self.chartView.frame) - 30)];
	lineChart.backgroundColor = [UIColor clearColor];
	[lineChart setXLabels:@[@"SEP",@"OCT",@"NOV",@"DEC",@"JAN",@"FEB",@"MAR"]];
	[lineChart setYValues:@[@10,@240,@120,@180,@300,@100,@210]];
	[lineChart strokeChart];
	[self.chartView addSubview:lineChartLabel];
	[self.chartView addSubview:lineChart];
    
    [self.chartView setContentSize:CGSizeMake(248*2, CGRectGetHeight(self.chartView.frame))];
    
}

- (void)reloadProfile
{
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
            self.user = [objects firstObject];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
