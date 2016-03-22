//
//  WaterfallLayout.m
//  WaterFall
//
//  Created by kakao on 16/3/22.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import "WaterfallLayout.h"
#import "Shop.h"
@interface WaterfallLayout ()

@property(nonatomic,strong) NSArray *layOutAttributes;

@end
@implementation WaterfallLayout
/// 准备布局，当 collectionView 的布局发生变化时，会被调用
/// 通常是做布局的准备工作，itemSize,....
/// 准备布局的时候，dataList 已经有值
/// UICollectionView 的 contentSize 是根据 itemSize 动态计算出来的

-(void)prepareLayout{
    // 1. item 的宽度，根据列数，每个列的宽度是固定
    CGFloat contentWidth =self.collectionView.bounds.size.width-self.sectionInset.left- self.sectionInset.right;
    
    CGFloat itemWidth =(contentWidth -(self.columnCount-1)*self.minimumInteritemSpacing)/self.columnCount;
     // 2. 计算布局属性
    [self attributes:itemWidth];
}
-(void)attributes:(CGFloat)itemWidth{
   // 定义一个列高的数组，记录每一列最大的高度
    CGFloat colHeight[self.columnCount];
    for (int i=0; i< self.columnCount; ++i) {
        colHeight[i]=self.sectionInset.top;
    }
    // 定义总item 高
    CGFloat totalItemHeight =0;
    // 遍历dataList 数组计算属性
    NSMutableArray *arrayM  = [NSMutableArray arrayWithCapacity:self.dataList.count];
    NSInteger index=0;
    for ( Shop *shop in self.dataList) {
        //  1>  建立布局属性
        NSIndexPath *path =[NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attr =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
        // 2>  计算当前列数
        NSInteger col =index% self.columnCount;
        // 3> 设置frame
        CGFloat x =self.sectionInset.left +col*(itemWidth+self.minimumInteritemSpacing);
        CGFloat y = colHeight[col];
        // 设置heigh
        CGFloat h =[self itemHeightWith:CGSizeMake(shop.w, shop.h) itemWidth:itemWidth];
        
        totalItemHeight+=h;
        attr.frame=CGRectMake(x, y, itemWidth, h);
        
          // 4> 累加列高
        colHeight[col]+= h+self.minimumLineSpacing;
        index++;
        [arrayM addObject:attr];
     }
    // 设置itemSize 使用总高度的平均值
    self.itemSize=CGSizeMake(itemWidth, totalItemHeight/self.dataList.count);
    // 给属性数据组设置数值
    self.layOutAttributes=arrayM.copy;
    
}



-(CGFloat)itemHeightWith:(CGSize)size itemWidth:(CGFloat)itemWidth{
    return size.height*itemWidth/size.width;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 直接返回计算完成的 属性数组
    return self.layOutAttributes;
}


@end
