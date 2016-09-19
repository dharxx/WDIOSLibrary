//
//  ToastView.h
//  Pods
//
//  Created by BURIN TECHAMA on 8/29/2559 BE.
//
//

@class WDToastView;

typedef enum {
    ToastShowingTimeShort = 1,
    ToastShowingTimeNormal = 3,
    ToastShowingTimeLong = 5
}ToastShowingTime;

typedef void (^UIToastViewCompletionBlock) (WDToastView * toastView, NSInteger timer);

@interface WDToastView : UIView

@property (nonatomic, copy) UIToastViewCompletionBlock toastDidFinishShowing;

- (instancetype)initWithMessage:(NSString *)message
                       iconName:(NSString *)iconName
                           time:(ToastShowingTime )time
    usingBlockWhenFinishShowing:(UIToastViewCompletionBlock)toastBlock;
- (void)show;

@end
