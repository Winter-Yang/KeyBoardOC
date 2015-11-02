//
//  ViewController.m
//  KeyBoard
//
//  Created by 杨雯德 on 15/10/26.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

#import "ViewController.h"
#import "YQMessageMenuBar.h"
@interface ViewController ()<YQMessageMenuBarDelegate>
{
CGRect keyboardRect;
}

@property (nonatomic, strong) YQMessageInputView *messageToolView;
@property (nonatomic, strong) YQMessageMenuBar *messageBar;
@property (nonatomic, strong) YQMessageFaceView * faceView;
@property (nonatomic, strong) YQMessageShareView * shareView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.userInteractionEnabled = YES;
    self.messageBar = [[YQMessageMenuBar alloc]initWithFrame:CGRectMake(0,self.view.bounds.size.height-40,self.view.bounds.size.width, 40)];
    [self.view addSubview:self.messageBar];
//    self.messageBar.delegate = self;
    
    
    self.shareView = [[YQMessageShareView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width, 215)];
//    [self.view addSubview:self.shareView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
}

-(void)tap:(UIGestureRecognizer*)sender
{
    if ([sender locationInView:self.view].y <self.view.bounds.size.height -250) {
        [self.messageBar dissMissBar];
    }
}

//-(void)keyboardWillShow:(NSNotification *)note
//{
//    
//    NSDictionary * userInfo = note.userInfo;
//    CGRect keyBoardBounds = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    keyboardRect = keyBoardBounds;
//    double duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    CGFloat deltay = keyBoardBounds.size.height;
//    void (^animations)(void);
//    NSLog(@"22222");
//    animations = ^(void){
//        self.messageToolView.transform = CGAffineTransformMakeTranslation(0, -deltay);
//    };
//    if (duration>0) {
//        //        int options = UIViewAnimationOptions([[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16);
//        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:animations completion:nil];
//    }else{
//        animations();
//    }
//    
//}
//
//-(void)keyboardWillHide:(NSNotification *)note
//{
//    NSLog(@"111111");
//    NSDictionary * userInfo = note.userInfo;
//    keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    double duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    void (^animations)(void);
//    animations = ^(void){
//        self.messageToolView.transform = CGAffineTransformIdentity;
//    };
//    if (duration>0) {
//        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:animations completion:nil];
//    }else{
//        animations();
//    }
//}
//- (void)keyboardChange:(NSNotification *)notification{
//    if ([[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y<CGRectGetHeight(self.view.frame)) {
//        [self messageViewAnimationWithMessageRect:[[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]
//                         withMessageInputViewRect:self.messageToolView.frame
//                                      andDuration:0.25
//                                         andState:ZBMessageViewStateShowNone];
//    }
//}
//-(void)handleTouches:(UITapGestureRecognizer*)sender
//{
//    if ([sender locationInView:self.view].y <self.view.bounds.size.height -250) {
//        [self.messageToolView.messageInputTextView resignFirstResponder];
//    }
//}
//
//-(void)shareFaceView
//{
//    if (!self.faceView)
//    {
//        self.faceView = [[YQMessageFaceView alloc]initWithFrame:CGRectMake(0.0f,
//                                                                                  CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), 196)];
//        self.faceView.delegate = self;
//        [self.view addSubview:self.faceView];
//        
//    }
//}
//
//- (void)didSendFaceAction:(BOOL)sendFace{
//    if (sendFace) {
//        [self messageViewAnimationWithMessageRect:self.faceView.frame
//                         withMessageInputViewRect:self.messageToolView.frame
//                                      andDuration:0.2
//         andState:ZBMessageViewStateShowNone
//                                         ];
//    }
//    else{
//        [self messageViewAnimationWithMessageRect:keyboardRect
//                         withMessageInputViewRect:self.messageToolView.frame
//                                      andDuration:0.2
//         andState:ZBMessageViewStateShowFace
//                                        ];
//    }
//}
//- (void)inputTextViewDidBeginEditing:(UITextField *)messageInputTextView
//{
//    [self messageViewAnimationWithMessageRect:keyboardRect
//                     withMessageInputViewRect:self.messageToolView.frame
//                                  andDuration:0.2
//                                andState:ZBMessageViewStateShowNone
//                                     ];
//    
//   
//}
//#pragma mark - messageView animation
//- (void)messageViewAnimationWithMessageRect:(CGRect)rect  withMessageInputViewRect:(CGRect)inputViewRect andDuration:(double)duration andState:(ZBMessageViewState)state{
//    
//    [UIView animateWithDuration:duration animations:^{
// 
//        switch (state) {
//            case ZBMessageViewStateShowFace:
//            {
//                [self.messageToolView.messageInputTextView resignFirstResponder];
//
//                self.messageToolView.frame = CGRectMake(0.0f,CGRectGetHeight(self.view.frame)-CGRectGetHeight(self.faceView.frame)-CGRectGetHeight(inputViewRect),CGRectGetWidth(self.view.frame),CGRectGetHeight(inputViewRect));
//                
//                self.faceView.frame = CGRectMake(0.0f,CGRectGetHeight(self.view.frame)-CGRectGetHeight(self.faceView.frame),CGRectGetWidth(self.view.frame),CGRectGetHeight(self.faceView.frame));
//            }
//                break;
//            case ZBMessageViewStateShowNone:
//            {
//                
//                self.faceView.frame = CGRectMake(0.0f,CGRectGetHeight(self.view.frame),CGRectGetWidth(self.view.frame),CGRectGetHeight(self.faceView.frame));
//                
//                self.messageToolView.frame = CGRectMake(0.0f,CGRectGetHeight(self.view.frame)-CGRectGetHeight(rect)-CGRectGetHeight(inputViewRect),CGRectGetWidth(self.view.frame),CGRectGetHeight(inputViewRect));
//
//            }
//                break;
//            case ZBMessageViewStateShowShare:
//                
//                break;
//                
//            default:
//                break;
//        }
//        
//       
//        
//        
//        
//        
//       
//        
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
