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
            _objects = [[NSDictionary alloc] initWithObjectsAndKeys:@{@"name":@"Magic Mouse!", @"desc":@"It began with iPhone. Then came iPod touch. Then MacBook Pro. Intuitive, smart, dynamic. Multi-Touch technology introduced a remarkably better way to interact with your portable devices — all using gestures. Now we’ve reached another milestone by bringing gestures to the desktop with a mouse that’s unlike anything ever before. It's called Magic Mouse. It's the world's first Multi-Touch mouse",  @"image":@"gestures_2x.jpg", @"price":@"60.0"},@"mouse",@{@"name":@"Magic Mug!", @"desc":@"Magic mug it's unique in it's design. When you drop hot liquid on it, the legs begin to run in circles of about 30cm of radius. Be carefull where you place it, even being magic it breaks",  @"image":@"WhiteMugFront.jpg", @"price":@"23.0"},@"Epic Mug",nil];
    }
    return self;
}

- (NSDictionary *) getProductWithKey:(NSString *) key
{
    return [_objects objectForKey:key];
}

@end
