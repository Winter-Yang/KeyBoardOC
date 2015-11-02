//
//  YQMessageFaceView.m
//  KeyBoard
//
//  Created by 杨雯德 on 15/10/26.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

#import "YQMessageFaceView.h"
#import "YQFaceView.h"
#define FaceSectionBarHeight  36   // 表情下面控件
#define FacePageControlHeight 30  // 表情pagecontrol
@implementation YQMessageFaceView
{
    UIPageControl * pageControl;
}

-(id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        [self sutFaceViewSubView];
    }
    return self;
}
-(void)sutFaceViewSubView
{
    self.backgroundColor = [UIColor colorWithRed:248.0f/255 green:248.0f/255 blue:255.0f/255 alpha:1.0];
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-FaceSectionBarHeight)];
    scrollView.userInteractionEnabled = YES;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    [scrollView setPagingEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setContentSize:CGSizeMake(CGRectGetWidth(scrollView.frame)*3,CGRectGetHeight(scrollView.frame))];
    [self addSubview:scrollView];
   

    YQFaceView *faceView = [[YQFaceView alloc]initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.bounds)*3,CGRectGetHeight(scrollView.bounds)) number:60 indexPage:3];

    faceView.faceDidSelect = ^(NSString *faceName){
        self.faceDidSelect(faceName);
    };
    [scrollView addSubview:faceView];
    
    pageControl = [[UIPageControl alloc]init];
    [pageControl setFrame:CGRectMake(0,CGRectGetMaxY(scrollView.frame),CGRectGetWidth(self.bounds),FacePageControlHeight)];
    [self addSubview:pageControl];
    [pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [pageControl setCurrentPageIndicatorTintColor:[UIColor grayColor]];
    pageControl.numberOfPages = 3;
    pageControl.currentPage   = 0;
}
#pragma mark  scrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/320;
    pageControl.currentPage = page;
    
}

#pragma mark ZBFaceView Delegate
- (void)didSelecteFace:(NSString *)faceName andIsSelecteDelete:(BOOL)del{
//    if ([self.delegate respondsToSelector:@selector(SendTheFaceStr:isDelete:) ]) {
//        [self.delegate SendTheFaceStr:faceName isDelete:del];
//    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
