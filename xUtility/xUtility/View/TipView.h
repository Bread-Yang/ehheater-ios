//
//  TipView.h
//  xUtility
//
//  Created by Cliff on 12-11-22.
//  Copyright (c) 2012年 Xtremeprog.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol TipViewDelegate;

@interface TipView : UIView

@property (nonatomic, retain) id<TipViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame tip:(NSString*)tip timeout:(NSTimeInterval)_timeout;
- (id)initWithFrame:(CGRect)frame tip:(NSString*)tip timeout:(NSTimeInterval)_timeout fontSize:(int)fontSize;
@end

@protocol TipViewDelegate <NSObject>

@optional
- (void)tipView:(TipView*)view didDestroyTipView:(id)sender;
@end

