//
//  BTAreaPickViewModel.h
//  BTAreaPickViewController
//
//  Created by leishen on 2019/11/23.
//  Copyright © 2019 leishen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface BTAreas : NSObject
/// 编码
@property (nonatomic, assign) NSString *code;
/// 区名
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *postCode;
@end

@interface BTCities : NSObject
/// 编码
@property (nonatomic, assign) NSString *code;
/// 市名
@property (nonatomic, strong) NSString *name;
/// 子区
@property (nonatomic, strong) NSArray<BTAreas*> *areaList;
@end

@interface BTProvinces : NSObject
/// 编码
@property (nonatomic, assign) NSString *code;
/// 省名
@property (nonatomic, strong) NSString *name;
/// 子市
@property (nonatomic, strong) NSArray<BTCities*> *cityList;
@end

@interface BTAreaPickViewModel : NSObject
/// 子省
@property (nonatomic, strong) NSArray<BTProvinces*> *provinces;
/// 选中的省
@property (nonatomic, strong) BTProvinces *selectedProvince;
/// 选中的市
@property (nonatomic, strong) BTCities *selectedCitie;
/// 选中的区
@property (nonatomic, strong) BTAreas *selectedArea;
@end

NS_ASSUME_NONNULL_END
