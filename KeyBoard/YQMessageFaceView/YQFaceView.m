//
//  YQFaceView.m
//  KeyBoard
//
//  Created by 杨雯德 on 15/10/26.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

#import "YQFaceView.h"
// 两边边缘间隔
#define EdgeDistance 20
// 上下边缘间隔
#define EdgeInterVal 15
// 表情视图大小
#define FaceWidth 24.0
@implementation YQFaceView
-(id)initWithFrame:(CGRect)frame number:(NSInteger)number indexPage:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *pageOnelastView = nil;
        for (int i = 0;i < number ; i++) {
            UIButton *expressionButton =[UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:expressionButton];
            expressionButton.translatesAutoresizingMaskIntoConstraints = NO;
            NSString *imageStr = [NSString stringWithFormat:@"Expression_%d@2x.png",i+1];
            [expressionButton setBackgroundImage:[UIImage imageNamed:imageStr]
                                        forState:UIControlStateNormal];
            expressionButton.tag = i+1;
            //表情上下间距
            CGFloat verticalInterval = (CGRectGetHeight(self.bounds)-3*FaceWidth-EdgeInterVal*2)/3;
            //表情左右间距
            CGFloat horizontalInterval = (CGRectGetWidth(self.bounds)/3-8*FaceWidth-EdgeDistance*2)/7;
            //每一页第一个表情距离父视图左距离
            CGFloat leftdistance =20+CGRectGetWidth(self.bounds)/3*(i/24);
            if ( pageOnelastView && i%8 != 0)
            {
                //设置每一横排表情的位置
                //设置横坐标和宽度
                NSArray *constraints1=[NSLayoutConstraint
                                       constraintsWithVisualFormat:
                                       [NSString stringWithFormat:@"H:[pageOnelastView]-(%f)-[expressionButton(%f)]",horizontalInterval,FaceWidth]
                                       options:0
                                       metrics:nil
                                       views:NSDictionaryOfVariableBindings(expressionButton,pageOnelastView)];
                //设置纵坐标和高度
                NSArray *constraints2=[NSLayoutConstraint
                                       constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[pageOnelastView]-(-%f)-[expressionButton(%f)]",FaceWidth,FaceWidth]
                                       options:0
                                       metrics:nil
                                       views:NSDictionaryOfVariableBindings(expressionButton,pageOnelastView)];
                [self addConstraints:constraints1];
                [self addConstraints:constraints2];
            }else {
                //设置第一竖排表情的位置
                //设置横坐标和宽度
                NSArray *constraints1=[NSLayoutConstraint
                                       constraintsWithVisualFormat:
                                       [NSString stringWithFormat:@"H:|-%f-[expressionButton(%f)]",leftdistance,FaceWidth]
                                       options:0
                                       metrics:nil
                                       views:NSDictionaryOfVariableBindings(expressionButton)];
                 //设置纵坐标和高度
                NSString * bindView;
                CGFloat vertical;
                NSDictionary<NSString *, id> * views;
                if (pageOnelastView) {
                    bindView = @"[pageOnelastView]";
                    vertical = verticalInterval;
                    views = NSDictionaryOfVariableBindings(expressionButton,pageOnelastView);
                }else{
                    bindView = @"|";
                    vertical = EdgeInterVal;
                    views = NSDictionaryOfVariableBindings(expressionButton);
                }
                
                NSArray *constraints2 = [NSLayoutConstraint
                                         constraintsWithVisualFormat:[NSString stringWithFormat:@"V:%@-(%f)-[expressionButton(%f)]",bindView,vertical,FaceWidth]
                                                             options:0
                                                             metrics:nil
                                                               views:views];

                [self addConstraints:constraints1];
                [self addConstraints:constraints2];

            }
            
            if ((i+1)%24 == 0) {
                pageOnelastView = nil;
            }else{
                pageOnelastView = expressionButton;
            }
            
            [expressionButton addTarget:self
                                 action:@selector(faceClick:)
                       forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}
- (void)faceClick:(UIButton *)button{
    
    NSString *faceName;

    NSString *expressstring = [NSString stringWithFormat:@"Expression_%ld@2x.png",(long)button.tag];
    NSString *plistStr = [[NSBundle mainBundle]pathForResource:@"expression" ofType:@"plist"];
    NSDictionary *plistDic = [[NSDictionary  alloc]initWithContentsOfFile:plistStr];
    
    for (int j = 0; j<[[plistDic allKeys]count]-1; j++)
    {
        if ([[plistDic objectForKey:[[plistDic allKeys]objectAtIndex:j]]
             isEqualToString:[NSString stringWithFormat:@"%@",expressstring]])
        {
            faceName = [[plistDic allKeys]objectAtIndex:j];
        }
    }
  
    self.faceDidSelect(faceName);
//    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelecteFace:andIsSelecteDelete:)]) {
//        [self.delegate didSelecteFace:faceName andIsSelecteDelete:isDelete];
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
