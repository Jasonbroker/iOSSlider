//
//  ZC_ShinningSlider.h
//  BedTime
//
//  Created by Jason on 3/31/15.
//  Copyright (c) 2015 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZC_ShinningSlider : UIControl

@property (nonatomic, assign) BOOL on;

@property (nonatomic, strong) UIImage *slideImg;

@property (nonatomic, strong) UILabel *shimmerLabel;

@property (nonatomic, assign) BOOL shimmmering;

@end
