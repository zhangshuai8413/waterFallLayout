//
//  WaterfallLayout.h
//  WaterFall
//
//  Created by kakao on 16/3/22.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterfallLayout : UICollectionViewFlowLayout
/// 列数
@property (nonatomic, assign) NSInteger columnCount;
/// 数据数组(w, h)
@property (nonatomic, strong) NSArray *dataList;

@end
