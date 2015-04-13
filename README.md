ZC_iOSSlider
==================
ZC_iOSSlider is a switch that mimic the iOS unlock homescreen switch "slide to unluck" fuction.

![](demo.gif)

The switch is derived from UIControll.
Use `addtarget` method to do the job you need after unlock it.

Usage
==================
It use masory as autolayout lib and fbshimmeringView for shimmer effect.
Run pod update before running the demo.
```objective-c
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
```
```
- (void)unlock{
    
    NSLog(@"unlock");
}
```