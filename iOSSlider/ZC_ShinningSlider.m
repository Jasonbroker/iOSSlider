//
//  ZC_ShinningSlider.m
//  BedTime
//
//  Created by Jason on 3/31/15.
//  Copyright (c) 2015 Jason. All rights reserved.
//

#import "ZC_ShinningSlider.h"
#import <Masonry/Masonry.h>
#import "FBShimmeringView.h"

@interface ZC_ShinningSlider()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) FBShimmeringView *shimmerView;

@end

@implementation ZC_ShinningSlider


@synthesize shimmmering = _shimmmering;
/*
 
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    
       self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setSlideImg:(UIImage *)slideImg{
    
    _slideImg = slideImg;
    
    self.shimmerView = [[FBShimmeringView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.shimmerView];

    self.shimmerView.shimmeringSpeed = 100;
    
    self.shimmerLabel = [[UILabel alloc] initWithFrame:CGRectZero];

    self.shimmerLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.shimmerLabel];
    self.shimmerLabel.textColor = [UIColor whiteColor];
    
    [self.shimmerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.shimmerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.shimmerLabel).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.shimmerView.contentView = self.shimmerLabel;
    
    self.imgView = [[UIImageView alloc] initWithImage:slideImg];
    [self addSubview:self.imgView];
//    self.imgView.userInteractionEnabled = YES;
    self.imgView.alpha = 0.6;
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self);
        //        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.centerY.equalTo(self);
        make.width.equalTo(@(slideImg.size.width));
        make.height.equalTo(@(slideImg.size.height));
        //                make.width.equalTo(@(30));
        
    }];

    [self layoutIfNeeded];
    
}
- (void)commonInit{
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [self addGestureRecognizer:pan];
    
}

- (void)pan:(UIPanGestureRecognizer *)panRecognizer{
    
    CGFloat translationX = [panRecognizer translationInView:self].x;
    
    switch(panRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
//            if(_on && translationX < 0.0f)
//            {
//                imgVw.frame = CGRectMake(translationX, 0,
//                                         imgVw.frame.size.width, imgVw.frame.size.height);
//            }
//            else if(!_on && translationX > 0.0f)
//            {
//                imgVw.frame = CGRectMake(gestureStartXOffset + translationX, 0,
//                                         imgVw.frame.size.width, imgVw.frame.size.height);
//            }
            
            if (!_on && translationX>0) {
                [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self).offset(translationX);
                }];
            }else if (!_on && translationX<0){
                [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self);
                }];
            }else if (_on && translationX>0){
                [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self);
                }];
            }else if (_on && translationX<0){
                [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self).offset(translationX);
                }];

            }

        }
            break;
            
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded:
        {
            //            if((translationX < 0.0f && ABS(translationX) > _visibleWidth/4) ||
            //               (!_on && translationX > 0.0f && ABS(translationX) > _visibleWidth/4))
            //                self.on = !_on;
            //            else
            //                self.on = _on;
            CGFloat width = self.bounds.size.width;
            
            if (!_on && translationX<= width*0.3) {
                [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self);
                }];
            }else if(!_on && translationX >width*0.3){
                [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self);
                    //        make.bottom.equalTo(self.mas_bottom).offset(-10);
                    make.centerY.equalTo(self);
                    make.width.equalTo(@(self.slideImg.size.width));
                    make.height.equalTo(@(self.slideImg.size.height));
                }];
                self.on = !_on;
            }else if (_on && translationX >= -width*0.3){
                [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self);
                }];
            }else if (_on && translationX < -width*0.3){
                [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self);
                    //        make.bottom.equalTo(self.mas_bottom).offset(-10);
                    make.centerY.equalTo(self);
                    make.width.equalTo(@(self.slideImg.size.width));
                    make.height.equalTo(@(self.slideImg.size.height));
                }];
                self.on = !_on;
            }
            
            [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.userInteractionEnabled = NO;
                [self.imgView layoutIfNeeded];
                
            }completion:^(BOOL finished){
                self.userInteractionEnabled = YES;
            }];
            
            
        }

        case UIGestureRecognizerStateCancelled:
        {
            /*
            CGFloat width = self.bounds.size.width;
            if (translationX > 0) {
                if (translationX > width* 0.3) {
                    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        //        make.top.equalTo(self.mas_top).offset(10);
//                        make.left.equalTo(self);
                        make.right.equalTo(self);
                        //        make.bottom.equalTo(self.mas_bottom).offset(-10);
                        make.centerY.equalTo(self);
                        make.width.equalTo(@(self.slideImg.size.width));
                        make.height.equalTo(@(self.slideImg.size.height));
                        //                make.width.equalTo(@(30));
                        self.on = !_on;
                        
                    }];
                }else{
                    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self);
                    }];
                    
                }
            }else{
                
                if (ABS(translationX) > width* 0.3) {
                    
                    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(self);
                        //        make.bottom.equalTo(self.mas_bottom).offset(-10);
                        make.centerY.equalTo(self);
                        make.width.equalTo(@(self.slideImg.size.width));
                        make.height.equalTo(@(self.slideImg.size.height));
                        //                make.width.equalTo(@(30));
                        
                    }];
                    self.on = !_on;

                }else{
                    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self);
                    }];
                }
            }
            
            [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                 self.userInteractionEnabled = NO;
                 [self.imgView layoutIfNeeded];
                
            }completion:^(BOOL finished){
                self.userInteractionEnabled = YES;
                                 
            }];
*/

        }
            break;
            
        default:
            break;
    }

    
}

- (void)setShimmmering:(BOOL)shimmmering{
    
    self.shimmerView.shimmering = shimmmering;
    
    _shimmmering = shimmmering;
}

- (BOOL)shimmmering{
    
    return self.shimmerView.shimmering;
}

-(void)setOn:(BOOL)on
{
    BOOL valueChanged = (_on != on);
    _on = on;
    
         if(valueChanged) [self sendActionsForControlEvents:UIControlEventValueChanged];
}
@end
