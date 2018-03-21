//
//  TableViewCell.m
//  CollectionPageView
//
//  Created by 刘小椿 on 16/11/28.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (BaseTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    BaseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"testcell"];
    return cell;
}

@end
