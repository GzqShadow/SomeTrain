
//
//  MapVC.m
//  SomeTrain
//
//  Created by listome on 2017/3/20.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "MapVC.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface MapVC ()<CLLocationManagerDelegate,MKMapViewDelegate>
{
    MKMapView *mapView;
    CLLocationManager *locationManager; //定位服务
    NSString *currentCity; //当前城市
    NSString *latitudeStr; //经度
    NSString *longiudeStr; //纬度
}
@end

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:mapView];
    mapView.zoomEnabled=YES;
    mapView.showsUserLocation=YES;
    mapView.scrollEnabled=YES;
    mapView.delegate = self;
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>8.0f) {
        [self locatemap];
    }
//    [self locatemap];
    // Do any additional setup after loading the view.
}
-(void)locatemap{
    if([CLLocationManager locationServicesEnabled]){
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = self;
        if ([[[UIDevice currentDevice]systemVersion]doubleValue]>=8.0) {
            [locationManager requestAlwaysAuthorization];
        }
        
        currentCity =[[NSString alloc]init];
        //设置寻址经度
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManager.distanceFilter = 50.0;
        [locationManager startUpdatingLocation];
    }
}
#pragma mark -MapDelegate
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication]openURL:settingURL];
//        [[UIApplication sharedApplication]openURL:settingURL options:(nonnull NSDictionary<NSString *str,id> *json) completionHandler:^(BOOL success) {
        
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [locationManager stopUpdatingLocation];
    //旧值
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //打印经纬度
    NSLog(@"经度:%f,纬度:%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = currentLocation.coordinate.latitude;
    theCoordinate.longitude = currentLocation.coordinate.longitude;
    //设定显示范围
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta=0.01;
    theSpan.longitudeDelta=0.01;
    //设置地图显示的中心及范围
    MKCoordinateRegion theRegion;
    theRegion.center=theCoordinate;
    theRegion.span=theSpan;
    [mapView setRegion:theRegion];
    //反地理编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count>0) {
            CLPlacemark *placeMark = placemarks[0];
            currentCity = placeMark.locality;
            if (!currentCity) {
                currentCity = @"无法定位当前城市";
            }
            NSLog(@"国家%@\n城市%@\n位置%@\n街道%@\n",placeMark.country,currentCity,placeMark.subLocality,placeMark.thoroughfare);
            NSLog(@"具体地址%@",placeMark.name);
        }else if (error==nil && placemarks.count == 0){
            NSLog(@"No location and error return");
        }else if (error){
            
            NSLog(@"lcoation error: %@",error);
        }
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
