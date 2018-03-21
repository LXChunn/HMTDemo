//
//  CollectionViewCell.h
//  CollectionPageView
//
//  Created by 刘小椿 on 16/11/28.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

+ (instancetype)cellWithTableview:(UICollectionView*)collectionView andIndexPath:(NSIndexPath*)indexPath;

@end
