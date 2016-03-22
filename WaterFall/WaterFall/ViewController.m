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
#import "WaterfallFooterView.h"
@interface ViewController ()

@property(nonatomic,strong) NSMutableArray *shops;
@property (weak, nonatomic) IBOutlet WaterfallLayout *layout;
// 当前的数据索引
@property (nonatomic, assign) NSInteger index;
@property(nonatomic,strong) WaterfallFooterView *footerView;
// 正在加载
@property(nonatomic,assign,getter=isLoading) BOOL loading;

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
    [self.collectionView reloadData];
    
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
      
        self.footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
    
        return   self.footerView;
    }
    return nil;
}

//只要滚动视图滚动，就会执行

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.footerView==nil||self.isLoading) {
        return;
    }
    if ((scrollView.contentOffset.y +scrollView.bounds.size.height)> self.footerView.frame.origin.y) {
        NSLog(@"开始刷新");
        // 如果正在刷新数据 ，不需要再次刷新
        self.loading = YES;
        [self.footerView.indicator startAnimating];
        // 模拟数据刷新
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 释放掉 footerView
            self.footerView = nil;
            
            [self loadData];
            self.loading = NO;
        });
    }
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
