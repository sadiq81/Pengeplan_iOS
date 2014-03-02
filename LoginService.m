//
// Created by Tommy Sadiq Hinrichsen on 27/02/14.
// Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import "LoginService.h"
#import "PengeplanService.h"
#import "SSKeychain.h"
#import "AuthResponse.h"


@implementation LoginService {

}

static LoginService *sharedLoginService = nil;    // static instance variable

- (id)init {
    if ((self = [super init])) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAuthResponse:) name:@"handleAuthResponse" object:nil];
    }
    return self;
}

+ (LoginService *)sharedLoginService {
    if (sharedLoginService == nil) {
        sharedLoginService = [[super allocWithZone:NULL] init];
    }
    return sharedLoginService;
}

- (void)login:(NSString *)username password:(NSString *)password save:(BOOL)save pin:(NSString *)pin {

    [[PengeplanService sharedPengeplanService] authenticate:username withPassword:password pin:pin];
}

- (void)handleAuthResponse:(NSNotification *)notification {

    AuthResponse *authResponse = [[notification userInfo] valueForKey:@"authResponse"];
    [self deleteAccounts]; //Ensures only one account in memory
    if ([authResponse isAuthenticated]) {
        [SSKeychain setPassword:authResponse.password forService:@"PengeplanUser" account:authResponse.username];

        if (authResponse.pin.length >= 4) {
            [SSKeychain setPassword:authResponse.pin forService:@"PengeplanPin" account:@"pin"];
        }

    }

}

- (NSString *)testForPersistentLogin:(UITextField *)username password:(UITextField *)password {

    NSString *pin = [SSKeychain passwordForService:@"PengeplanPin" account:@"pin"];
    if (pin == nil) {
        return nil;
    }

    NSArray *accounts = [SSKeychain accountsForService:@"PengeplanUser"];
    if (accounts.count == 0) {
        return nil;
    }

    NSString *user = [accounts[0] objectForKey:@"acct"];
    username.text = user;
    NSString *pass = [SSKeychain passwordForService:@"PengeplanUser" account:user];
    password.text = pass;

    return pin;
}


- (NSArray *)getLoggedInCredentials {
    NSArray *accounts = [SSKeychain accountsForService:@"PengeplanUser"];
    NSString *username = [[accounts objectAtIndex:0] objectForKey:@"acct"];
    NSString *password = [SSKeychain passwordForService:@"PengeplanUser" account:username];
    return [NSArray arrayWithObjects:username, password, nil];
}

- (NSString *)encodeCredentials:(NSString *)username password:(NSString *)password {
    NSString *usernameAndPassword = [NSString stringWithFormat:@"%@%@%@", username, @":", password];
    NSData *plainData = [usernameAndPassword dataUsingEncoding:NSUTF8StringEncoding];
    return [plainData base64EncodedStringWithOptions:0];
}

- (void)deleteAccounts {
    NSArray *accounts = [SSKeychain accountsForService:@"PengeplanUser"];
    [SSKeychain deletePasswordForService:@"PengeplanUser" account:[[accounts objectAtIndex:0] objectForKey:@"acct"]];
    [SSKeychain deletePasswordForService:@"PengeplanPin" account:@"pin"];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end