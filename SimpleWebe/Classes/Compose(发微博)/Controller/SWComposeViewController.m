//
//  SWComposeViewController.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/9.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWComposeViewController.h"
#import "SWEmotionTextView.h"
#import "SWComposeToolbar.h"
#import "SWComposePhotosView.h"
#import "SWAccount.h"
#import "SWAccountTool.h"
#import "SWHttpTool.h"
#import "SWSendStatusParam.h"
#import "SWSendStatusResult.h"
#import "SWStatusTool.h"
#import "SWEmotionKeyboard.h"
#import "SWEmotion.h"

@interface SWComposeViewController ()<SWComposeToolbarDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MBProgressHUDDelegate>
@property (nonatomic, weak) SWEmotionTextView *textView;
@property (nonatomic, weak) SWComposeToolbar *toolbar;
@property (nonatomic, weak) SWComposePhotosView *photosView;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, assign) CGFloat keyboardH;
@property (nonatomic, strong) SWEmotionKeyboard *keyboard;
/**
 *  是否正在切换键盘
 */
@property (nonatomic, assign, getter=isChangingKeyboard) BOOL changingKeyboard;
@end



@implementation SWComposeViewController

#pragma mark - 初始化方法
- (SWEmotionKeyboard *)keyboard
{
    if (!_keyboard) {
        self.keyboard = [SWEmotionKeyboard keyboard];
        CGFloat keyboardW = self.view.width;
        self.keyboard.bounds = CGRectMake(0, 0, keyboardW, self.keyboardH);
    }
    return _keyboard;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置导航条
    [self setupNav];
    
    //添加输入控件
    [self setupTextView];
    
    //添加工具条
    [self setupToolbar];
    
    //添加显示图片相册控件
    [self setupPhotosView];
    
    //监听表情选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:SWEmotionDidSelectedNotification object:nil];
    //监听删除表情的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDeleted:) name:SWEmotionDidDeletedNotification object:nil];
    
}

/**
 *  添加显示图片相册控件
 */
- (void)setupPhotosView
{
    SWComposePhotosView *photosView = [[SWComposePhotosView alloc] init];
    photosView.width = self.textView.width;
    photosView.height = photosView.width;
    
    photosView.y = 150;
    
    
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}
/**
 *  添加工具条
 */
- (void)setupToolbar
{
    SWComposeToolbar *toolbar = [[SWComposeToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.delegate = self;
    toolbar.height = 44;
    
    //显示控件
    //    self.textView.inputAccessoryView = toolbar;
    
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}
/**
 *  添加输入控件
 */
- (void)setupTextView
{
    //创建输入控件
    SWEmotionTextView *textView = [[SWEmotionTextView alloc] init];
    textView.alwaysBounceVertical = YES;
    
    textView.frame = self.view.bounds;
    textView.delegate = self;
    textView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:textView];
    self.textView = textView;
    
    
    //设置提醒文字
    textView.placehoder = @"分享新鲜事...";
    
    //监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 键盘处理
/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    if (self.changingKeyboard) {
        return;
    }
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.keyboardH = keyboardH;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}
/**
 *  设置导航条
 */
- (void)setupNav
{
    NSString *name = [SWAccountTool account].name;
    if (name) {
        //构建文字
        NSString *prefixStr = @"发微博";
        NSString *text = [NSString stringWithFormat:@"%@\n%@", prefixStr, name];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
        [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:[text rangeOfString:prefixStr]];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[text rangeOfString:name]];
        //创建label
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.attributedText = string;
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.width = 100;
        titleLabel.height = 44;
        self.navigationItem.titleView = titleLabel;
    } else {
        self.title = @"发微博";
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    SWLog(@"发微博");
    if (self.photosView.images.count) {
        [self sendStatusWithImage];
    }
    else {
        [self sendStatusWithoutImage];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  发送有图片的微博
 */
- (void)sendStatusWithImage
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [SWAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    params[@"pic"] = [SWAccountTool account].access_token;
    [SWHttpTool postBody:@"https://upload.api.weibo.com/2/statuses/upload.json" params:params constructingBody:^(id formData) {
        //拼接文件参数
        UIImage *image = [self.photosView.images firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        image = [UIImage imageWithData:data];
        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
    } success:^(id responseObject) {
        [self hud:@"发布成功"];
    } failure:^(NSError *error) {
        [self hud:@"发布失败"];
    }];
}
/**
 *  发送普通微博
 */
- (void)sendStatusWithoutImage
{
    SWSendStatusParam *param = [SWSendStatusParam param];
    param.status = self.textView.realText;
    [SWStatusTool sendStatusWithParam:param success:^(SWSendStatusResult *result) {
        [self hud:@"发布成功"];
    } failure:^(NSError *error) {
        [self hud:@"发布失败"];
    }];
}

- (void)hud:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows firstObject] animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:3];
    
}

#pragma  mark - UITextViewDelegate
/**
 *  当用户开始拖拽textView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
/**
 *  当textView的文字发生改变时就会调用
 */
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

#pragma mark - SWComposeToolbarDelegate
/**
 *  监听toolbar内部按钮点击
 */
- (void)composeToolbar:(SWComposeToolbar *)toolbar didClickedButton:(SWComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case SWComposeToolbarButtonTypeCamera:
            [self openCamera];
            break;
        case SWComposeToolbarButtonTypePicture:
            [self openAlbum];
            break;
        case SWComposeToolbarButtonTypeMention:
            [self openMention];
            break;
        case SWComposeToolbarButtonTypeTrend:
            [self addTrend];
            break;
        case SWComposeToolbarButtonTypeEmotion:
            [self openEmotion];
            break;
        default:
            break;
    }
}
/**
 *  打开相机
 */
- (void)openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
/**
 *  打开相册
 */
- (void)openAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
/**
 *  @某人
 */
- (void)openMention
{
    
}
/**
 *  添加话题
 */
- (void)addTrend
{
    
}
/**
 *  添加表情
 */
- (void)openEmotion
{
    //正在切换键盘
    self.changingKeyboard = YES;
    if (self.textView.inputView) {
        self.textView.inputView = nil;
        //显示表情图片
        self.toolbar.showEmotionButton = YES;
    } else {
        
        
        self.textView.inputView = self.keyboard;
        //不显示表情图片
        self.toolbar.showEmotionButton = NO;
    }
    //如果更换了文本输入框的键盘,要重新打开键盘
    // 关闭键盘
    [self.textView resignFirstResponder];
    
    // 更换完毕
    self.changingKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 打开键盘
        [self.textView becomeFirstResponder];
    });
    
    
}
/**
 *  当表情选中的时候调用
 *
 *  @param note 里面包含了选中的表情
 */
- (void)emotionDidSelected:(NSNotification *)note
{
    SWEmotion *emotion = note.userInfo[SWSelectedEmotion];
//    SWLog(@"%@ %@", emotion.chs, emotion.emoji);

    [self.textView appendEmotion:emotion];
    //检测文字长度
    [self textViewDidChange:self.textView];
}

/**
 *  当点击表情键盘上的删除按钮时调用
 */
- (void)emotionDidDeleted:(NSNotification *)note
{
    //往回删
    [self.textView deleteBackward];
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //取出选中图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //添加图片到相册中
    [self.photosView addImage:image];
    
//    SWLog(@"%@", info);
}

@end
