//
//  WDLightAlertView.h
//  Pods
//
//  Created by BURIN TECHAMA on 9/7/2559 BE.
//
//

#import <UIKit/UIKit.h>

@class WDLightAlertView;

typedef void (^WDLightAlertViewCompletionBlock) (WDLightAlertView *alert);

@interface WDLightAlertView : UIView

@property (nonatomic,copy) WDLightAlertViewCompletionBlock primaryButtonDidTapped;
@property (nonatomic,copy) WDLightAlertViewCompletionBlock secondaryButtonDidTapped;

-(instancetype)initWithTitle:(NSString*)title
                 Description:(NSString*)description
          PrimaryButtonTitle:(NSString*)primaryBottonTitle
                  Completion:(WDLightAlertViewCompletionBlock)buttonDidTapped;

-(void)addSecondaryButtonWithTitle:(NSString*)secondaryButtontitle
                        Completion:(WDLightAlertViewCompletionBlock)buttonDidTapped;

-(void)setBankgroundColor:(UIColor*)color;
-(void)setTitleColor:(UIColor*)color;
-(void)setDescriptionColor:(UIColor*)color;
-(void)setPrimaryButtonTextColor:(UIColor*)color;
-(void)setSecondaryButtonTextColor:(UIColor*)color;
-(void)setPrimaryButtonBackgroundColor:(UIColor*)color;
-(void)setSecondaryButtonBackgroundColor:(UIColor*)color;
-(void)setPrimaryButtonBorderColor:(UIColor*)color;
-(void)setSecondaryButtonBorderColor:(UIColor*)color;

-(void)show;
-(void)dismiss;


@end
