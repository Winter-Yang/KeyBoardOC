//
//  YQMessageMenuBar.h
//  KeyBoard
//
//  Created by 杨雯德 on 15/10/26.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQMessageInputView.h"
#import "YQMessageShareView.h"
#import "YQMessageFaceView.h"

typedef NS_ENUM(NSInteger,ZBMessageViewState) {
    ZBMessageViewStateShowFace,
    ZBMessageViewStateShowShare,
    ZBMessageViewStateShowNone,
};






@protocol YQMessageMenuBarDelegate <NSObject>

//- (void)messageViewAnimationWithMessageRect:(CGRect)rect andState:(ZBMessageViewState)state;

@end
@interface YQMessageMenuBar : UIView<YQMessageInputViewDelegate>
{
    CGRect keyboardRect;
    CGRect oldRect;
}
@property(nonatomic, weak)id<YQMessageMenuBarDelegate>delegate;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) YQMessageInputView *messageToolView;
@property (nonatomic, strong) YQMessageFaceView * faceView;
@property (nonatomic, strong) YQMessageShareView * shareView;
-(void)dissMissBar;
@end
