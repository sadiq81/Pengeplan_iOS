//
// Created by Tommy Sadiq Hinrichsen on 27/02/14.
// Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginViewController;
@class AuthResponse;


@interface LoginService : NSObject

+ (LoginService *)sharedLoginService;

- (void)login:(NSString *)username password:(NSString *)password save:(BOOL)save pin:(NSString *)pin;

- (void)handleAuthResponse:(NSNotification *)notification;

- (NSString *)testForPersistentLogin:(UITextField *)username password:(UITextField *)password;

- (NSArray *)getLoggedInCredentials;

- (NSString *)encodeCredentials:(NSString *)username password:(NSString *)password;

- (void)deleteAccounts;

@end