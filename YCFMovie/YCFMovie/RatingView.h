//
//  RatingView.h
//  RatingViewDemo
//
//  Created by yangchangfu on 15-4-25.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum kRatingViewStyle {
        kSmallStyle  = 0,
        kNormalStyle = 1
} kRatingViewStyle;

@interface RatingView : UIView
{
@private
    UIView         *_baseView; //透明基视图，改变其frame来控制黄色星星的显示
    UILabel        *_ratingLabel; //评级标签
    NSMutableArray *_yellowStarsArray; //存放黄色星星对象
    NSMutableArray *_grayStarsArray; //存放灰色星星对象
}

@property (nonatomic,assign)kRatingViewStyle style; //评级类型
@property (nonatomic,assign)CGFloat          rating; //级数
@property (nonatomic,assign)UIColor          *ratingTextColor; //级数字体颜色

@end
