//
// Created by Tommy Sadiq Hinrichsen on 28/02/14.
// Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import "AuthResponse.h"


@implementation AuthResponse {

}

- (BOOL)isAuthenticated {
    return [self.authorized isEqualToString:@"true"];
}

- (BOOL)errorOnAuth {
    return [self.authorized isEqualToString:@"error"];
}

@end