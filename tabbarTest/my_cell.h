//
//  my_cell.h
//  celltest
//
//  Created by zhangzhihua on 16/3/21.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class my_cell;
@protocol MY_CELL_DELEGATE <NSObject>

@optional
-(void)save_buttonClick;

-(void)delete_buttonClick:(NSIndexPath*)indexPath;

-(my_cell*)returnself;

-(void)setcurrentCell:(my_cell*)cell;
@end

@interface my_cell : UITableViewCell
@property(nonatomic , assign)id<MY_CELL_DELEGATE>Delegate;
@property (nonatomic ,assign)NSIndexPath* indexPath;
-(void)refreshCell;
@end
