//
//  JDComposeController.m
//  丁丁说
//
//  Created by JiangDing on 15/11/23.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDComposeController.h"
#import "JDNavigationController.h"
#import "JDTextView.h"
#import "JDTextViewToolBar.h"
#import "JDTextViewPhotoView.h"

#import "AFNetworking.h"
#import "JDAccount.h"
#import "JDAccountTool.h"
#import "MBProgressHUD+MJ.h"

#import "JDSendStatusParam.h"
#import "JDSendStatusResult.h"
#import "JDSendCommentResult.h"
#import "JDSendCommentParam.h"
#import "JDStatusTool.h"

#import "JDEmotionKeyBoard.h"
#import "JDEmotion.h"
#import "JDEmotionTextView.h"
#import "JDMentionController.h"


@interface JDComposeController() <JDTextViewToolBarDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, weak) JDEmotionTextView *textView;
@property (nonatomic, weak) JDTextViewToolBar *toolBar;
@property (nonatomic, weak) JDTextViewPhotoView *photoView;

/** emotion键盘 */
@property (nonatomic, strong) JDEmotionKeyBoard *keyboard;

/** 是否正在切换键盘 */
@property (nonatomic, assign, getter = isChangingKeyboard) BOOL changingKeyboard;

@end
@implementation JDComposeController

/**
 *  懒加载emotion键盘
 */
- (JDEmotionKeyBoard *)keyboard
{
    if (_keyboard == nil) {
        _keyboard = [JDEmotionKeyBoard keybaord];
        _keyboard.width = JDScreenWidth;
        _keyboard.height = 250;
    }
    return _keyboard;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1. 设置导航
    [self setNav];

    // 2. 添加textView
    [self setTextView];
    
    
    // 3. 添加通知监听emotion事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:JDLongPressDidSelectedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDelete:) name:JDLongPressDidDeleteNotification object:nil];
    
    // 添加@选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mentionDidSelected:) name:JDMentionNotification object:nil];
}

#pragma mark - @ 通知
/**
 *  点击@选中
 */
- (void)mentionDidSelected:(NSNotification *)note
{
    NSString *title = note.userInfo[JDMentionInfo];
    
    //获取之前的属性文本
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];

    NSString *substr = [NSString stringWithFormat:@"@%@ ", title];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:substr];
    // 设置颜色, - 1 是为了防止后面的根颜色一样啊啊啊
    [attrStr addAttribute:NSForegroundColorAttributeName value:JDStatusHightColor range:NSMakeRange(0, substr.length - 1)];
    [attrStr addAttribute:NSFontAttributeName value:JDStatusNameFont range:NSMakeRange(0, substr.length)];
    [attrString appendAttributedString:attrStr];
    
    self.textView.attributedText = attrString;
 
    // 通知textViewDidChange
    [self textViewDidChange:self.textView];
}


#pragma mark - emotion图标通知
/**
 *  当点击emotion选择的时候
 */
- (void)emotionDidSelected:(NSNotification *)note
{
    JDEmotion *emotion = note.userInfo[JDLongPressSelectedEmotion];
    
    
    // 1. 拼接emotion
    [self.textView appendEmotion:emotion];
    
    
    // 2. 通知textViewDidChange
    [self textViewDidChange:self.textView];
    
}

/**
 *  当点击emotion删除的时候
 */
-(void)emotionDelete:(NSNotification *)note
{
    // 删除上一个
    [self.textView deleteBackward];
}

/**
 *  当键盘要出现的时候调用
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1. 获取时间
    CGFloat duration  = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2. 动画
    [UIView animateWithDuration:duration animations:^{
        // 获得键盘的高度
        CGRect keyboardRect =  [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardHeight = keyboardRect.size.height;
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, - keyboardHeight);
    }];
}

/**
 * 当键盘要消失的时候调用
 */
- (void)keyboardWillHidden:(NSNotification *)note
{
    
    // 0. 如果是点击emoji切换键盘就不要动
    if (self.changingKeyboard) {
        self.changingKeyboard = NO;
        return;
    }
    
    // 1. 获取时间
    CGFloat duration  = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2. 动画
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformIdentity;
    }];
}

// 当view完全出现的时候在弹出键盘
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

// 当view将要消失的时候关掉键盘
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}


#pragma mark - 添加textView
// 添加textView
- (void)setTextView
{
    JDEmotionTextView *textView = [[JDEmotionTextView alloc] init];
    textView.alwaysBounceVertical = YES;
    textView.frame = self.view.bounds;
    textView.placeholder = self.holder;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 添加tabBar
    [self addToolBar];
    
    // 添加图片view
    [self addPhotoView];
    
    // 监听键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 *  添加textView photoView
 */
- (void)addPhotoView
{
    JDTextViewPhotoView *photoView = [[JDTextViewPhotoView alloc] init];
    photoView.width = self.textView.width;
    photoView.height = self.textView.height;
    photoView.y = 100;
    [self.textView addSubview:photoView];
    self.photoView = photoView;
}


/**
 *  添加textView 导航条
 */
- (void)addToolBar
{
    JDTextViewToolBar *toolBar = [[JDTextViewToolBar alloc] init];
    toolBar.width = self.view.width;
    toolBar.height = 44;
    toolBar.delegate = self;
    
    //self.textView.inputAccessoryView = toolBar;
    toolBar.y = self.view.height - toolBar.height;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark TextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = (textView.attributedText.length != 0);
}

#pragma mark UITextViewDelegate
/**
 *  当用户开始拖拽TextView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


#pragma mark JDTextViewToolBarDelegate
/**
 * textView 导航栏代理
 */
- (void)jdTextViewToolBar:(JDTextViewToolBar *)toolBar DidClickButton:(JDTextViewToolBarType)toolBarType
{
    switch (toolBarType) {
        case JDTextViewToolBarTypeCamera:
            [self openCamera];
            break;
            
        case JDTextViewToolBarTypePicture:
            [self openPicture];
            break;
        case JDTextViewToolBarTypeMention:
            [self openMention];
            break;
        case JDTextViewToolBarTypeTrend:
            JDLog(@"#");
            break;
        case JDTextViewToolBarTypeEmotion:
            [self openEmotion];
            break;
    }
}

/**
 *  打开照相机
 */
- (void)openCamera
{
    // 如果不可用, 就走
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imgPicker.delegate = self;
    [self presentViewController:imgPicker animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openPicture
{
    // 如果不能用就走
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *imgPikcer = [[UIImagePickerController alloc] init];
    imgPikcer.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imgPikcer.delegate = self;
    [self presentViewController:imgPikcer animated:YES completion:nil];
}

/**
    @ 方法
 */
- (void)openMention
{
    JDMentionController *mentionVC = [[JDMentionController alloc] init];
    JDNavigationController *nav = [[JDNavigationController alloc] initWithRootViewController:mentionVC];
    [self presentViewController:nav animated:YES completion:nil];
}



#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 关闭
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];

    // 设置图片进去
    self.photoView.image = image;
}

#pragma mark - 设置导航按钮
/**
 *  设置导航按钮
 */
- (void)setNav
{
    NSString *prefix = self.prefix;
    
    // 获取用户名
    NSString *name = [JDAccountTool account].name;
    if (name) {
        NSString *string = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
        [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:[string rangeOfString:prefix]];
        [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:[string rangeOfString:name]];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[string rangeOfString:name]];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.width = 100;
        titleLabel.height = 44;
        titleLabel.attributedText = attrString;
        self.navigationItem.titleView = titleLabel;
    }else{
        self.navigationItem.title = prefix;
    }
    

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark 发微博
/**
 *  发送微博
 */
- (void)send
{
 
    if ([self.prefix isEqualToString:@"发微博"]) {
        // 1. 如果当前有图片
        if (self.photoView.images.count > 0) {
            // 发有图片的微博
            [self sendStatusWithImage];
        }else{
            // 发送没有图片的微博
            [self sendStatus];
        }
    }else if ([self.prefix isEqualToString:@"发评论"]){
        // 发送评论
        [self sendComment];
    }

    
    // 2. 关闭发微博页面
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送评论方法
 */
- (void)sendComment
{
    // 1. 参数
    JDSendCommentParam *param = [[JDSendCommentParam alloc] init];
    param.access_token = [JDAccountTool access_token];
    param.comment = self.textView.realText;
    param.id = self.commentId;
    
    // 2. 发送请求
    [JDStatusTool postSendStatusCommentWithParam:param success:^(JDSendCommentResult *result) {
        [MBProgressHUD showSuccess:@"评论成功"];
    } failure:^(NSError *error) {
        JDLog(@"发送评论失败: %@", error);
        [MBProgressHUD showError:@"评论失败"];
    }];
}


/**
    发送有图片的微博
 */
- (void)sendStatusWithImage
{
    // 1. 参数
    JDSendStatusParam *params = [[JDSendStatusParam alloc] init];
    params.access_token = [JDAccountTool account].access_token;
    params.status = self.textView.realText;
    
    // 2. 发送请求
    [JDStatusTool postSendStatusWithPictureParam:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

        // 目前新浪开放的发微博接口 最多 只能上传一张图片
        UIImage *image = [self.photoView.images firstObject];
        
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        
        // 拼接文件参数上传
        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
        
    } success:^(JDSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        JDLog(@"发送失败:%@", error);
        [MBProgressHUD showError:@"发送失败"];
    }];
}

/**
    没有图片的微博
 */
- (void)sendStatus
{    
    // 1. 参数
    JDSendStatusParam *params = [[JDSendStatusParam alloc] init];
    params.access_token = [JDAccountTool account].access_token;
    params.status = self.textView.realText;
    
    // 2. 发送微博
    [JDStatusTool postSendStatusWithParam:params success:^(JDSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发表成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发表失败"];
    }];
    
}

#pragma mark - emotion
- (void)openEmotion
{
    
    // 0. 正在切换键盘
    self.changingKeyboard = YES;
    
    // 1. 判断状态
    if (self.textView.inputView == nil) { // 当前是系统键盘
        // 设置为自定义键盘
        self.textView.inputView = self.keyboard;
    
        // 显示键盘按钮
        self.toolBar.showEmotion = NO;
        
    }else{
        // 显示emotion按钮
        self.toolBar.showEmotion = YES;
        self.textView.inputView = nil;
    }
    
    // 2.如果临时更换了文本框的键盘，一定要重新打开键盘
    // 取消键盘
    [self.textView resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 延迟打开键盘
        [self.textView becomeFirstResponder];
    });

}

/**
 *  关闭
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
