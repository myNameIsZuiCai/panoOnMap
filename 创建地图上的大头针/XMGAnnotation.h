//
//  XMGAnnotation.h
//  03-掌握-MapKit框架-高级使用-大头针基本使用
//
//  Created by xiaomage on 15/10/16.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@interface XMGAnnotation : NSObject <MKAnnotation>

// 确定大头针扎在地图上哪个位置
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

// 大头针弹框的标题
@property (nonatomic, copy, nullable) NSString *title;
// 弹框的子标题
@property (nonatomic, copy, nullable) NSString *subtitle;

@end
