//
//  WDEmptySteteView.m
//  Pods
//
//  Created by BURIN TECHAMA on 9/6/2559 BE.
//
//

#import "WDEmptyStateView.h"
#import "WDCustomColor.h"

#define MARGIN8 8
#define MARGIN4 4

@interface WDEmptyStateView()
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *descLable;
@property (nonatomic,strong) UIImageView *image;
@property (nonatomic,strong) UIButton *actionButton;
@end

@implementation WDEmptyStateView

-(instancetype)initWithTitle:(NSString *)title description:(NSString *)descrpition imageName:(NSString *)imageName{
    
    self =[super init];
    if (self) {
        [self setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        UIImage *img = [UIImage imageNamed:imageName];
        if (img!=nil) {
            self.image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
            [self.image setFrame:CGRectMake(0, 0, 200, 200)];
            [self.image setCenter:self.center];
            [self.image setContentMode:UIViewContentModeScaleAspectFill];
            [self addSubview:self.image];
        }
        
        self.titleLable = [[UILabel alloc]init];
        [self.titleLable setFont:[UIFont systemFontOfSize:20]];
        [self.titleLable setText:title];
        [self.titleLable sizeToFit];
        [self.titleLable setCenter:self.center];
        [self.titleLable setFrame:CGRectMake(self.titleLable.frame.origin.x,
                                             self.titleLable.frame.origin.y +
                                             self.image.frame.size.height/2,
                                             self.titleLable.frame.size.width,
                                             self.titleLable.frame.size.height)];
        [self addSubview:self.titleLable];
        
        self.descLable = [[UILabel alloc]init];
        [self.descLable setFont:[UIFont systemFontOfSize:14]];
        [self.descLable setNumberOfLines:0];
        [self.descLable setText:descrpition];
        [self.descLable setTextAlignment:NSTextAlignmentCenter];
        [self.descLable sizeToFit];
        [self.descLable setCenter:self.center];
        [self.descLable setFrame:CGRectMake(self.descLable.frame.origin.x,
                                            self.titleLable.frame.origin.y +
                                            self.titleLable.frame.size.height + MARGIN4 ,
                                            self.descLable.frame.size.width,
                                            self.descLable.frame.size.height)];
        [self addSubview:self.descLable];
        
        self.actionButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.actionButton setBackgroundColor:[UIColor lightGrayColor]];
        [self.actionButton setTitleColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateNormal];
    }
    
    return self;
}

-(void)setTextColor:(UIColor *)color{
    [self.titleLable setTextColor:color];
    [self.descLable setTextColor:color];
}

-(void)setActionButtonTextColor:(UIColor*)textColor AndBackgroundColor:(UIColor*)bgColor{
    [self.actionButton setTitleColor:textColor forState:UIControlStateNormal];
    [self.actionButton setBackgroundColor:bgColor];
}

-(void)addActionButton:(NSString*)buttontitle WithHandler:(tapHandlerBlock)tapBlock{

    [self.actionButton setTitle:buttontitle forState:UIControlStateNormal];
    [self.actionButton sizeToFit];
    [self.actionButton setFrame:CGRectMake(0, 0, self.actionButton.frame.size.width + 20,
                                           self.actionButton.frame.size.height)];
    [self.actionButton setCenter:self.center];
    [self.actionButton setFrame:CGRectMake(self.actionButton.frame.origin.x,
                                           self.descLable.frame.origin.y +
                                           self.descLable.frame.size.height + MARGIN8,
                                           self.actionButton.frame.size.width,
                                           self.actionButton.frame.size.height)];
    [self.actionButton.layer setCornerRadius:3];
    
    [self.actionButton addTarget:self action:@selector(actionButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.actionButton];
    
    self.actionButtondidTabBlock = tapBlock;
}

-(void)actionButtonDidTapped:(UIButton *)sender{
    if (self.actionButtondidTabBlock != nil) {
        self.actionButtondidTabBlock(self);
    }
}

@end
