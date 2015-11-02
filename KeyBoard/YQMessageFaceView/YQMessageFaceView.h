//
//  YQMessageFaceView.h
//  KeyBoard
//
//  Created by 杨雯德 on 15/10/26.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef  void(^YQFaceDisSelect)(NSString *faceName);
@interface YQMessageFaceView : UIView<UIScrollViewDelegate>

@property(nonatomic, strong) YQFaceDisSelect faceDidSelect;

@end
