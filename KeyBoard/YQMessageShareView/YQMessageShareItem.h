//
//  YQMessageShareItem.h
//  KeyBoard
//
//  Created by 杨雯德 on 15/10/27.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    
    YQSharePhoto            = 0,    // 照片
    YQShareShoot            = 1,    // 拍摄
    YQShareVideo            = 2,    // 小视频
    YQShareVideoChat        = 3,    // 视频聊天
    YQShareIntercom         = 4,    // 对讲机
    YQShareTransfer         = 5,    // 转账
    YQShareLocation         = 6,    // 位置
    YQShareCollection       = 7,    // 收藏
    YQShareCard             = 8,    // 个人名片
    YQShareVoiceInput       = 9,    // 语音输入
    YQShareCardVolume       = 10,   // 卡卷

}YQShareMoreType;


typedef void(^YQShareItemDidSelect)(YQShareMoreType shareType);

@interface YQMessageShareItem : UIView
@property (nonatomic, strong) YQShareItemDidSelect shareItemDidSelect;
@property (nonatomic, strong) UIButton *expressButton;
@property (nonatomic, strong) UILabel *expressLabel;
@property (nonatomic, strong) NSDictionary * infoDictionary;
@property (nonatomic, strong) UIImage *normalImage;
-(void)setimage:(UIImage *)image forState:(UIControlState)state;

@end
