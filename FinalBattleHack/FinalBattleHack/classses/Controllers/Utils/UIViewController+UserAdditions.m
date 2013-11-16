//
//  UIViewController+UserAdditions.m
//  FinalBattleHack
//
//  Created by Ricardo Caballero on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "UIViewController+UserAdditions.h"

#import <Typhoon/Typhoon.h>
#import <objc/runtime.h>

static char UserKey;

@implementation UIViewController (UserAdditions)

- (RURUser *)user
{
    RURUser *user = objc_getAssociatedObject(self, &UserKey);
    if (!user) {
        user = [[TyphoonComponentFactory defaultFactory] componentForType:[RURUser class]];
        self.user = user;
    }
    return user;
}

- (void)setUser:(RURUser *)user
{
    objc_setAssociatedObject(self, &user, user, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
