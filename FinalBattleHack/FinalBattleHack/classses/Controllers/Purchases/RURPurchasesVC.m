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
@property (nonatomic, strong) NSMutableArray *purchasesArray;
@end

@implementation RURPurchasesVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self reloadPurchases];
        
    }
    return self;
}

- (void)viewDidLoad
{
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadPurchases];
}

- (void)reloadPurchases
{
    PFQuery *query = [PFQuery queryWithClassName:@"Purchase"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
            //self.purchases = objects;
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    self.purchasesArray = [def objectForKey:@"purchasesarray"];
    [self.purchases reloadData];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [self.itemsPurchased count];
    return [self.purchasesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellPurchases"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellPurchases"];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
//    PFObject *purchase = self.itemsPurchased[indexPath.row];
//    cell.textLabel.text = [[purchase objectForKey:@"product"] objectForKey:@"name"];
    cell.textLabel.text = [self.purchasesArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

#pragma mark - Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FXBlurView *view = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 0, 268, 40)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 268, 40)];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor clearColor];
    title.text = @"Purchases";
    
    [view addSubview:title];
    return view;
}

@end
