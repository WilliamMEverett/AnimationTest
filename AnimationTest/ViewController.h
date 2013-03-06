//
//  ViewController.h
//  AnimationTest
//
//  Created by William Meister Everett on 3/4/13.
//  Copyright (c) 2013 William Meister Everett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController{
    
    UIWebView IBOutlet *webView;
    int rotationState;
    CATransform3D projectMatrix;
}

-(void)swipeRight;
-(void)swipeLeft;

@end
