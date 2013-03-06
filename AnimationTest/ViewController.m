//
//  ViewController.m
//  AnimationTest
//
//  Created by William Meister Everett on 3/4/13.
//  Copyright (c) 2013 William Meister Everett. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    rotationState = 0;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]]];
    
    UISwipeGestureRecognizer* leftGest =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
    leftGest.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftGest];

    UISwipeGestureRecognizer* rightGest =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
    rightGest.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightGest];
    
    
    CGFloat near = 500;
    CGFloat far = 1000;
    CGFloat width = 2;
    CGFloat height = 2;
    
    projectMatrix.m12 = 0.0;
    projectMatrix.m13 = 0.0;
    projectMatrix.m14 = 0.0;
    projectMatrix.m21 = 0.0;
    projectMatrix.m23 = 0.0;
    projectMatrix.m24 = 0.0;
    projectMatrix.m31 = 0.0;
    projectMatrix.m32 = 0.0;
    projectMatrix.m41 = 0.0;
    projectMatrix.m42 = 0.0;
    projectMatrix.m11 = near/(width/2.0);
    projectMatrix.m22 = near/(height/2.0);
    projectMatrix.m33 = -1.0*(far + near)/(far - near);
    projectMatrix.m34 = -1.0;
    projectMatrix.m43 = -2.0*far*near/(far - near);
    projectMatrix.m44 = 1.0;
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
                                      

-(void)swipeRight{
    if (rotationState >= 1)
        return;
    
    if (rotationState <= -1){
        rotationState = 0;
        webView.userInteractionEnabled = true;
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationCurveEaseOut
                         animations:^{
                             webView.layer.transform = CATransform3DIdentity;
                             webView.layer.zPosition = 0;
        }
                         completion:^(BOOL finished){
                             NSLog(@"Right Swipe completed");
        }];
        
    } else if (rotationState >= 0){
        rotationState = 1;
        webView.userInteractionEnabled = false;
        
        webView.layer.transform = CATransform3DConcat(
                                                      CATransform3DMakeTranslation(0.0, 0.0, -750),
                                                      projectMatrix
                                                      
                                                      );
        
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationCurveEaseOut
                         animations:^{
                             
                             webView.layer.transform = CATransform3DConcat(CATransform3DMakeRotation(1.0, 0.0, 1.0, 0.0),
                                                        CATransform3DConcat(
                                                                           CATransform3DMakeTranslation(400.0, 0.0, -750),
                                                                           projectMatrix
                                                                           
                                                                           ));

//                             webView.layer.transform = projectMatrix;

//                                CATransform3DConcat(
//                                        CATransform3DConcat(//CATransform3DMakeRotation(1.0, 0.0, 1.0, 0.0),
//                                                            projectMatrix,
//                                                            CATransform3DMakeTranslation(0.0, 0.0, -5000.0)
//                                                    );
                             
                             webView.layer.zPosition = -100;
                         }
                         completion:^(BOOL finished){
                             NSLog(@"Right Swipe completed");
                         }];
        
    }
    
    
    
};
-(void)swipeLeft{
    
    if (rotationState <= -1)
        return;
    
    if (rotationState >= 1){
        rotationState = 0;
        webView.userInteractionEnabled = true;
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationCurveEaseOut
                         animations:^{
                             webView.layer.transform = CATransform3DIdentity;
                             webView.layer.zPosition = 0;
                         }
                         completion:^(BOOL finished){
                             NSLog(@"Left Swipe completed");
                         }];
    } else if (rotationState == 0){
        rotationState = -1;
        webView.userInteractionEnabled = false;
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationCurveEaseOut
                         animations:^{
                             webView.layer.transform = CATransform3DMakeRotation(-1.0, 0.0, 1.0, 0.0);
                             webView.layer.zPosition = -100;
                         }
                         completion:^(BOOL finished){
                             NSLog(@"Left Swipe completed");
                         }];
        
    }
    
    
};

@end
