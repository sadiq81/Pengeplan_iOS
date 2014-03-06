//
//  LoginViewController.h
//  Pengeplan IOS
//
//  Created by Tommy Sadiq Hinrichsen on 26/02/14.
//  Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUIViewController.h"

@class PengeplanService;
@class AuthResponse;

@interface LoginViewController : CustomUIViewController

@property(weak, nonatomic) IBOutlet UITextField *username;
@property(weak, nonatomic) IBOutlet UITextField *password;
@property(weak, nonatomic) IBOutlet UITextField *pin;
@property(weak, nonatomic) IBOutlet UISwitch *remember;
@property(weak, nonatomic) IBOutlet UILabel *pinLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)remember:(id)sender;

- (IBAction)login:(id)sender;

- (void)handleAuthResponse:(NSNotification *)notification;

@end
