//
//  UIViewController+MVCSupport.h
//  Weinkeller
//
//  Created by Dhanu Saksrisathaporn on 6/10/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MVCSupport)
- (void)addChildViewController:(UIViewController *)childController onView:(UIView *)view;
- (void)instantRemoveChildViewController:(UIViewController *)childController;
- (id)findFirstResponder;
- (void)addBackButton;
- (BOOL)isModal;
- (UIAlertController *)waitingAlertViewWithTitle:(NSString *)title completion:(void (^)(void))completion;
- (UIAlertController *)warningAlertViewWithTitle:(NSString *)title completion:(void (^)(void))completion closeAlertCompletion:(void (^)(void))closeAlertCompletion;
- (UIAlertController *)warningAlertViewWithTitle:(NSString *)title message:(NSString *)message completion:(void (^)(void))completion closeAlertCompletion:(void (^)(void))closeAlertCompletion;
- (UIAlertController *)warningAlertViewWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel completion:(void (^)(void))completion closeAlertCompletion:(void (^)(void))closeAlertCompletion;
- (UIAlertController *)yesnoAlertViewWithTitle:(NSString *)title message:(NSString *)message completion:(void (^)(void))completion yesCompletion:(void (^)(void))yesCompletion noCompletion:(void (^)(void))noCompletion;
- (UIAlertController *)inputAlertViewWithTitle:(NSString *)title textFieldInfo:(NSDictionary *)info completion:(void (^)(void))completion closeAlertCompletion:(void (^)(NSString *inputString))closeAlertCompletion;
- (UIAlertController *)leftRightAlertViewWithTitle:(NSString *)title message:(NSString *)message leftButton:(NSString *)leftString RightButton:(NSString *)rightString completion:(void (^)(void))completion leftCompletion:(void (^)(void))leftCompletion rightCompletion:(void (^)(void))rightCompletion;

//Abstract method
- (void)setInputData:(id)data;

- (IBAction)back:(id)sender;
- (IBAction)cancel:(id)sender;
@end
