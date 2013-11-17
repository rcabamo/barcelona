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
    BBQuery *query = [Backbeam queryForEntity:@"purchase"];
    [query setQuery:@"join product"];
    [query fetch:100 offset:0 success:^(NSArray *objects, NSInteger totalCount, BOOL fromCache) {
        self.itemsPurchased = objects;
        [self.purchases reloadData];
    } failure:^(NSError *err) {
        NSLog(@"Query error: %@", err);
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
    
    BBObject *purchase = self.itemsPurchased[indexPath.row];
    cell.textLabel.text = [[purchase objectForField:@"product"] stringForField:@"name"];
    return cell;
}

#pragma mark - Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
