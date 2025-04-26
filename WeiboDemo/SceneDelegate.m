//
//  SceneDelegate.m
//  WeiboDemo
//
//  Created by ByteDance on 2025/4/2.
//

#import "SceneDelegate.h"
#import "WBViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    
    // 1. 初始化 Window 并关联 Scene（关键修复点）
    if ([scene isKindOfClass:[UIWindowScene class]]) {
        // TODO: UIWindowScene
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
        self.window.frame = windowScene.coordinateSpace.bounds;
    } else {
        // 兼容旧版本
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    // 2. 创建 TabBarController 结构
    [self setupRootViewController];
    
    // 3. 显示 Window
    [self.window makeKeyAndVisible];
}

- (void)setupRootViewController {
    // 首页
    self.homeVC = [[WBViewController alloc] init];
    self.homeNC = [[UINavigationController alloc] initWithRootViewController:self.homeVC];
    self.homeNC.navigationBar.translucent = NO;
    
    // 视频号
    self.videoVC = [[WBViewController alloc] init];
    self.videoNC = [[UINavigationController alloc] initWithRootViewController:self.videoVC];
    self.videoNC.navigationBar.translucent = NO;
    
    // 发现
    self.findVC = [[WBViewController alloc] init];
    self.findNC = [[UINavigationController alloc] initWithRootViewController:self.findVC];
    self.findNC.navigationBar.translucent = NO;
    
    // 消息
    self.messageVC = [[WBViewController alloc] init];
    self.messageNC = [[UINavigationController alloc] initWithRootViewController:self.messageVC];
    self.messageNC.navigationBar.translucent = NO;
    
    // 我的
    self.meVC = [[WBViewController alloc] init];
    self.meNC = [[UINavigationController alloc] initWithRootViewController:self.meVC];
    self.meNC.navigationBar.translucent = NO;
    
    
    // 配置 TabBarController
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[self.homeNC, self.videoNC, self.findNC, self.messageNC, self.meNC];
    
    // 设置根控制器
    self.window.rootViewController = self.tabBarController;
    
    // 设置tabbarItem样式
    self.homeNC.tabBarItem = [self systemTabBarItemWithTitle:@"首页" systemIconName:@"house" selectedIconName:@"house.fill"];
    self.videoNC.tabBarItem = [self systemTabBarItemWithTitle:@"视频号" systemIconName:@"play.rectangle" selectedIconName:@"play.rectangle.fill"];
    self.findNC.tabBarItem = [self systemTabBarItemWithTitle:@"发现" systemIconName:@"magnifyingglass" selectedIconName:@"magnifyingglass"];
    self.messageNC.tabBarItem = [self systemTabBarItemWithTitle:@"消息" systemIconName:@"message" selectedIconName:@"message.fill"];
    self.meNC.tabBarItem = [self systemTabBarItemWithTitle:@"我" systemIconName:@"person" selectedIconName:@"person.fill"];
}

// 工具方法：创建系统图标的 UITabBarItem
- (UITabBarItem *)systemTabBarItemWithTitle:(NSString *)title
                             systemIconName:(NSString *)iconName
                           selectedIconName:(NSString *)selectedIconName {
    UIImage *normalImage = [UIImage systemImageNamed:iconName];
    UIImage *selectedImage = [UIImage systemImageNamed:selectedIconName];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title
                                                       image:normalImage
                                               selectedImage:selectedImage];
    return item;
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
