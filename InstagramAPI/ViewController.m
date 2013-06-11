//
//  ViewController.m
//  InstagramAPI
//
//  Created by Brian Lewis on 5/22/13.
//  Copyright (c) 2013 Brian Lewis. All rights reserved.
//

//access token: 390125219.4ef70fd.a6a29cb887584e849bd01cac9fd62465

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *imageArray;
    NSString *imageUrlString;
    int imageIndex;
}

-(void)getPhotosFromInstagram;
-(void)displayNextPhoto;
@end

@implementation ViewController
@synthesize imageView, activityIndicator;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    imageUrlString = NULL;
    activityIndicator.hidesWhenStopped = YES;

    [self getPhotosFromInstagram];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getPhotosFromInstagram
{
    [activityIndicator startAnimating];
    
    imageIndex = 0;
    
    //NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/search?lat=42.276490&lng=-83.741188&access_token=390125219.4ef70fd.a6a29cb887584e849bd01cac9fd62465"];
    
    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/tags/hailtothevictors/media/recent?access_token=390125219.4ef70fd.a6a29cb887584e849bd01cac9fd62465"];

    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        imageArray = [responseDictionary objectForKey:@"data"];
        
        [activityIndicator stopAnimating];
        [self displayNextPhoto];
    }];
}

-(void)displayNextPhoto
{
    NSDictionary *resolutionDictionary = [imageArray[imageIndex] objectForKey:@"images"];
    
    
    imageUrlString = [[resolutionDictionary objectForKey:@"standard_resolution"] objectForKey:@"url"];
    
    NSLog(@"url string: %@", imageUrlString);

    if (imageUrlString == nil) {
        [self getPhotosFromInstagram];
    }    
    
    NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *instagramPhoto = [[UIImage alloc] initWithData:imageData];
    imageView.image = instagramPhoto;
        
    imageIndex++;
}

- (IBAction)goToNextPhoto:(id)sender {
    NSLog(@"Photo %i of %i", imageIndex, imageArray.count);
    if (imageIndex == imageArray.count) {
        [self getPhotosFromInstagram];
    }
    [self displayNextPhoto];
}
@end
