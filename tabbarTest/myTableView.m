//
//  myTableView.m
//  tabbarTest
//
//  Created by zhangzhihua on 16/3/30.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "myTableView.h"
#import "my_cell.h"
@implementation myTableView


-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    
    if([hitView isKindOfClass:[UIButton class]]){
        NSLog(@"1");
        return hitView;
    }
    
    if([hitView isKindOfClass:[UIView class]]){
        //cell_tongzhi
        NSLog(@"3--- 发送通知");
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"2",@"3",@"4", nil];
        
        NSNotification *notification =[NSNotification notificationWithName:@"cell_tongzhi" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        return hitView;
    }
    return nil;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@" table    click touch ");
    
}
@end
