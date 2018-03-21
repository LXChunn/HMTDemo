//
//  BaseCollectionViewCell.h
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/12/2.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath*)indexPath;

- (void)bindModel:(NSString*)imageName;

@end
