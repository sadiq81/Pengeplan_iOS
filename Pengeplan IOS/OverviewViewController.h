//
//  OverviewViewController.h
//  Pengeplan IOS
//
//  Created by Tommy Sadiq Hinrichsen on 27/02/14.
//  Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverviewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UIView *securities;
@property (weak, nonatomic) IBOutlet UIView *depositories;
@property (weak, nonatomic) IBOutlet UIView *history;

- (IBAction)segmentedControl:(id)sender;

@end
