//
//  SceneDelegate.h
//  WeiboDemo
//
//  Created by ByteDance on 2025/4/2.
//

#import <UIKit/UIKit.h>

@class  WBTableViewController;

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) WBTableViewController *homeVC;
@property (strong, nonatomic) WBTableViewController *videoVC;
@property (strong, nonatomic) WBTableViewController *findVC;
@property (strong, nonatomic) WBTableViewController *messageVC;
@property (strong, nonatomic) WBTableViewController *meVC;

@property (strong, nonatomic) UINavigationController *homeNC;
@property (strong, nonatomic) UINavigationController *videoNC;
@property (strong, nonatomic) UINavigationController *findNC;
@property (strong, nonatomic) UINavigationController *messageNC;
@property (strong, nonatomic) UINavigationController *meNC;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end

