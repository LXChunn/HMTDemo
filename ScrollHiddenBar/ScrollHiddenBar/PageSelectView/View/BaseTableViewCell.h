//
//  TableViewCell.h
//  CollectionPageView
//
//  Created by 刘小椿 on 16/11/28.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lable1;

@property (weak, nonatomic) IBOutlet UILabel *lable2;

@property (weak, nonatomic) IBOutlet UILabel *lable3;


/**
 创建cell

 @param tableView tableview
 @return cell实例
 */
+ (BaseTableViewCell*)cellWithTableView:(UITableView*)tableView;


@end
