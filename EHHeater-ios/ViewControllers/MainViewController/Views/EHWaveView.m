//
//  EHWaveView.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-11.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHWaveView.h"

@interface EHWaveView()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation EHWaveView

#pragma mark -- Life cycle

- (void)setUpSubViews{
    if (!self.imageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:imageView];
        self.imageView = imageView;
    }
}

- (void)viewLoadRoutine{
    self.backgroundColor = [UIColor clearColor];
    UIImage *defaultImg = [UIImage imagePNGName:@"wave1"];
    [self.imageView setImage:defaultImg];
}

- (void)awakeFromNib{
    [self setUpSubViews];
    [self viewLoadRoutine];
    [self startWaveAnimate];
}

#pragma mark -- Private

- (NSArray *)animateImages{
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 1; i <= 19; i++) {
        NSString *name = [NSString stringWithFormat:@"wave%i",i];
        UIImage *img = [UIImage imagePNGName:name];
        [temp addObject:img];
    }
    return temp;
}

#pragma mark -- Public

- (void)startWaveAnimate{
    if (!self.imageView.isAnimating) {
        self.imageView.animationImages = [self animateImages];
        self.imageView.animationRepeatCount = 0;
        self.imageView.animationDuration = 1;
        [self.imageView startAnimating];
    }
}

- (void)stopWaveAnimate{
    if (self.imageView.isAnimating) {
        [self.imageView stopAnimating];
    }
}

@end
