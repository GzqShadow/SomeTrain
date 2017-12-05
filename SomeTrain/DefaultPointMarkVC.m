//
//  DefaultPointMarkVC.m
//  SomeTrain
//
//  Created by listome on 2017/3/30.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "DefaultPointMarkVC.h"
#import "GeocodeAnnotation.h"
#import "ReGeocodeAnnotation.h"
#import "MANaviAnnotationView.h"
#define RightCallOutTag 1
#define LeftCallOutTag 2
//#import <AMapLocationKit/AMapLocationKit.h>
//#import <AMapFoundationKit/AMapFoundationKit.h>
enum {
    AnnotationViewControllerAnnotationTypeRed = 0,
    AnnotationViewControllerAnnotationTypeGreen,
    AnnotationViewControllerAnnotationTypePurple
};
@interface DefaultPointMarkVC ()<MAMapViewDelegate,AMapSearchDelegate>
{
    UIButton *gpsButton;
    MAUserLocationRepresentation *r;
}
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) NSMutableArray *annotations;//点标注title数组
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) ReGeocodeAnnotation *annotation;
@property (nonatomic, assign) BOOL isSearchFromDragging;
@end

@implementation DefaultPointMarkVC
#pragma mark Action
-(void)diyLocation{
    //自定义定位小蓝点
    
    r = [[MAUserLocationRepresentation alloc] init];
    r.showsAccuracyRing = NO;///精度圈是否显示，默认YES
    
    r.showsHeadingIndicator = YES;///是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES
    r.strokeColor = [UIColor blueColor];///精度圈 边线颜色, 默认 kAccuracyCircleDefaultColor
    r.lineWidth = 100;///精度圈 边线宽度，默认0
    //    r.enablePulseAnnimation = NO;///内部蓝色圆点是否使用律动效果, 默认YES
    //    r.locationDotBgColor = [UIColor greenColor];///定位点背景色，不设置默认白色
    
    //    r.locationDotFillColor = [UIColor grayColor];///定位点蓝色圆点颜色，不设置默认蓝色
    //     r.image = [UIImage imageNamed:@"userPosition"]; ///定位图标, 与蓝色原点互斥
    [self.mapView updateUserLocationRepresentation:r];
    
    
}

-(void)backAct{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setSomeViews{
    //回到当前所在位置
    gpsButton = [self makeGPSButtonView];
    gpsButton.center = CGPointMake(CGRectGetMidX(gpsButton.bounds) + 10,
                                   self.view.bounds.size.height -  CGRectGetMidY(gpsButton.bounds) - 20);
    [self.view addSubview:gpsButton];
    gpsButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
}

- (UIButton *)makeGPSButtonView {//当前位置按钮
    UIButton *ret = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    ret.backgroundColor = [UIColor whiteColor];
    ret.layer.cornerRadius = 4;
    
    [ret setImage:[UIImage imageNamed:@"gpsStat1"] forState:UIControlStateNormal];
    [ret setImage:[UIImage imageNamed:@"gpsStat2"] forState:UIControlStateHighlighted];
    [ret addTarget:self action:@selector(gpsAction) forControlEvents:UIControlEventTouchUpInside];
    
    return ret;
}
- (void)gpsAction {
    if(self.mapView.userLocation.updating && self.mapView.userLocation.location) {
        [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
        [gpsButton setSelected:YES];
    }
}
-(void)selAct{
    NSLog(@"点击");
}

#pragma mark Init
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.mapView addAnnotations:self.annotations];
    self.mapView.showsUserLocation=YES;
    [self.mapView showAnnotations:self.annotations edgePadding:UIEdgeInsetsMake(20, 20, 20, 80) animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAnnotations];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"]
                style:UIBarButtonItemStylePlain
               target:self
               action:@selector(backAct)];
    
    //显示地图
    [AMapServices sharedServices].enableHTTPS = YES;
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //进入地图就显示定位小蓝点
    self.mapView.showsUserLocation=YES;
    self.mapView.userTrackingMode=MAUserTrackingModeFollow;
    self.mapView.touchPOIEnabled=YES;
    self.mapView.delegate = self;
    self.mapView.distanceFilter = 100;
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
//    [self diyLocation];
        [self setSomeViews];
}
//- (void)mapView:(MAMapView *)mapView didTouchPois:(NSArray *)pois{
//    
//}



#pragma mark - Initialization
- (void)initAnnotations
{
    self.annotations = [NSMutableArray array];
    //位置坐标
    //插大头针的时候 可做网络请求 取得师傅的位置坐标以及个人身份信息
    CLLocationCoordinate2D coordinates[10] = {
        //这里为虚拟坐标数据
        {22.82157416, 113.336170},
        {23.951520, 113.336240},
        {21.998293, 113.332343},
        {23.004087, 113.338904},
        {23.001442, 113.333915},
        {22.989105, 113.333915},
        {21.989098, 113.330200},
        {21.998439, 113.330201},
        {23.979590, 113.334219},
        {23.978234, 113.332792}};
    
    for (int i = 0; i < 10; ++i)
    {
        
        
        MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
        a1.coordinate = coordinates[i];//经纬度
        //这里标题和副标题可以是师傅的头像  名字 以及距离客户当前位置的距离
//        a1.title      = [NSString stringWithFormat:@"标题: %d", i];//标题
//        a1.subtitle = [NSString stringWithFormat:@"副标题: %d", i];
        [self searchReGeocodeWithCoordinate:coordinates[i]];
        [self.annotations addObject:a1];
//        MANaviAnnotationView *a1 = [[MANaviAnnotationView alloc] init];
////        a1.coordinate = coordinates[i];//经纬度
    }
}

#pragma mark - Map Delegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    
    if (updatingLocation)
    {
        [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
        CLLocationCoordinate2D coordinate = userLocation.coordinate;
        NSLog(@"userlocation :%@\n经度:%f\n纬度:%f", userLocation.location,coordinate.longitude,coordinate.latitude);
        
        _isSearchFromDragging = NO;
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
        //        [self.search AMapReGoecodeSearch:regeo];//调用 AMapSearchAPI 的 AMapReGoecodeSearch 并发起逆地理编码。
        [self searchReGeocodeWithCoordinate:coordinate];
    }
}
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{//逆地理编码  初始化，设置参数
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension            = YES;
    
    [self.search AMapReGoecodeSearch:regeo];
}

- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {

        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        //从复用内存池中获取制定复用标识的annotation view
        MANaviAnnotationView *annotationView = (MANaviAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            //初始化并返回一个annotation view
            annotationView = [[MANaviAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = YES;
        
        annotationView.rightCalloutAccessoryView    =[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView.tag = RightCallOutTag;
    //
    //    //call online navi by left accessory.
        annotationView.leftCalloutAccessoryView.tag  = LeftCallOutTag;
//        annotationView.pinColor                     = [self.annotations indexOfObject:annotation] % 3;
        annotationView.pinColor = MAPinAnnotationColorRed;
        return annotationView;
    
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
// 标注view的accessory view(必须继承自UIControl)被点击时调用此接口
    if ([view.annotation isKindOfClass:[ReGeocodeAnnotation class]])
    {
        if ([control tag] == RightCallOutTag)
        {
            NSLog(@"touch RightBtn");
//            [self gotoDetailForReGeocode:[(ReGeocodeAnnotation*)view.annotation reGeocode]];
        }
        else if([control tag] == LeftCallOutTag)
        {
            AMapNaviConfig * config = [[AMapNaviConfig alloc] init];
            config.destination    = view.annotation.coordinate;
            config.appScheme      =@"HHHHHH";
//            [CommonUtility getApplicationScheme];
            config.appName        =@"hhhhh";
//            [CommonUtility getApplicationName];
            config.strategy       = AMapDrivingStrategyShortest;
            NSLog(@"touch LeftBtn");
//            if(![AMapURLSearch openAMapNavigation:config])
//            {//调起高德导航地图
//                [AMapURLSearch getLatestAMapApp];//本机没装高德地图则跳至App Store
//            }
        }
    }
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    //当mapView新添加annotation views时调用此接口
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    NSLog(@"点击了点标注");
    // 当选中一个annotation views时调用此接口
    UIImage *img = view.image;
    self.userLocationAnnotationView  =view;
//    MAAnnotation *ma = (MAAnnotation)self.userLocationAnnotationView.annotation;
//    MAAnnotation ma = view.annotation;
    
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view {
    NSLog(@"取消");
}

- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view {
    // 标注view的calloutview整体点击时调用此接口
}


- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState {
    //拖动annotation view时view的状态变化，ios3.2以后支持
}


#pragma mark -AMapSearchDelegate
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{//逆地理编码回调
    if (response.regeocode != nil&& _isSearchFromDragging == NO )
    {
        AMapPOI *popo =response.regeocode.pois[0];
        NSLog(@"地址%@",popo.address);
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
        ReGeocodeAnnotation *reGeocodeAnnotation = [[ReGeocodeAnnotation alloc] initWithCoordinate:coordinate
                                                                                         reGeocode:response.regeocode];
        //让标注处于选择状态
        [self.mapView addAnnotation:reGeocodeAnnotation];
        [self.mapView selectAnnotation:reGeocodeAnnotation animated:YES];
    }
    else /* from drag search, update address */
    {
        [self.annotation setAMapReGeocode:response.regeocode];
        [self.mapView selectAnnotation:self.annotation animated:YES];
    }
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{//搜索失败
    NSLog(@"Error: %@ - %@", error, [ErrorInfoUtility errorDescriptionWithCode:error.code]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
