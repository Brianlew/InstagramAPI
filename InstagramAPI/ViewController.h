//
//  ViewController.h
//  InstagramAPI
//
//  Created by Brian Lewis on 5/22/13.
//  Copyright (c) 2013 Brian Lewis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)goToNextPhoto:(id)sender;
@end
