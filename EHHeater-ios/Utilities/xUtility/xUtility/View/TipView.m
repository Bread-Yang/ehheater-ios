//
//  TipView.m
//  xUtility
//
//  Created by Cliff on 12-11-22.
//  Copyright (c) 2012年 Xtremeprog.com. All rights reserved.
//

#import "TipView.h"
#import "DeviceUtil.h"

@interface TipView()
{
    NSTimeInterval timeout;
}
@end

@implementation TipView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame tip:(NSString*)tip timeout:(NSTimeInterval)_timeout
{
    return [self initWithFrame:frame tip:tip timeout:_timeout fontSize:0];
}

- (id)initWithFrame:(CGRect)frame tip:(NSString*)tip timeout:(NSTimeInterval)_timeout fontSize:(int)fontSize
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 5;
        self.layer.masksToBounds = YES;
        
        timeout = _timeout;
        CGRect labelFrame;
        
        UILabel *label = [[[UILabel alloc] init]autorelease];

        if ([deviceUtil iPhone])
        {
            labelFrame = CGRectMake(0, frame.size.height / 2 -15, frame.size.width, 30);
            if (fontSize <= 0)
            {
                label.font = [UIFont systemFontOfSize:24];
            }
            else
            {
                label.font = [UIFont systemFontOfSize:fontSize];
            }
        }
        else
        {
            labelFrame = CGRectMake(0, frame.size.height / 2 -30, frame.size.width, 60);
            if (fontSize <= 0)
            {
                label.font = [UIFont systemFontOfSize:64];
            }
            else
            {
                label.font = [UIFont systemFontOfSize:fontSize];
            }
        }
        
        label.frame = labelFrame;
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        
        [label setText:tip];
        [self addSubview:label];
        
        [self addGesture];
        
        [self performSelectorOnMainThread:@selector(autoClose) withObject:nil waitUntilDone:YES];
    }
        
    return self;
}

- (void)addGesture
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(destroy:)];
    [self addGestureRecognizer:recognizer];
    [recognizer release];
}

- (void)autoClose
{
    [self performSelector:@selector(doClose) withObject:nil afterDelay:timeout];
}

- (void)doClose
{
    if(delegate && [delegate respondsToSelector:@selector(tipView:didDestroyTipView:)])
    {
        [delegate tipView:self didDestroyTipView:nil];
    }

    [self removeFromSuperview];
}

- (void)destroy:(UIGestureRecognizer*)recognizer
{
    [self doClose];
}

@end
