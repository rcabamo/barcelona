//
//  RURcaptureViewController.m
//  FinalBattleHack
//
//  Created by Raimon Lapuente on 17/11/2013.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURcaptureViewController.h"
#import "RURMatchingCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RURcaptureViewController ()

@property NSArray *elems;

@end

@implementation RURcaptureViewController

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
    // Do any additional setup after loading the view from its nib.
    UINib *nib = [UINib nibWithNibName:@"RURMatchingCell" bundle:nil];
    [[self table] registerNib:nib forCellReuseIdentifier:@"RURMatchingCell"];

}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _background.image = _image;
    _elems = [_serverInfo objectForKey:@"results"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView Delegates

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RURMatchingCell *cell = (RURMatchingCell *)[tableView dequeueReusableCellWithIdentifier:@"RURMatchingCell"];
    if (!cell) {
        cell = (RURMatchingCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RURMatchingCell"];
    }
    NSDictionary *object = [_elems objectAtIndex:indexPath.row];
    [cell.image setImageWithURL:[[object objectForKey:@"image"] objectForKey:@"thumb_120"]];
    cell.name.text = [[object objectForKey:@"item"] objectForKey:@"name"];
    cell.accuracy.text = [NSString stringWithFormat:@"%@ %%",[object objectForKey:@"score"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *object = [_elems objectAtIndex:indexPath.row];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_elems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}


@end
