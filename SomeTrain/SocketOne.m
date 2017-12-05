//
//  SocketOne.m
//  SomeTrain
//
//  Created by listome on 2017/7/7.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "SocketOne.h"
#import "GCDAsyncSocket.h"
#import <AVFoundation/AVFoundation.h>
@interface SocketOne ()<GCDAsyncSocketDelegate,AVCapturePhotoCaptureDelegate>
{
    GCDAsyncSocket *socket;
    NSString *hosts;
    NSString *ports;
    UIImageView *imgView;
    int num;
    BOOL upOrdown;
    NSTimer *timer;
    
}
/*
 @property (strong,nonatomic)AVCaptureDevice * device;
 @property (strong,nonatomic)AVCaptureDeviceInput * input;
 @property (strong,nonatomic)AVCaptureMetadataOutput * output;
 @property (strong,nonatomic)AVCaptureSession * session;
 @property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
 @property (nonatomic, retain) UIImageView * line;
 */
@property(strong,nonatomic)AVCaptureDevice *device;
@property(strong,nonatomic)AVCaptureDeviceInput *input;//输入流
@property(strong,nonatomic)AVCaptureMetadataOutput *output;//输出流
@property(strong,nonatomic)AVCaptureSession *session;//输入输出中间桥梁
@property(strong,nonatomic)AVCaptureVideoPreviewLayer *preview;
@property(strong,nonatomic)UIImageView *line;

@end

@implementation SocketOne
-(void)viewWillAppear:(BOOL)animated
{
    [self setupCamera];
}
-(void)cancelBtnClick:(UIButton*)btn{
    [self stopBroadcast];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//断开连接
-(void)stopBroadcast{
    [socket disconnect];
}

-(void)connectSever{
    socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    //socket.delegate = self;
    NSError *err = nil;
    if(![socket connectToHost:hosts onPort:[ports intValue] error:&err])
    {
        NSLog(@"%@",err.description);
    }else
    {
        NSLog(@"打开端口ok");
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];
    [self initView];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}


//成功连接主机对应端口号
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"连接到:%@",host);
    [sock readDataWithTimeout:-1 tag:0];
}
//接收从服务端发送的消息
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *newMessage=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"host:%@,信息:%@",sock.connectedHost,newMessage);
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{

    NSString *stringValue;
    if ([metadataObjects count]>0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    NSArray *message = [stringValue componentsSeparatedByString:@","];
    hosts = message[1];
    ports = message[0];
    [_session stopRunning];
    [self connectSever];
    _line.alpha = 0;
    NSLog(@"二维码信息 = %@, %@ ,%@", stringValue,ports,hosts);
    
}

- (void)setupCamera
{
    
    //device  获取摄像设备
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //input 创建输入流
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    //output 创建输出流
    _output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程刷新
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //session 初始化连接对象
    _session = [[AVCaptureSession alloc]init];
    
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:self.input]) {
        [_session addInput:self.input];
    }
    if ([_session canAddOutput:self.output]) {
        [_session addOutput:self.output];
    }
    
    //设置扫码支持的编码格式
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    //preview
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(30,130,280,280);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    // Start  开始捕获
    [_session startRunning];
}


- (void)initView{

    imgView =[[UIImageView alloc]initWithFrame:CGRectMake(20, 120, 300, 300)];
    imgView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imgView];
    
    upOrdown = NO;
    num=0;
    _line =[[UIImageView alloc]initWithFrame:CGRectMake(60, 110, 220, 2)];
    _line.image = [UIImage imageNamed:@"line_1.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
}


-(void)animation1
{

    if (upOrdown == NO) {
        num++;
        _line.frame = CGRectMake(60, 130+2*num, 220, 2);
        if (2*num == 280) {
            upOrdown =YES;
        }
    }else{
        num--;
        _line.frame = CGRectMake(60, 130+2*num, 220, 2);
        if (num==0) {
            upOrdown=NO;
        }
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end





