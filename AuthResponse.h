//
// Created by Tommy Sadiq Hinrichsen on 28/02/14.
// Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AuthResponse : NSObject

@property(strong, nonatomic) NSString *authorized;
@property(strong, nonatomic) NSString *username;
@property(strong, nonatomic) NSString *password;
@property(strong, nonatomic) NSString *pin;
@property(strong, nonatomic) NSError *error;

- (BOOL)isAuthenticated;

- (BOOL)errorOnAuth;

@end