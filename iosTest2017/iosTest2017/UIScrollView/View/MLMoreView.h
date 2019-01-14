//
//  MLMoreView.h
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MLMoreViewDelegate <NSObject>

- (void)moreViewMoreButtonClicked:(UIButton *)button;

@end

@interface MLMoreView : UIView

@property (strong, nonatomic) UIButton *moreButton;

@property (assign, nonatomic) id<MLMoreViewDelegate> delegate;

@property (assign, nonatomic) CGFloat moreViewWidth;
@end

NS_ASSUME_NONNULL_END
