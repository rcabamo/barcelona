//
//  RURcaptureViewController.h
//  FinalBattleHack
//
//  Created by Raimon Lapuente on 17/11/2013.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RURcaptureViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *background;
@property UIImage *image;
@property NSDictionary *serverInfo;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end
