//
//  LoginViewController.m
//  Pengeplan IOS
//
//  Created by Tommy Sadiq Hinrichsen on 26/02/14.
//  Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginService.h"
#import "AuthResponse.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

NSString *pin;

- (void)viewDidLoad {

    [super viewDidLoad];
    pin = [[LoginService sharedLoginService] testForPersistentLogin:self.username password:self.password];
    if (pin != nil) {
        [self.remember setOn:YES animated:YES];
        self.pinLabel.hidden = self.pin.hidden = NO;
        [self.username setEnabled:NO];
        [self.password setEnabled:NO];
        self.username.textColor = [UIColor lightGrayColor];
        self.password.textColor = [UIColor lightGrayColor];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAuthResponse:) name:@"handleAuthResponse" object:nil];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)remember:(id)sender {

    if (self.remember.isOn) {
        self.pinLabel.hidden = self.pin.hidden = NO;
    } else {
        self.pinLabel.hidden = self.pin.hidden = YES;
        self.username.text = @"";
        self.password.text = @"";
        [self.username setEnabled:YES];
        [self.password setEnabled:YES];
        self.username.textColor = [UIColor blackColor];
        self.password.textColor = [UIColor blackColor];
        pin = nil;
        [[LoginService sharedLoginService] deleteAccounts];
    }

}

- (IBAction)login:(id)sender {
    [[LoginService sharedLoginService] login:self.username.text password:self.password.text save:self.remember.isOn pin:self.pin.text];
}


- (void)handleAuthResponse:(NSNotification *)notification {

    AuthResponse *authResponse = [[notification userInfo] valueForKey:@"authResponse"];
    if ([authResponse isAuthenticated]) {
        if (pin == nil || (pin != nil && [self.pin.text isEqualToString:pin])) {
            [self performSegueWithIdentifier:@"loginSegue" sender:self];
        } else if (pin != nil && ![self.pin.text isEqualToString:pin]) {
            [[[UIAlertView alloc] initWithTitle:@"Pin wrong" message:@"You have entered an incorrect pin." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    } else if (![authResponse errorOnAuth]){
        [[[UIAlertView alloc] initWithTitle:@"Login failed" message:@"Login failed, wrong username and/or password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
