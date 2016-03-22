//
//  ViewController.m
//  WaterFall
//
//  Created by kakao on 16/3/22.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import "ViewController.h"
#import "Shop.h"
#import "WaterfallImageCell.h"
#import "WaterfallLayout.h"
@interface ViewController ()

@property(nonatomic,strong) NSMutableArray *shops;
@property (weak, nonatomic) IBOutlet WaterfallLayout *layout;
// 当前的数据索引
@property (nonatomic, assign) NSInteger index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadData];
}

-(void)loadData{
    [self.shops addObjectsFromArray:[Shop shopsWithIndex:self.index]];
    self.index++;
      // 设置布局的属性
    self.layout.columnCount = 3;
    self.layout.dataList  = self.shops;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shops.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterfallImageCell *cell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor=[self randomColor];
    cell.shop=self.shops[indexPath.item];
    return cell;
}



-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
// 判断是否是页脚
    if (kind==UICollectionElementKindSectionFooter) {
        UICollectionReusableView* footerView =[collectionView dequeueReusableCellWithReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        return footerView;
    }
    return nil;
}
- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

#pragma mark -------懒加载shops
-(NSMutableArray *)shops{
    if (_shops==nil) {
        _shops=[NSMutableArray array];
    }
    return _shops;
}

@end
