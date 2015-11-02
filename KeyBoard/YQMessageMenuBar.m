//
//  YQMessageMenuBar.m
//  KeyBoard
//
//  Created by 杨雯德 on 15/10/26.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

#import "YQMessageMenuBar.h"

@implementation YQMessageMenuBar
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        self.userInteractionEnabled = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}
-(void)setUI
{
    self.messageToolView = [[YQMessageInputView alloc]initWithFrame:CGRectMake(0,0,self.bounds.size.width, 40)];
    self.messageToolView.delegate = self;
    self.messageToolView.userInteractionEnabled = YES;
    self.messageToolView.backgroundColor =HexRGB(0xceced0);
    [self addSubview:self.messageToolView];

    [self shareFaceView];
    [self shareShareView];

}
-(void)keyboardWillShow:(NSNotification *)note
{

    NSDictionary * userInfo = note.userInfo;
    CGRect keyBoardBounds = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = keyBoardBounds;
    oldRect = keyboardRect;
    double duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat deltay = keyBoardBounds.size.height;
    void (^animations)(void);
    animations = ^(void){
        if (self.frame.size.height > 50) {
    
        }else{
            self.messageToolView.transform = CGAffineTransformMakeTranslation(0, -deltay);
        }
    };
    if (duration>0) {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionTransitionNone animations:animations completion:nil];
    }else{
        animations();
    }
}

-(void)keyboardWillHide:(NSNotification *)note
{
    NSDictionary * userInfo = note.userInfo;
    keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    oldRect = keyboardRect;
    double duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    void (^animations)(void);
    animations = ^(void){
        self.messageToolView.transform = CGAffineTransformIdentity;
    };
    if (duration>0) {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:animations completion:nil];
    }else{
        animations();
    }
}
- (void)keyboardChange:(NSNotification *)notification{
    if ([[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y<CGRectGetHeight(self.frame)) {
        [self messageViewAnimationWithMessageRect:[[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]
                         withMessageInputViewRect:self.messageToolView.frame
                                      andDuration:0.25
                                         andState:ZBMessageViewStateShowNone];
    }
}
-(void)shareFaceView
{
    if (!self.faceView)
    {
        self.faceView = [[YQMessageFaceView alloc]initWithFrame:CGRectMake(0.0f,
                                                                           CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 196)];
        
        self.faceView.faceDidSelect = ^(NSString *faceName){
            NSLog(@"-------------%@",faceName);
        };
        [self addSubview:self.faceView];
        
    }
}
-(void)shareShareView
{
    if (!self.shareView)
    {
        self.shareView = [[YQMessageShareView alloc]initWithFrame:CGRectMake(0.0f,
                                                                           CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 210)];
        self.shareView.backgroundColor = [UIColor whiteColor];
        self.shareView.shareDidSelect = ^(YQShareMoreType shareType){
            NSLog(@"-------------%u",shareType);
        };
        [self addSubview:self.shareView];
        
    }
}
-(void)dissMissBar
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0.0f,CGRectGetHeight(self.superview.frame)-40,CGRectGetWidth(self.frame),40);
        self.messageToolView.frame = CGRectMake(0,0,CGRectGetWidth(self.frame),40);
        self.messageToolView.faceSendButton.selected = NO;
    } completion:^(BOOL finished) {
        self.faceView.frame = CGRectMake(0.0f,CGRectGetHeight(self.frame),CGRectGetWidth(self.frame),CGRectGetHeight(self.faceView.frame));
    }];
}
- (void)didSendFaceAction:(BOOL)sendFace{
   
    [self messageViewAnimationWithMessageRect:oldRect
                     withMessageInputViewRect:self.messageToolView.frame
                                  andDuration:0.3
                                     andState:ZBMessageViewStateShowFace
    ];
}
- (void)didSelectedMultipleMediaAction:(BOOL)changed
{
    [self messageViewAnimationWithMessageRect:oldRect
                     withMessageInputViewRect:self.messageToolView.frame
                                  andDuration:0.3
                                     andState:ZBMessageViewStateShowShare
     ];

}
- (void)inputTextViewDidBeginEditing:(UITextField *)messageInputTextView
{
    [self messageViewAnimationWithMessageRect:oldRect
                     withMessageInputViewRect:self.messageToolView.frame
                                  andDuration:0.3
                                     andState:ZBMessageViewStateShowNone
     ];

}
-(void)inputTextViewDidChange:(ZBMessageTextView *)messageInputTextView
{
    
}
#pragma mark - messageView animation
- (void)messageViewAnimationWithMessageRect:(CGRect)rect  withMessageInputViewRect:(CGRect)inputViewRect andDuration:(double)duration andState:(ZBMessageViewState)state{

        
        switch (state) {
            case ZBMessageViewStateShowFace:
            {
                
                [self bringSubviewToFront:self.faceView];

                
                
                if (self.frame.size.height>50) {
                    [UIView animateWithDuration:duration animations:^{
                        [self.messageToolView.messageInputTextView resignFirstResponder];
                        
                        self.frame = CGRectMake(0,CGRectGetHeight(self.superview.frame)-(CGRectGetHeight(self.faceView.frame)+40),CGRectGetWidth(self.frame),CGRectGetHeight(self.faceView.frame)+40);
                        
                        self.messageToolView.frame = CGRectMake(0,0,CGRectGetWidth(self.frame),CGRectGetHeight(inputViewRect));
                        
                        self.faceView.frame = CGRectMake(0,CGRectGetHeight(self.frame)-CGRectGetHeight(self.faceView.frame),CGRectGetWidth(self.frame),CGRectGetHeight(self.faceView.frame));
                       
                    } completion:^(BOOL finished) {
                        self.shareView.frame = CGRectMake(0,CGRectGetHeight(self.superview.frame),CGRectGetWidth(self.frame),CGRectGetHeight(self.shareView.frame));
                      
                    }];
                }else{
                    [UIView animateWithDuration:duration animations:^{
                        [self.messageToolView.messageInputTextView resignFirstResponder];
                        
                        self.frame = CGRectMake(0,CGRectGetHeight(self.superview.frame)-(CGRectGetHeight(self.faceView.frame)+40),CGRectGetWidth(self.frame),CGRectGetHeight(self.faceView.frame)+40);
                        
                        self.messageToolView.frame = CGRectMake(0,0,CGRectGetWidth(self.frame),CGRectGetHeight(inputViewRect));
                        
                        self.faceView.frame = CGRectMake(0,CGRectGetHeight(self.frame)-CGRectGetHeight(self.faceView.frame),CGRectGetWidth(self.frame),CGRectGetHeight(self.faceView.frame));
                        self.shareView.frame = CGRectMake(0,CGRectGetHeight(self.superview.frame),CGRectGetWidth(self.frame),CGRectGetHeight(self.shareView.frame));
                 
                        
                    } completion:^(BOOL finished) {
                       
                    }];
                }

            }
                break;
            case ZBMessageViewStateShowNone:
            {

                if (self.frame.size.height>50) {
                    [UIView animateWithDuration:duration animations:^{
                        
                        self.frame = CGRectMake(0.0f,CGRectGetHeight(self.superview.frame)-(CGRectGetHeight(keyboardRect)+40),CGRectGetWidth(self.frame),CGRectGetHeight(keyboardRect)+40);
                        self.messageToolView.frame = CGRectMake(0,0,CGRectGetWidth(self.frame),CGRectGetHeight(inputViewRect));
                        
                    } completion:^(BOOL finished) {
                            self.faceView.frame = CGRectMake(0.0f,CGRectGetHeight(self.superview.frame),CGRectGetWidth(self.frame),CGRectGetHeight(self.faceView.frame));
                            self.shareView.frame = CGRectMake(0.0f,CGRectGetHeight(self.superview.frame),CGRectGetWidth(self.frame),CGRectGetHeight(self.shareView.frame));
                      
                    }];
                }else{
                    [UIView animateWithDuration:duration animations:^{
                        
                        self.frame = CGRectMake(0.0f,CGRectGetHeight(self.superview.frame)-(CGRectGetHeight(keyboardRect)+40),CGRectGetWidth(self.frame),CGRectGetHeight(keyboardRect)+40);
                        self.messageToolView.frame = CGRectMake(0,0,CGRectGetWidth(self.frame),CGRectGetHeight(inputViewRect));
            
                            self.faceView.frame = CGRectMake(0.0f,CGRectGetHeight(self.superview.frame),CGRectGetWidth(self.frame),CGRectGetHeight(self.faceView.frame));
                            self.shareView.frame = CGRectMake(0.0f,CGRectGetHeight(self.superview.frame),CGRectGetWidth(self.frame),CGRectGetHeight(self.shareView.frame));
                    
                    } completion:^(BOOL finished) {
                       
                    }];
                }
                
 
            }
                break;
            case ZBMessageViewStateShowShare:
            {
                [self bringSubviewToFront:self.shareView];

                
                if (self.frame.size.height>50) {
                    [UIView animateWithDuration:duration animations:^{
                        [self.messageToolView.messageInputTextView resignFirstResponder];
                        self.frame = CGRectMake(0.0f,
                                                CGRectGetHeight(self.superview.frame)-(CGRectGetHeight(self.shareView.frame)+40),CGRectGetWidth(self.frame),
                                                CGRectGetHeight(self.shareView.frame)+40);
                        self.messageToolView.frame = CGRectMake(0,0,CGRectGetWidth(self.frame),CGRectGetHeight(inputViewRect));
                        self.shareView.frame = CGRectMake(0.0f,CGRectGetHeight(self.frame)-CGRectGetHeight(self.shareView.frame),CGRectGetWidth(self.frame),CGRectGetHeight(self.shareView.frame));
                        
                    } completion:^(BOOL finished) {
                            self.faceView.frame = CGRectMake(0.0f,CGRectGetHeight(self.superview.frame),CGRectGetWidth(self.frame),CGRectGetHeight(self.faceView.frame));
                    
                    }];
                }else{
                    [UIView animateWithDuration:duration animations:^{
                        [self.messageToolView.messageInputTextView resignFirstResponder];
                        self.frame = CGRectMake(0.0f,
                                                CGRectGetHeight(self.superview.frame)-(CGRectGetHeight(self.shareView.frame)+40),CGRectGetWidth(self.frame),
                                                CGRectGetHeight(self.shareView.frame)+40);
                        self.messageToolView.frame = CGRectMake(0,0,CGRectGetWidth(self.frame),CGRectGetHeight(inputViewRect));
                        self.shareView.frame = CGRectMake(0.0f,CGRectGetHeight(self.frame)-CGRectGetHeight(self.shareView.frame),CGRectGetWidth(self.frame),CGRectGetHeight(self.shareView.frame));
                        
                    } completion:^(BOOL finished) {
                        
                    }];
                }

            }
                break;
                
            default:
                break;
        }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
