//
//  BaseCollectionViewCell.m
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/12/2.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath*)indexPath
{
    BaseCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"basecollectioncell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

- (void)bindModel:(NSString *)imageName
{
    self.imageView.image = [UIImage imageNamed:imageName];
}

@end
