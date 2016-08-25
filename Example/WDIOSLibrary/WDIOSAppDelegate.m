//
//  WDIOSAppDelegate.m
//  WDIOSLibrary
//
//  Created by Dhanu Saksrisathaporn on 07/28/2016.
//  Copyright (c) 2016 Dhanu Saksrisathaporn. All rights reserved.
//

#import "WDIOSAppDelegate.h"
@import WDIOSLibrary;
@implementation WDIOSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"%@",[NSString languages]);
    NSLog(@"%@",[NSLocale preferredLanguages]);
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }

    NSString *secret = @"foodplace";
    NSString *token = [WDJWTString jwtString:@{
                                              @"iss":@"itsmemario",
                                              @"exp":@(0)
                                              } subject:@"test" secret:secret];
    
    NSLog(@"token = %@\ntrue secret = %@",token,secret);
    
    NSLog(@"%@",@([NSObject goldenRatio]));
    NSLog(@"%@",@(GOLDEN_RATIO));
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

-(void) registerBackgroundTask {
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundTask];
    }];
    if (_backgroundTask != UIBackgroundTaskInvalid) {
        NSLog(@"backgroundTask invalid");
    }
    //    NSAssert(_backgroundTask != UIBackgroundTaskInvalid,@"backgroundTask invalid");
}

-(void) endBackgroundTask {
    NSLog(@"Background task ended.");
    [[UIApplication sharedApplication] endBackgroundTask:_backgroundTask];
    _backgroundTask = UIBackgroundTaskInvalid;
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self registerBackgroundTask];
    //    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//    [self endBackgroundTask];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
