//
//  ToastView.h
//  Pods
//
//  Created by BURIN TECHAMA on 8/29/2559 BE.
//
//

@class ToastView;

typedef enum {
    ToastShowingTimeShort = 1,
    ToastShowingTimeNormal = 3,
    ToastShowingTimeLong = 5
}ToastShowingTime;

typedef void (^UIToastViewCompletionBlock) (ToastView * toastView, NSInteger timer);

@interface ToastView : UIView

@property (nonatomic, copy) UIToastViewCompletionBlock toastDidFinishShowing;

- (instancetype)initWithMessage:(NSString *)message
                       iconName:(NSString *)iconName
                           time:(ToastShowingTime )time
    usingBlockWhenFinishShowing:(UIToastViewCompletionBlock)toastBlock;
- (void)show;

@end
