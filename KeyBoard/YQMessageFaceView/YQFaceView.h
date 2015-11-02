//
//  YQFaceView.h
//  KeyBoard
//
//  Created by 杨雯德 on 15/10/26.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^YQFaceItemDidSelect)(NSString *faceName);
@interface YQFaceView : UIView

@property(nonatomic, strong) YQFaceItemDidSelect faceDidSelect;

-(id)initWithFrame:(CGRect)frame number:(NSInteger)number indexPage:(NSInteger)index;
@end
