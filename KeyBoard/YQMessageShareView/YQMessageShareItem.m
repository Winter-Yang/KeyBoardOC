//
//  YQMessageShareItem.m
//  KeyBoard
//
//  Created by 杨雯德 on 15/10/27.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

#import "YQMessageShareItem.h"


@implementation YQMessageShareItem
@synthesize expressButton = _expressButton;
@synthesize expressLabel = _expressLabel;
-(id)init
{
    self =[super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.userInteractionEnabled = YES;
        [self sutSubView];
    }
    return self;
}
-(void)layoutSubviews
{

    [self sutUI];
 
}

-(void)sutSubView
{
   self.expressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.expressButton.frame = CGRectMake(0,0,0,0);
    self.expressButton.layer.masksToBounds = YES;
    self.expressButton.layer.cornerRadius = 3;
    self.expressButton.layer.borderWidth =0.5f;
    self.expressButton.layer.borderColor =[UIColor lightGrayColor].CGColor;
    [self.expressButton addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.expressButton];
    
    UILabel *label = [[UILabel alloc]init];
    self.expressLabel = label;
    self.expressLabel.frame = CGRectMake(0,0,0,0);
    self.expressLabel.textAlignment = NSTextAlignmentCenter;
    self.expressLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:self.expressLabel];

    
}
-(void)shareClick:(id)sender
{
//    / YQSharePhoto            = 0,    // 照片
//    YQShareShoot            = 1,    // 拍摄
//    YQShareVideo            = 2,    // 小视频
//    YQShareVideoChat        = 3,    // 视频聊天
//    YQShareIntercom         = 4,    // 对讲机
//    YQShareTransfer         = 5,    // 转账
//    YQShareLocation         = 6,    // 位置
//    YQShareCollection       = 7,    // 收藏
//    YQShareCard             = 8,    // 个人名片
//    YQShareVoiceInput       = 9,    // 语音输入
//    YQShareCardVolume       = 10,   // 卡卷/
    UIButton *btn = sender;
    YQShareMoreType shareMoreType;
    switch (btn.tag) {
        case 0:
            shareMoreType =  YQSharePhoto;
            break;
        case 1:
            shareMoreType =  YQShareShoot;
            break;
        case 2:
            shareMoreType =  YQShareVideo;
            break;
        case 3:
            shareMoreType =  YQShareVideoChat;
            break;
        case 4:
            shareMoreType =  YQShareIntercom;
            break;
        case 5:
            shareMoreType =  YQShareTransfer;
            break;
        case 6:
            shareMoreType =  YQShareLocation;
            break;
        case 7:
            shareMoreType =  YQShareCollection;
            break;
        case 8:
            shareMoreType =  YQShareCard;
            break;
        case 9:
            shareMoreType =  YQShareVoiceInput;
            break;
        case 10:
            shareMoreType =  YQShareCardVolume;
            break;

        default:
            break;
    }
    self.shareItemDidSelect(shareMoreType);
}
-(void)sutUI
{

    self.expressButton.frame = CGRectMake(0,
                                          0,
                                          self.bounds.size.width,
                                          self.bounds.size.width);
    self.expressLabel.frame = CGRectMake(0,
                                         self.bounds.size.width+5,
                                         self.bounds.size.width,
                                         self.bounds.size.height-self.bounds.size.width-5);
    
   
    
    
    self.expressButton.tag = self.tag;
    self.expressLabel.text = [self.infoDictionary objectForKey:@"text"];
    [self.expressButton setImage:[UIImage imageNamed:[self.infoDictionary objectForKey:@"image"]] forState:UIControlStateNormal];
}
-(void)setInfoDictionary:(NSDictionary *)infoDictionary
{
    if (infoDictionary) {
        _infoDictionary = infoDictionary;
    }
}
-(void)setimage:(UIImage *)image forState:(UIControlState)state
{
    
    self.normalImage = image;
    
//    [self.expressButton setBackgroundImage:image
//                                  forState:state];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
