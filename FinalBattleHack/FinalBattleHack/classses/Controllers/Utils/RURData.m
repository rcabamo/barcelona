//
//  RURData.m
//  FinalBattleHack
//
//  Created by Raimon Lapuente on 17/11/2013.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURData.h"

@implementation RURData


- (id) initCustom
{
    self = [super init];
    if (self) {
        _objects = [[NSDictionary alloc] initWithObjectsAndKeys:@{@"name":@"Magic Mouse!", @"desc":@"It began with iPhone. Then came iPod touch. Then MacBook Pro. Intuitive, smart, dynamic. Multi-Touch technology introduced a remarkably better way to interact with your portable devices — all using gestures. Now we’ve reached another milestone by bringing gestures to the desktop with a mouse that’s unlike anything ever before. It's called Magic Mouse. It's the world's first Multi-Touch mouse",  @"image":@"gestures_2x.jpg", @"price":@"60.0"},@"mouse",@{@"name":@"Magic Mug!", @"desc":@"Magic mug it's unique in it's design. When you drop hot liquid on it, the legs begin to run in circles of about 30cm of radius. Be carefull where you place it, even being magic it breaks",  @"image":@"WhiteMugFront.jpg", @"price":@"23.0"},@"Epic Mug",@{@"name":@"Country Flag", @"desc":@"As simple as the flag of the country we live in, it comes just in two colors, red and yellow.",  @"image":@"flag.JPG", @"price":@"16.0"},@"flag",@{@"name":@"MacBook Pro", @"desc":@"MacBook Pro unibody is one of the best tools that you can use for development",  @"image":@"mac.JPG", @"price":@"12134.0"},@"mac",nil];
    }
    return self;
}

- (NSDictionary *) getProductWithKey:(NSString *) key
{
    return [_objects objectForKey:key];
}

@end
