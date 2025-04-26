//
//  SceneDelegate.h
//  WeiboDemo
//
//  Created by ByteDance on 2025/4/2.
//

#import <UIKit/UIKit.h>

@class  WBViewController;

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) WBViewController *homeVC;
@property (strong, nonatomic) WBViewController *videoVC;
@property (strong, nonatomic) WBViewController *findVC;
@property (strong, nonatomic) WBViewController *messageVC;
@property (strong, nonatomic) WBViewController *meVC;

@property (strong, nonatomic) UINavigationController *homeNC;
@property (strong, nonatomic) UINavigationController *videoNC;
@property (strong, nonatomic) UINavigationController *findNC;
@property (strong, nonatomic) UINavigationController *messageNC;
@property (strong, nonatomic) UINavigationController *meNC;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end

