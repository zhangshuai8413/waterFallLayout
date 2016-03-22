

//
//  WaterfallImageCell.m
//  WaterFall
//
//  Created by kakao on 16/3/22.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import "WaterfallImageCell.h"
#import "Shop.h"
#import "UIImageView+WebCache.h"
@interface WaterfallImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation WaterfallImageCell
-(void)setShop:(Shop *)shop{
    _shop=shop;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:shop.img]];
    self.priceLabel.text=shop.price;
}

@end
