//
// Created by Tommy Sadiq Hinrichsen on 27/02/14.
// Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PengeplanService : NSObject

+ (PengeplanService *)sharedPengeplanService ;
- (void) authenticate: (NSString*) username withPassword: (NSString*) password pin:(NSString*) pin;
- (void)updateTransactions;


@end