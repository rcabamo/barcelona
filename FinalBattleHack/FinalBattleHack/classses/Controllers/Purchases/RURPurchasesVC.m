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
        [self reloadPurchases];
    }
    return self;
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
            self.purchases = objects;
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


#pragma mark - Table view data source

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
    
    PFObject *purchase = self.itemsPurchased[indexPath.row];
    cell.textLabel.text = [[purchase objectForKey:@"product"] objectForKey:@"name"];
    return cell;
}

#pragma mark - Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
