//
//  RURPurchasesVC.m
//  FinalBattleHack
//
//  Created by Ricardo Caballero on 17/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURPurchasesVC.h"

@interface RURPurchasesVC ()
@property (nonatomic,strong)IBOutlet UITableView *purchases;
@property (nonatomic, strong) NSArray *itemsPurchased;
@end

@implementation RURPurchasesVC

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
    self.itemsPurchased = [[NSArray alloc] initWithObjects:@"PRODUCT 1", @"PRODUCT 2", @"PRODUCT 3", nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    switch (section) {
//        case 0:
//            return @"";
//            break;
//        case 1:
//            return @"";
//            break;
//        case 2:
//            return @"";
//        default:
//            return @"";
//            break;
//    }
//}

//- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    switch (section) {
//        case 0:
//            return @"";
//            break;
//        case 1:
//            return @"";
//            break;
//        case 2:
//            return @"";
//            break;
//        default:
//            return @"";
//            break;
//    }
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.itemsPurchased count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellPurchases"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellPurchases"];
    }
    cell.textLabel.text = [self.itemsPurchased objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
