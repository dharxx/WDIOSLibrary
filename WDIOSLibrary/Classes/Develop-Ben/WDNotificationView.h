//
//  WDNotificationView.h
//  Pods
//
//  Created by BURIN TECHAMA on 9/1/2559 BE.
//
//

#import <UIKit/UIKit.h>

@class WDNotificationView;

typedef void (^UINotificationViewdidTapped) (WDNotificationView *notificationView);
typedef enum{
    WDNotificationViewStyleLight,
    WDNotificationViewStyleDark
} WDNotificationViewStyle;

@interface WDNotificationView : UIView

@property (nonatomic, copy) UINotificationViewdidTapped viewDidTapped;

-(instancetype)initWithAppName:(NSString *)appname
                      TimeDesc:(NSString *)timedesc
                         Title:(NSString *)title
                      Subtitle:(NSString *)subtitle
                      iconName:(NSString *)iconName
                     timeDelay:(NSTimeInterval)time
                    parentView:(UIView *)parentView
                         style:(WDNotificationViewStyle)style
          usingBlockWhenTapped:(UINotificationViewdidTapped)tapBlock;
-(void)show;
-(void)dismiss;

@end
