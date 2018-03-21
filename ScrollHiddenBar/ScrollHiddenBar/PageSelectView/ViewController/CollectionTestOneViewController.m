//
//  CollectionTestOneViewController.m
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/12/1.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "CollectionTestOneViewController.h"
#import "XCCollectionViewLayout.h"
#import "BaseCollectionViewCell.h"

@interface CollectionTestOneViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger count;

@end

@implementation CollectionTestOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 40;
    XCCollectionViewLayout* layout = [[XCCollectionViewLayout alloc] init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 4 - 1, [UIScreen mainScreen].bounds.size.width / 4 - 1);
    layout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    layout.minimumLineSpacing = 1;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.collectionViewLayout = layout;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCollectionViewCell* cell = [BaseCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath];
    [cell bindModel:@"eight"];
    return cell;
}

@end
