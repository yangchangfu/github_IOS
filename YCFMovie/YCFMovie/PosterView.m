//
//  PosterView.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-28.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "PosterView.h"
#import "MovieModel.h"
#import "RatingView.h"
//#import "TestMaskView.h"

#define kFooterViewHeight       40
#define kContentViewWidth       260
#define kHeaderViewHiddedHeight 100
#define kHiddenHeaderViewGas    0
#define kHeaderViewIndexWidth   60

@interface PosterView ()

// 头部视图
- (void)initHeaderView;
// 内容视图
- (void)initContentView;
// 尾部视图
- (void)initFooterView;
// 遮罩视图
- (void)initMaskView;


// 设置内容视图
- (void)setContentView;
// 加载索引视图的小图片
- (void)downLoadIndexImages;
// 更新浏览大图，索引视图，title标签的显示
- (void)updateContentView:(NSInteger)index;

@end

@implementation PosterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化子视图
        [self initHeaderView];
        [self initContentView];
        [self initFooterView];
        
        //调整视图层次结构
        [self bringSubviewToFront:_headerView];
    }
    return self;
}

#pragma mark - Private Methods

// 头部视图
- (void)initHeaderView
{
    //头部基视图
    _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kHeaderViewHiddedHeight, kDeviceWidth, 26+kHeaderViewHiddedHeight)];
    _headerView.userInteractionEnabled = YES;//用户交互
    //_headerView.backgroundColor = [UIColor redColor];
    UIImage *original = [UIImage imageNamed:@"indexBG_home"];
    UIImage *newImage = [original stretchableImageWithLeftCapWidth:original.size.width/2.0 topCapHeight:1];
    _headerView.image = newImage;
    [self addSubview:_headerView];
    
    //小button按钮
    _headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerButton.frame = CGRectMake(160-26/2.0+3, 2+kHeaderViewHiddedHeight, 26, 26);
    [_headerButton setImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
    [_headerButton addTarget:self action:@selector(pullDownOrPullUp) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_headerButton];
    
    //索引视图 _headerScrollView
    _headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth,kHeaderViewHiddedHeight)];
    _headerScrollView.delegate = self;//设置代理
    _headerScrollView.decelerationRate = 0.1;//减速滑动
    _headerScrollView.showsHorizontalScrollIndicator = NO;
    //_headerScrollView.backgroundColor = [UIColor redColor];
    [_headerView addSubview:_headerScrollView];
}

// 内容视图
- (void)initContentView
{
    // 内容视图的基视图
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(30, _headerView.bottom, kContentViewWidth, kDeviceHeight-20-44-49-(_headerView.height-kHeaderViewHiddedHeight)-kFooterViewHeight)];
    //_contentView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_contentView];
    
    // 滑动的浏览视图
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kContentViewWidth, _contentView.height)];
    _contentScrollView.delegate = self;//设置代理
    _contentScrollView.clipsToBounds = NO;
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    //_contentScrollView.backgroundColor = [UIColor cyanColor];
    [_contentView addSubview:_contentScrollView];
}

// 底部视图
- (void)initFooterView
{
    _footerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _contentView.bottom, kDeviceWidth, kFooterViewHeight)];
    //_footerView.backgroundColor = [UIColor grayColor];
    _footerView.image = [UIImage imageNamed:@"poster_title_home"];
    [self addSubview:_footerView];
    
    _footTitleLabel = [[UILabel alloc] initWithFrame:_footerView.bounds];
    _footTitleLabel.backgroundColor = [UIColor clearColor];
    _footTitleLabel.textColor = [UIColor whiteColor];
    _footTitleLabel.textAlignment = NSTextAlignmentCenter;
    _footTitleLabel.font = [UIFont boldSystemFontOfSize:20];
    [_footerView addSubview:_footTitleLabel];
    
    //使用scrollview代理来更新text
}

// 遮罩视图
- (void)initMaskView
{
//    if ([_maskView superview]) {
//     }
    
    //使用点语法，会先释放旧对象，才创建新的对象
    self.maskView = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
    _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self insertSubview:_maskView aboveSubview:_contentView];
    
    //添加一个单击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pullDownOrPullUp)];
    [_maskView addGestureRecognizer:singleTap];
    [singleTap release];
}

////////////////////////////////////

// 设置内容视图
- (void)setContentView
{
    //初始化设置尾部视图的title
    _footTitleLabel.text = [[self.posterData[0] subject] objectForKey:@"title"];
    
    //内容视图
    int gas = kDeviceHeight == 568 ? 10:20; //间隔大小 － 适配手机iphone 4s/5s
    int cnt = kDeviceHeight == 568 ? 15:5;
    
    int x=0;
    for (int index=0; index<self.posterData.count; index++) {
        
        //取出模型数据
        MovieModel *movieModel = self.posterData[index];
        
        //初始化翻转的基视图
        UIView *flipBaseView = [[UIView alloc] initWithFrame:CGRectMake(gas+x, 10, kContentViewWidth-2*gas, _contentScrollView.height-20)];
        //flipBaseView.backgroundColor = [UIColor redColor];
        flipBaseView.tag = 101;
        [_contentScrollView addSubview:flipBaseView];
        [flipBaseView release];
        
        // 添加单击事件
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipViewAction:)];
        [flipBaseView addGestureRecognizer:singleTap];
        [singleTap release];
        
        //详细页面视图
        UIView *detailView = [[UIView alloc] initWithFrame:flipBaseView.bounds];
        detailView.backgroundColor = [UIColor orangeColor];
        [flipBaseView addSubview:detailView];
        [detailView release];
        
        //详细页面的小图视图
        UIImageView *smallview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 100, 150)];
        [detailView addSubview:smallview];
        [smallview release];
        //获取网络图片，并设置给图片视图
        NSString *mediumImgURL = [[movieModel.subject objectForKey:@"images"] objectForKey:@"medium"];
        [smallview setImageWithURL:[NSURL URLWithString:mediumImgURL]];
        
        //中文名称
        UILabel *chineseTitle = [[UILabel alloc] initWithFrame:CGRectMake(smallview.right+10, smallview.top, detailView.width-smallview.width-30, 50)];
        chineseTitle.font = [UIFont boldSystemFontOfSize:15];
        chineseTitle.numberOfLines = 0;
        //chineseTitle.adjustsFontSizeToFitWidth = YES;
        chineseTitle.text = [NSString stringWithFormat:@"中文名:%@",[movieModel.subject objectForKey:@"title"]];
        [detailView addSubview:chineseTitle];
        [chineseTitle release];
        //英文名称
        UILabel *englishTitle = [[UILabel alloc] initWithFrame:CGRectMake(smallview.right+10, chineseTitle.bottom, detailView.width-smallview.width-30, 70)];
        englishTitle.font = [UIFont boldSystemFontOfSize:15];
        englishTitle.numberOfLines = 0;
        englishTitle.text = [NSString stringWithFormat:@"英文名:%@",[movieModel.subject objectForKey:@"original_title"]];
        [detailView addSubview:englishTitle];
        [englishTitle release];
        //年份标签
        UILabel *yearTitle = [[UILabel alloc] initWithFrame:CGRectMake(smallview.right+10, englishTitle.bottom, detailView.width-smallview.width-30, 30)];
        yearTitle.font = [UIFont boldSystemFontOfSize:15];
        yearTitle.numberOfLines = 0;
        yearTitle.text = [NSString stringWithFormat:@"年    份:%@",[movieModel.subject objectForKey:@"year"]];
        [detailView addSubview:yearTitle];
        [yearTitle release];
        //评级视图
        RatingView *ratingView = [[RatingView alloc] initWithFrame:CGRectMake(cnt, smallview.bottom+40, 0, 0)];
        ratingView.style = kNormalStyle;
        ratingView.ratingTextColor = [UIColor cyanColor];
        ratingView.rating = [[[movieModel.subject objectForKey:@"rating"] objectForKey:@"average"] floatValue];
        [detailView addSubview:ratingView];
        [ratingView release];
        
        //浏览页面的图片视图
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:flipBaseView.bounds];
        [flipBaseView addSubview:imgview];
        [imgview release];
        //获取网络图片，并设置给图片视图
        NSString *largeImgURL = [[movieModel.subject objectForKey:@"images"] objectForKey:@"large"];
        [imgview setImageWithURL:[NSURL URLWithString:largeImgURL]];
        
        x += kContentViewWidth;
    }
    
    _contentScrollView.contentSize = CGSizeMake(x, _contentScrollView.height);
}

// 加载索引视图
- (void)downLoadIndexImages
{
    int x=0;
    for (int index=0; index<[self.posterData count]; index++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(130+x, 5, kHeaderViewIndexWidth, kHeaderViewHiddedHeight-10)];
        //imgView.backgroundColor = [UIColor orangeColor];
        
        //网络获取图片
        MovieModel *movieModel = self.posterData[index];
        NSString *imgURL = [[movieModel.subject objectForKey:@"images"] objectForKey:@"medium"];
        [imgView setImageWithURL:[NSURL URLWithString:imgURL]];
        
        [_headerScrollView addSubview:imgView];
        [imgView release];
        
        x += (kHeaderViewIndexWidth+10);
    }
    
    //设置内容大小
    _headerScrollView.contentSize = CGSizeMake(120+[self.posterData count]*(kHeaderViewIndexWidth+10)+130, kHeaderViewHiddedHeight);
}

// 更新浏览大图，索引视图，title标签的显示
- (void)updateContentView:(NSInteger)index
{
    //冗余错误判断,防止数组越界
    if(index < 0 || index >= [self.posterData count]) {
        //return;
        index = 0;
    }
    
    //取得模型数据
    MovieModel *movieModel = self.posterData[index];
    
    //使用代理方法，更新title的标签
    _footTitleLabel.text = [movieModel.subject objectForKey:@"title"];
    
    // 更新索引视图的显示
    [_headerScrollView setContentOffset:CGPointMake((kHeaderViewIndexWidth+10)*index,0) animated:YES];
    
    // 更新浏览大图的显示
    [_contentScrollView setContentOffset:CGPointMake(kContentViewWidth*index,0) animated:YES];
}

#pragma mark - Public Methods

// 更新加载海报视图数据－设置内容视图
- (void)reloadPosterData:(NSArray *) data
{
    self.posterData = data;
    
    // 设置内容视图
    [self setContentView];
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSInteger index=0;
    
    if (!decelerate)
    {
        if (scrollView == _headerScrollView)
        {
            // 获得索引图的索引位置
            index = floorf((_headerScrollView.contentOffset.x - 35)/70 + 1);
        }
        else if (scrollView == _contentScrollView)
        {
            // 获得大图的索引位置
            index = scrollView.contentOffset.x/kContentViewWidth;
        }
        else
        {
            return;
        }
        
        //更新显示
        [self updateContentView:index];
    }
    else
    {
        return;
    }
}

// 手势释放，减速结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = 0;
    
    if (scrollView == _headerScrollView)
    {
        // 获得索引图的索引位置
        index = floorf((_headerScrollView.contentOffset.x - 35)/70 + 1);
    }
    else if (scrollView == _contentScrollView)
    {
        // 获得大图的索引位置
        index = scrollView.contentOffset.x/kContentViewWidth;
    }
    else
    {
        return;
    }
    
    //更新显示
    [self updateContentView:index];
}

#pragma mark - Target Actions

//bool flag = NO;
- (void)flipViewAction:(UITapGestureRecognizer *)Gesture
{
    UIView *baseView = [Gesture view];
    
    [UIView beginAnimations:@"Flip" context:NULL];
    [UIView setAnimationDuration:0.5];
    
    //[UIView setAnimationDelegate:self];
    //[UIView setAnimationTransition:flag ?UIViewAnimationTransitionFlipFromLeft:UIViewAnimationTransitionFlipFromRight forView:baseView cache:YES];
    
    if (baseView.tag == 101) {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:baseView cache:YES];
        baseView.tag = 102;
    } else {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:baseView cache:YES];
        baseView.tag = 101;
    }

    [baseView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    [UIView commitAnimations];
}

- (void)pullDownOrPullUp
{
    //配置动画
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    //当弹出头部视图的隐藏部分，就让它实现隐藏，否则弹出
    if (_headerView.top == kHiddenHeaderViewGas) {
        _headerView.top = -kHeaderViewHiddedHeight;
        [_headerButton setImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
        
        //[_maskView removeFromSuperview];
        //延时3秒，移除遮罩视图
        [_maskView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.2];
    } else {
        _headerView.top = 0;
        [_headerButton setImage:[UIImage imageNamed:@"up_home"] forState:UIControlStateNormal];
        
        [self initMaskView];//添加遮罩视图
        
        //加载索引视图  
        //if ([_headerScrollView.subviews count] == 0) {
            [self downLoadIndexImages];
        //}
    }
    
    [UIView commitAnimations];//动画结束
}

#pragma mark - Animation Delegate
/*
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"Flip"]) {
        flag = flag? NO:YES;
    }
}
 */

#pragma mark - Memory

- (void)dealloc
{
    [_headerView release],_headerView = nil;
    [_contentView release],_contentView = nil;
    [_footerView release],_footerView = nil;
    [_contentScrollView release],_contentScrollView = nil;
    [_footTitleLabel release],_footTitleLabel = nil;
    [_headerButton release],_headerButton = nil;
    self.posterData = nil;
    self.maskView = nil;
       
    [_headerScrollView release],_headerScrollView = nil;
    
    [super dealloc];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
