//
//  ViewController.m
//  iOSSlider
//
//  Created by Jason on 4/13/15.
//  Copyright (c) 2015 Jason. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "ZC_ShinningSlider.h"

@interface ViewController ()

@property (nonatomic, strong) ZC_ShinningSlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:iv];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.slider = [[ZC_ShinningSlider alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.slider];
    
    
    self.slider.slideImg = [UIImage imageNamed:@"slider"];
    self.slider.shimmerLabel.text = @"Slide to stop";
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:34.0];
    self.slider.shimmerLabel.font = font;
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view).offset(-100);
        make.width.equalTo(@250);
        make.height.equalTo(@70);
    }];
    [self.slider addTarget:self action:@selector(unlock) forControlEvents:UIControlEventValueChanged];
}

- (void)unlock{
        
        NSLog(@"unlock");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.slider.shimmmering = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
