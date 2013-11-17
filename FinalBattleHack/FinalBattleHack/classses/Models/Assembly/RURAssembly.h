//
//  RURAssembly.h
//  FinalBattleHack
//
//  Created by Ricardo Caballero on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import <Typhoon/Typhoon.h>

@interface RURAssembly : TyphoonAssembly

- (NSString *)paypalClientID;
- (NSString *)paypalSecretID;

- (NSString *)backbeamAppName;
- (NSString *)backbeamShareKey;
- (NSString *)backbeamSecretKey;
- (NSString *)backbeamEnvironment;

- (id)user;

@end
