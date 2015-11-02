//
//  YQMessageShareView.m
//  KeyBoard
//
//  Created by 杨雯德 on 15/10/27.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

#import "YQMessageShareView.h"
#define SharePageControlHeight 15  // 表情pagecontrol
// 两边边缘间隔
#define EdgeDistance 30
// 上下边缘间隔
#define EdgeInterVal 15
// 表情视图大小
#define ShareItemWidth 60.0
#define ShareItemHeight 80.0
@implementation YQMessageShareView
{
    UIPageControl * pageControl;
    UIScrollView  * backScrollView;
    NSArray  * shareMoreArray;
}

-(id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        [self dataSource];
        self.userInteractionEnabled = YES;
        [self sutFaceViewSubView];
    }
    return self;
}
-(void)dataSource
{
    shareMoreArray = @[@{@"image":@"sharemore_pic",
                         @"text":@"照片"},
                       @{@"image":@"sharemore_video",
                         @"text":@"拍摄"},
                       @{@"image":@"sharemore_sight",
                         @"text":@"小视频"},
                       @{@"image":@"sharemore_videovoip",
                         @"text":@"视频聊天"},
                       @{@"image":@"sharemore_wxtalk",
                         @"text":@"对讲机"},
                       @{@"image":@"sharemorePay",
                         @"text":@"转账"},
                       @{@"image":@"sharemore_location",
                         @"text":@"位置"},
                       @{@"image":@"sharemore_myfav",
                         @"text":@"收藏"},
                       @{@"image":@"sharemore_friendcard",
                         @"text":@"个人名片"},
                       @{@"image":@"sharemore_voiceinput",
                         @"text":@"语音输入"},
                       @{@"image":@"sharemore_wallet",
                         @"text":@"卡卷 "}];
}
-(void)sutFaceViewSubView
{
    self.backgroundColor = [UIColor colorWithRed:248.0f/255 green:248.0f/255 blue:255.0f/255 alpha:1.0];
    backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-SharePageControlHeight)];
    backScrollView.userInteractionEnabled = YES;
    backScrollView.delegate = self;
    [backScrollView setPagingEnabled:YES];
    [backScrollView setShowsHorizontalScrollIndicator:NO];
    [backScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.bounds)*2,CGRectGetHeight(backScrollView.frame))];
    [self addSubview:backScrollView];
    
    [self setShareItem];
    pageControl = [[UIPageControl alloc]init];
    [pageControl setFrame:CGRectMake(0,CGRectGetMaxY(backScrollView.frame),CGRectGetWidth(self.bounds),SharePageControlHeight)];
    [self addSubview:pageControl];
    [pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [pageControl setCurrentPageIndicatorTintColor:[UIColor blueColor]];
    pageControl.numberOfPages = 2;
    pageControl.currentPage   = 0;
}
#pragma mark  scrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/CGRectGetWidth(self.bounds);
    pageControl.currentPage = page;
    
}
-(void)setShareItem
{
    YQMessageShareItem *pageOnelastView = nil;
    for (int i = 0;i < shareMoreArray.count ; i++) {
        YQMessageShareItem *expressionItem =[[YQMessageShareItem alloc] init];
        [backScrollView addSubview:expressionItem];
        expressionItem.infoDictionary = [shareMoreArray objectAtIndex:i];
        expressionItem.tag = i;

        //表情上下间距
        CGFloat verticalInterval = CGRectGetHeight(backScrollView.bounds)-ShareItemHeight*2-EdgeInterVal*2;
        //表情左右间距
        CGFloat horizontalInterval = (CGRectGetWidth(backScrollView.bounds)-4*ShareItemWidth-EdgeDistance*2)/3;
        //每一页第一个表情距离父视图左距离
        CGFloat leftdistance =EdgeDistance+CGRectGetWidth(self.bounds)*(i/8);
        if ( pageOnelastView && i%4 != 0)
        {
            //设置每一横排表情的位置
            //设置横坐标和宽度
            NSArray *constraints1=[NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   [NSString stringWithFormat:@"H:[pageOnelastView]-(%f)-[expressionItem(%f)]",horizontalInterval,ShareItemWidth]
                                   options:0
                                   metrics:nil
                                   views:NSDictionaryOfVariableBindings(expressionItem,pageOnelastView)];
            //设置纵坐标和高度
            NSArray *constraints2=[NSLayoutConstraint
                                   constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[pageOnelastView]-(-%f)-[expressionItem(%f)]",ShareItemHeight,ShareItemHeight]
                                   options:0
                                   metrics:nil
                                   views:NSDictionaryOfVariableBindings(expressionItem,pageOnelastView)];
            [self addConstraints:constraints1];
            [self addConstraints:constraints2];
        }else {
            //设置第一竖排表情的位置
            //设置横坐标和宽度
            NSArray *constraints1=[NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   [NSString stringWithFormat:@"H:|-%f-[expressionItem(%f)]",leftdistance,ShareItemWidth]
                                   options:0
                                   metrics:nil
                                   views:NSDictionaryOfVariableBindings(expressionItem)];
            //设置纵坐标和高度
            NSString * bindView;
            CGFloat vertical;
            NSDictionary<NSString *, id> * views;
            if (pageOnelastView) {
                bindView = @"[pageOnelastView]";
                vertical = verticalInterval;
                views = NSDictionaryOfVariableBindings(expressionItem,pageOnelastView);
            }else{
                bindView = @"|";
                vertical = EdgeInterVal;
                views = NSDictionaryOfVariableBindings(expressionItem);
            }
            
            NSArray *constraints2 = [NSLayoutConstraint
                                     constraintsWithVisualFormat:[NSString stringWithFormat:@"V:%@-(%f)-[expressionItem(%f)]",bindView,vertical,ShareItemHeight]
                                     options:0
                                     metrics:nil
                                     views:views];
            
            [self addConstraints:constraints1];
            [self addConstraints:constraints2];
            
        }
        
        if ((i+1)%8 == 0) {
            pageOnelastView = nil;
        }else{
            pageOnelastView = expressionItem;
        }
        
        
        expressionItem.infoDictionary = [shareMoreArray objectAtIndex:i];
        expressionItem.expressButton.tag = i;
        expressionItem.shareItemDidSelect = ^(YQShareMoreType shareMoreType){
            self.shareDidSelect(shareMoreType);
        };
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
