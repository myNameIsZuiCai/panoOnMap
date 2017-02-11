//
//  ViewController.m
//  创建地图上的大头针
//
//  Created by 上海均衡 on 2016/10/10.
//  Copyright © 2016年 上海均衡. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "XMGAnnotation.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLGeocoder *geoC;
@end

@implementation ViewController
- (CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
        _mapView.delegate=self;
    }
    return _geoC;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    // 添加大头针 MVC
    //    ** 必须理解: 在地图上操作大头针,实际上是控制大头针数据模型
    //    ** 添加大头针就是添加大头针数据模型 **
    //    ** 删除大头针就是删除大头针数据模型 **
    
    // 1. 获取当前手指在地图上点的位置
    CGPoint point = [[touches anyObject] locationInView:self.mapView];
    
    // 2. 把点坐标, 转换成为, 经纬度坐标
    CLLocationCoordinate2D center = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    // 3. 添加大头针数据模型
    XMGAnnotation *annotation = [self addAnnotationWithCoordinate:center andTitle:@"小码哥" subTitle:@"小码哥分部"];

    CLLocation *location = [[CLLocation alloc] initWithLatitude:center.latitude longitude:center.longitude];
    
    [self.geoC reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error == nil) {
            CLPlacemark *pl = [placemarks firstObject];
            annotation.title = pl.locality;
            annotation.subtitle = pl.name;
        }
        
    }];
    
    
    
}

- (XMGAnnotation *)addAnnotationWithCoordinate:(CLLocationCoordinate2D)center andTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    // 1. 创建大头针数据模型
    XMGAnnotation *annotation = [[XMGAnnotation alloc] init];
    annotation.coordinate = center;
    annotation.title = title;
    annotation.subtitle = subTitle;
    
    
    // 2. 添加大头针数据模型
    [self.mapView addAnnotation:annotation];
    
    return annotation;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 取出地图上所有的大头针数据模型
    NSArray *annotations = self.mapView.annotations;
    
    // 移除所有的大头针数据模型
    [self.mapView removeAnnotations:annotations];
}





-(void)addAnnotation
{
    // 1. 创建大头针数据模型
    XMGAnnotation *annotation = [[XMGAnnotation alloc] init];
    annotation.coordinate = self.mapView.centerCoordinate;
    annotation.title = @"小码哥";
    annotation.subtitle = @"大神五期";

    // 2. 添加大头针数据模型
    [self.mapView addAnnotation:annotation];
}

#pragma mark - MKMapViewDelegate
/**
 *  定位之后
 *
 *  @param mapView      地图
 *  @param userLocation 大头针数据模型
 */
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
}
/*
    当我们添加一个大头针数据模型，地图就会自动调用这个方法，来查找对应的大头针视图。如果返回nil，
 */
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    //自定义大头针模拟当这个方法返回nil，系统加载自带的大头针的过程
        static NSString *string=@"pin";
    MKPinAnnotationView *pinView=(MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:string];
    if (pinView == nil) {
        pinView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:string];
        
    }
    //重新设置大头针数据模型，防止重复利用时，数据出错
    pinView.annotation=annotation;
    //设置大头针可以弹框
    pinView.canShowCallout=YES;
    //设置下落动画
    pinView.animatesDrop=YES;
    //设置颜色
    pinView.pinTintColor=[UIColor blackColor];
    return pinView;
        static NSString *string1=@"pin";
        MKAnnotationView *pinView1=(MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:string];
        if (pinView1 == nil) {
            pinView1=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:string1];
    
        }
        //重新设置大头针数据模型，防止重复利用时，数据出错
        pinView.annotation=annotation;
    pinView.image=[UIImage imageNamed:@"datouzhen"];
    return pinView;
    
}
//选中大头针的时候
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
}
@end
