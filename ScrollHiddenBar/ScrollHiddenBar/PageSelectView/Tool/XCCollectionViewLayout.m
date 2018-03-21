//
//  XCCollectionViewLayout.m
//  广告栏collectionview
//
//  Created by 刘小椿 on 16/10/9.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "XCCollectionViewLayout.h"

@implementation XCCollectionViewLayout

- (instancetype)init
{
    if (self = [super init]) {
        self.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 104);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset            = UIEdgeInsetsMake(-64, 0, 0, 0);
        self.minimumInteritemSpacing = 0.001;
        self.minimumLineSpacing      = 0.001;
    }
    return self;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat offsetAdjustment = MAXFLOAT;
    ////  |滑动偏移|可视区域 |剩余区域|
    CGFloat centerX = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width , self.collectionView.bounds.size.height - 64);
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes *layoutAttr in array) {
        CGFloat itemCenterX = layoutAttr.center.x;
        if (ABS(itemCenterX - centerX) < ABS(offsetAdjustment)) { // 找出最小的offset 也就是最中间的item 偏移量
            offsetAdjustment = itemCenterX - centerX;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

@end
