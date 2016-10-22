//
//  UIViewController+MVCSupport.m
//  Weinkeller
//
//  Created by Dhanu Saksrisathaporn on 6/10/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import "UIViewController+MVCSupport.h"
#import "NSString+WDLocalized.h"
#import "NSObject+MVCSupport.h"
#import "UIView+MVCSupport.h"
@implementation UIViewController (MVCSupport)

- (UIAlertController *)inputAlertViewWithTitle:(NSString *)title textFieldInfo:(NSDictionary *)info completion:(void (^)(void))completion closeAlertCompletion:(void (^)(NSString *inputString))closeAlertCompletion
{
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:[title localString]
                                message:nil
                                preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [textField setValuesByDictionary:info];
    }];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:[@"enter" localString] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        closeAlertCompletion(alert.textFields[0].text);
    }];
    [alert addAction:action];
    
    action = [UIAlertAction actionWithTitle:[@"close" localString] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        closeAlertCompletion(nil);
    }];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:^{
        completion();
    }];
    return alert;
}
- (UIAlertController *)warningAlertViewWithTitle:(NSString *)title completion:(void (^ __nullable)(void))completion closeAlertCompletion:(void (^ __nullable)(void))closeAlertCompletion
{
    return [self warningAlertViewWithTitle:title message:nil completion:completion closeAlertCompletion:closeAlertCompletion];
}
- (UIAlertController *)warningAlertViewWithTitle:(NSString *)title message:(NSString *)message completion:(void (^ __nullable)(void))completion closeAlertCompletion:(void (^ __nullable)(void))closeAlertCompletion
{
    return [self warningAlertViewWithTitle:title message:nil cancel:[@"close" localString]  completion:completion closeAlertCompletion:closeAlertCompletion];
}

- (UIAlertController *)warningAlertViewWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel completion:(void (^)(void))completion closeAlertCompletion:(void (^)(void))closeAlertCompletion
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[title localString] message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        closeAlertCompletion();
    }];
    [alert addAction:action];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:^{
            completion();
        }];
    });
    return alert;
}
- (UIAlertController *)waitingAlertViewWithTitle:(NSString *)title completion:(void (^ __nullable)(void))completion
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[title localString] message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        UIViewController *customVC     = [[UIViewController alloc] init];
        
        
        UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spinner startAnimating];
        [customVC.view addSubview:spinner];
        
        
        [customVC.view addConstraint:[NSLayoutConstraint
                                      constraintWithItem: spinner
                                      attribute:NSLayoutAttributeCenterX
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:customVC.view
                                      attribute:NSLayoutAttributeCenterX
                                      multiplier:1.0f
                                      constant:0.0f]];
        
        
        
        [customVC.view addConstraint:[NSLayoutConstraint
                                      constraintWithItem: spinner
                                      attribute:NSLayoutAttributeCenterY
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:customVC.view
                                      attribute:NSLayoutAttributeCenterY
                                      multiplier:0.5f
                                      constant:0.0f]];
        
        
        [alert setValue:customVC forKey:@"contentViewController"];
        
        
        [self presentViewController:alert animated:YES completion:^{
            completion();
        }];

        
//        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        indicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin + UIViewAutoresizingFlexibleTopMargin + UIViewAutoresizingFlexibleBottomMargin;
//        indicator.center = CGPointMake(alert.view.bounds.size.width -30, alert.view.bounds.size.height * 0.5);
//        [alert.view addSubview:indicator];
//        
//        [indicator startAnimating];
//        
//        [self presentViewController:alert animated:YES completion:^{
//            completion();
//        }];
    });
    
    return alert;
}
- (BOOL)isModal
{
    if (self.navigationController) {
        if (self.navigationController.visibleViewController == self) {
            return [self.navigationController isModal];
        }
        return NO;
    }
    if (self.tabBarController) {
        if (self.tabBarController.selectedViewController == self) {
            return [self.tabBarController isModal];
        }
        return NO;
    }
    if ([self presentingViewController]) {
        return YES;
    }
    return NO;
}
- (void)addBackButton
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:[@"back" localString] style:UIBarButtonItemStylePlain target:nil action:nil];
//    [self.navigationItem.backBarButtonItem setTitleTextAttributes:@{
//                                                                        NSFontAttributeName:[UIFont fontWithName:@"Georgia" size:17],
//                                                                        NSForegroundColorAttributeName:[UIColor appColor1]
//                                                                    }
//                                                         forState:UIControlStateNormal];
}
- (void)addChildViewController:(UIViewController *)childController onView:(UIView *)view
{
    [self addChildViewController:childController];
    childController.view.frame = view.bounds;
    childController.view.autoresizingMask = -1;
    [childController willMoveToParentViewController:self];
    [view addSubview:childController.view];
    [childController didMoveToParentViewController:self];
}
- (void)instantRemoveChildViewController:(UIViewController *)childController
{
    [childController willMoveToParentViewController:nil];
    [childController.view removeFromSuperview];
    [childController removeFromParentViewController];
}
- (id)findFirstResponder
{
    return [self.view findFirstResponder];
}
- (void)setInputData:(id)data
{
    
}
- (IBAction)back:(id)sender
{
    if (self.navigationController.viewControllers.firstObject == self) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
        }];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)cancel:(id)sender
{
    if (self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
        }];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

- (UIAlertController *)yesnoAlertViewWithTitle:(NSString *)title message:(NSString *)message completion:(void (^)(void))completion noCompletion:(void (^)(void))yesCompletion noCompletion:(void (^)(void))noCompletion
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[title localString] message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionYes = [UIAlertAction actionWithTitle:[@"Yes" localString] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        noCompletion();
    }];
    UIAlertAction *actionNo = [UIAlertAction actionWithTitle:[@"No" localString] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        noCompletion();
    }];
    
    [alert addAction:actionYes];
    [alert addAction:actionNo];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:^{
            completion();
        }];
    });
    return alert;
}
@end
