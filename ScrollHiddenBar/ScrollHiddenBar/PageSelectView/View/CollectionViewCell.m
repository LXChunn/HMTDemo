//
//  CollectionViewCell.m
//  CollectionPageView
//
//  Created by 刘小椿 on 16/11/28.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@end

@implementation CollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

+ (instancetype)cellWithTableview:(UICollectionView*)collectionView andIndexPath:(NSIndexPath*)indexPath
{
    static NSString* identifier = @"collectioncell";
    CollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

@end
