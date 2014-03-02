//
// Created by Tommy Sadiq Hinrichsen on 27/02/14.
// Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import "PengeplanService.h"
#import "Transaction.h"
#import "UNIRest.h"
#import "LoginService.h"
#import "RestKit.h"
#import "AuthResponse.h"
#import "AppDelegate.h"

@implementation PengeplanService {
}

NSString *url = @"http://0.0.0.0:8080/api/user/";
static PengeplanService *sharedPengeplanService = nil;    // static instance variable

- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

+ (PengeplanService *)sharedPengeplanService {
    if (sharedPengeplanService == nil) {
        sharedPengeplanService = [[super allocWithZone:NULL] init];
    }
    return sharedPengeplanService;
}

- (void)authenticate:(NSString *)username withPassword:(NSString *)password pin:(NSString *)pin {

    AuthResponse *response = [[AuthResponse alloc] init];
    response.username = username;
    RKObjectManager *manager = [RKObjectManager sharedManager];
    [manager.HTTPClient setAuthorizationHeaderWithUsername:username password:password];
    [manager getObject:response path:nil
            parameters:nil
               success:^(RKObjectRequestOperation *operation,
                       RKMappingResult *mappingResult) {
                   AuthResponse *response = [mappingResult firstObject];
                   response.password = password;
                   response.pin = pin;
                   [[NSNotificationCenter defaultCenter] postNotificationName:@"handleAuthResponse" object:nil userInfo:[NSDictionary dictionaryWithObject:response forKey:@"authResponse"]];

               }
               failure:^(RKObjectRequestOperation *operation,
                       NSError *error) {
                   response.authorized = @"error";
                   response.error = error;
                   response.password = password;
                   response.pin = pin;
                   [[NSNotificationCenter defaultCenter] postNotificationName:@"handleAuthResponse" object:nil userInfo:[NSDictionary dictionaryWithObject:response forKey:@"authResponse"]];
                   NSLog(@"Error on loading: %@", [error localizedDescription]);
                   //TODO move to UI Controller
                   [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error in communication with server." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
               }];

}


- (void)updateTransactions {

    NSArray *credentials = [[LoginService sharedLoginService] getLoggedInCredentials];

    RKObjectManager *manager = [RKObjectManager sharedManager];
    [manager.HTTPClient setAuthorizationHeaderWithUsername:[credentials objectAtIndex:0] password:[credentials objectAtIndex:1]];
    [manager getObject:nil
                  path:[NSString stringWithFormat:@"%@%@", @"transactions/", [credentials objectAtIndex:0]]
            parameters:nil
               success:^(RKObjectRequestOperation *operation,
                       RKMappingResult *mappingResult) {
                   [[NSNotificationCenter defaultCenter] postNotificationName:@"transactionsUpdated" object:nil userInfo:nil];
               }
               failure:^(RKObjectRequestOperation *operation,
                       NSError *error) {
                   //TODO move to UI Controller
                   [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error in communication with server." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                   NSLog(@"Error on loading: %@", [error localizedDescription]);
               }];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end