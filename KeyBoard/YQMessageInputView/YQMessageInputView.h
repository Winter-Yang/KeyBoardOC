//
//  YQMessageInputView.h
//  KeyBoard
//
//  Created by 杨雯德 on 15/10/26.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBMessageTextView.h"
@protocol YQMessageInputViewDelegate <NSObject>

@optional

/**
 *  输入框刚好开始编辑
 *
 *  @param messageInputTextView 输入框对象
 */
- (void)inputTextViewDidBeginEditing:(ZBMessageTextView *)messageInputTextView;

/**
 *  输入框将要开始编辑
 *
 *  @param messageInputTextView 输入框对象
 */
- (void)inputTextViewWillBeginEditing:(ZBMessageTextView *)messageInputTextView;

/**
 *  输入框输入时候
 *
 *  @param messageInputTextView 输入框对象
 */
- (void)inputTextViewDidChange:(ZBMessageTextView *)messageInputTextView;

/**
 *  点击语音按钮Action
 */
- (void)didChangeSendVoiceAction:(BOOL)changed;

/**
 *  发送文本消息，包括系统的表情
 *
 *  @param messageInputTextView 输入框对象
 */
- (void)didSendTextAction:(ZBMessageTextView *)messageInputTextView;

/**
 *  点击+号按钮Action
 */
- (void)didSelectedMultipleMediaAction:(BOOL)changed;

/**
 *  按下录音按钮开始录音
 */
- (void)didStartRecordingVoiceAction;

/**
 *  手指向上滑动取消录音
 */
- (void)didCancelRecordingVoiceAction;

/**
 *  松开手指完成录音
 */
- (void)didFinishRecoingVoiceAction;

/**
 *  发送第三方表情
 */
- (void)didSendFaceAction:(BOOL)sendFace;

@end
@interface YQMessageInputView : UIImageView<UITextViewDelegate>

@property (nonatomic,weak) id<YQMessageInputViewDelegate> delegate;

@property (nonatomic, strong) ZBMessageTextView * messageInputTextView;

@property (nonatomic, strong) UIButton * faceSendButton;

@property (nonatomic, strong) UIButton * multiMediaSendButton;
@end
