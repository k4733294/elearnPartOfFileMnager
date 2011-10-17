//
//  MyMoviePlayer2AppDelegate.h
//  MyMoviePlayer2
//
//  Created by Eric Lin on 2010/7/13.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RootViewController;
@class DetailViewController;

@interface MyMoviePlayer2AppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UIView *view;
    UISplitViewController *splitViewController;
    UINavigationController *navigationController;

    
    RootViewController *rootViewController;
    DetailViewController *detailViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic, retain) UINavigationController *navigationController;
-(IBAction) pp:(id)sender;
-(IBAction) iii:(id)sender;
-(IBAction) erro:(id)sender;
-(IBAction)fManager:(id)sender;
-(IBAction)fmanager2:(id)sender;
@end
