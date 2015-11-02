//
//  YQMessageShareView.h
//  KeyBoard
//
//  Created by 杨雯德 on 15/10/27.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQMessageShareItem.h"

typedef void(^YQShareDidSelect)(YQShareMoreType shareType);
@interface YQMessageShareView : UIView<UIScrollViewDelegate>
@property (nonatomic, strong) YQShareDidSelect shareDidSelect;
@end
