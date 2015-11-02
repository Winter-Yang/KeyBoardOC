//
//  YQMessageInputView.m
//  KeyBoard
//
//  Created by 杨雯德 on 15/10/26.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

#import "YQMessageInputView.h"
#define  ViewHeight  36.0f;
@implementation YQMessageInputView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setInputViewBarWithConfig];
    }
    return self;
}
-(void)setConfig
{
    self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
    self.opaque = YES;
    self.userInteractionEnabled = YES;
    self.translatesAutoresizingMaskIntoConstraints = YES;

}
-(void)setInputViewBarWithConfig{
    [self setConfig];
    [self setInputViewBar];
}
-(void)setInputViewBar
{
    //初始化输入框
    self.userInteractionEnabled = YES;
    ZBMessageTextView *textview= [[ZBMessageTextView alloc]init];
    self.messageInputTextView = textview;
    self.messageInputTextView.delegate = self;
    self.messageInputTextView.layer.masksToBounds = YES;
    self.messageInputTextView.layer.cornerRadius = 3;
    self.messageInputTextView.returnKeyType = UIReturnKeySend;
    self.messageInputTextView.enablesReturnKeyAutomatically = YES;  // UITextView内部判断send按钮是否可以用
    self.messageInputTextView.placeHolder = @"发送新评论";
    self.messageInputTextView.backgroundColor = [UIColor whiteColor];
    self.messageInputTextView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.messageInputTextView];

    
    //初始化表情按钮
    UIButton *btn = [self createButtonWithImage:[UIImage imageNamed:@"ToolViewEmotion_ios7"]
                                        HLImage:nil
                                        SLImage:[UIImage imageNamed:@"ToolViewKeyboard_ios7"]];
    self.faceSendButton = btn;
    self.faceSendButton.userInteractionEnabled = YES;
    self.faceSendButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.faceSendButton addTarget:self action:@selector(messageStyleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.faceSendButton.tag = 1;
    [self addSubview:self.faceSendButton];
    
    //设置横坐标和宽度
    NSArray *constraints1=[NSLayoutConstraint
                           constraintsWithVisualFormat:
                           [NSString stringWithFormat:@"H:|-10-[textview(==%f)]-5-[btn(==30)]",self.bounds.size.width-100]
                                                                  options:0
                                                                  metrics:nil
                                                                    views:NSDictionaryOfVariableBindings(textview,btn)];
    //设置纵坐标和高度
    NSArray *constraints2=[NSLayoutConstraint
                           constraintsWithVisualFormat:@"V:|-5-[textview(==30.0)]-(-30)-[btn(==textview)]"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:NSDictionaryOfVariableBindings(textview,btn)];
    [self addConstraints:constraints1];
    [self addConstraints:constraints2];
    
    
    
    
    
    
    
    
    
    
    //初始化表情按钮
    UIButton *btn1 = [self createButtonWithImage:[UIImage imageNamed:@"TypeSelectorBtn_Black_ios7"]
                                        HLImage:nil
                                        SLImage:[UIImage imageNamed:@"TypeSelectorBtn_Black_ios7"]];
    self.multiMediaSendButton = btn1;
    self.multiMediaSendButton.userInteractionEnabled = YES;
    self.multiMediaSendButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.multiMediaSendButton addTarget:self action:@selector(messageStyleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.multiMediaSendButton.tag = 2;
    [self addSubview:self.multiMediaSendButton];
    
    //设置横坐标和宽度
    NSArray *constraints3=[NSLayoutConstraint
                           constraintsWithVisualFormat:
                           [NSString stringWithFormat:@"H:[btn]-5-[btn1(==btn)]"]
                           options:0
                           metrics:nil
                           views:NSDictionaryOfVariableBindings(btn,btn1)];
    //设置纵坐标和高度
    NSArray *constraints4=[NSLayoutConstraint
                           constraintsWithVisualFormat:@"V:[btn]-(-30)-[btn1(==btn)]"
                           options:0
                           metrics:nil
                           views:NSDictionaryOfVariableBindings(btn,btn1)];
    [self addConstraints:constraints3];
    [self addConstraints:constraints4];
    
    


}
#pragma mark - layout subViews UI
- (UIButton *)createButtonWithImage:(UIImage *)image HLImage:(UIImage *)hlImage SLImage:(UIImage *)slImage{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];// [ZBMessageInputView textViewLineHeight], [ZBMessageInputView textViewLineHeight]
    if (image)
        [button setBackgroundImage:image forState:UIControlStateNormal];
    if (hlImage)
        [button setBackgroundImage:hlImage forState:UIControlStateHighlighted];
    if (slImage)
        [button setBackgroundImage:slImage forState:UIControlStateSelected];
    return button;
}
- (void)messageStyleButtonClicked:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            
            break;
        case 1:

            if (self.faceSendButton.selected == NO) {
                self.faceSendButton.selected = YES;
                self.multiMediaSendButton.selected = NO;
                if ([self.delegate respondsToSelector:@selector(didSendFaceAction:)]) {
                    [self.delegate didSendFaceAction:sender.selected];
                }
                
            }else{
                self.faceSendButton.selected = NO;
                [self.messageInputTextView becomeFirstResponder];
            }
            
            break;
        case 2:
            
        {
            self.faceSendButton.selected = NO;
            if ([self.delegate respondsToSelector:@selector(didSendFaceAction:)]) {
                [self.delegate didSelectedMultipleMediaAction:sender.selected];
            }
        }
            

            break;
        default:
            break;
    }
    
    
}

#pragma mark - textViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    if ([self.delegate respondsToSelector:@selector(inputTextViewWillBeginEditing:)])
    {
        [self.delegate inputTextViewWillBeginEditing:self.messageInputTextView];
    }
    self.faceSendButton.selected = NO;
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(inputTextViewDidChange:)]) {
        [self.delegate inputTextViewDidChange:self.messageInputTextView];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
//    [textView becomeFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(inputTextViewDidBeginEditing:)]) {
        [self.delegate inputTextViewDidBeginEditing:self.messageInputTextView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
//        if ([self.delegate respondsToSelector:@selector(didSendTextAction:)]) {
//            [self.delegate didSendTextAction:self.messageInputTextView];
//        }
        return NO;
    }
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
