//
//  WDEmptySteteView.h
//  Pods
//
//  Created by BURIN TECHAMA on 9/6/2559 BE.
//
//

#import <UIKit/UIKit.h>
@class WDEmptyStateView;
typedef void (^tapHandlerBlock) (WDEmptyStateView *view);

@interface WDEmptyStateView : UIView

-(instancetype)initWithTitle:(NSString *)title
                 description:(NSString *)descrpition
                   imageName:(NSString *)imageName;

@property (nonatomic,copy) tapHandlerBlock actionButtondidTabBlock;

-(void)setTextColor:(UIColor *)color;

-(void)setActionButtonTextColor:(UIColor*)textColor AndBackgroundColor:(UIColor*)bgColor;

-(void)addActionButton:(NSString*)buttontitle WithHandler:(tapHandlerBlock)tapBlock;

@end
