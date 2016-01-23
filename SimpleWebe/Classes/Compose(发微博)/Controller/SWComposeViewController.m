//
//  SWComposeViewController.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/9.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWComposeViewController.h"
#import "SWTextView.h"
#import "SWComposeToolbar.h"
#import "SWComposePhotosView.h"
#import "SWAccount.h"
#import "SWAccountTool.h"
#import "SWHttpTool.h"
#import "SWSendStatusParam.h"
#import "SWSendStatusResult.h"
#import "SWStatusTool.h"

@interface SWComposeViewController ()<SWComposeToolbarDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MBProgressHUDDelegate>
@property (nonatomic, weak) SWTextView *textView;
@property (nonatomic, weak) SWComposeToolbar *toolbar;
@property (nonatomic, weak) SWComposePhotosView *photosView;
@property (nonatomic, strong) MBProgressHUD *hud;


@end

@implementation SWComposeViewController

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
    self.toolbar = toolbar;
    [self.view addSubview:toolbar];
    
}
/**
 *  添加输入控件
 */
- (void)setupTextView
{
    //创建输入控件
    SWTextView *textView = [[SWTextView alloc] init];
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
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //成为第一响应者
    [self.textView becomeFirstResponder];
}

/**
 *  设置导航条
 */
- (void)setupNav
{
    self.title = @"发微博";
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
    param.status = self.textView.text;
    [SWStatusTool sendStatusWithParam:param success:^(SWSendStatusResult *result) {
        [self hud:@"发布成功"];
    } failure:^(NSError *error) {
        [self hud:@"发布失败"];
    }];
}

- (void)hud:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    
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

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length != 0;
}

#pragma mark - SWComposeToolbarDelegate
/**
 *  监听toolbar内部按钮点击
 */
- (void)composeToolbar:(SWComposeToolbar *)toolbar didClickedButton:(SWComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case SWComposeToolbarButtonTypeCamera:
            SWLog(@"SWComposeToolbarButtonTypeCamera");
            [self openCamera];
            break;
        case SWComposeToolbarButtonTypePicture:
            SWLog(@"SWComposeToolbarButtonTypePicture");
            [self openAlbum];
            break;
        case SWComposeToolbarButtonTypeMention:
            SWLog(@"SWComposeToolbarButtonTypeMention");
            [self openMention];
            break;
        case SWComposeToolbarButtonTypeTrend:
            SWLog(@"SWComposeToolbarB uttonTypeTrend");
            [self addTrend];
            break;
        case SWComposeToolbarButtonTypeEmotion:
            SWLog(@"SWComposeToolbarButtonTypeEmotion");
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
    
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //取出选中图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //添加图片到相册中
    [self.photosView addImage:image];
    
    SWLog(@"%@", info);
}

@end
