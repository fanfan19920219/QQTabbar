//
//  ClickView.m
//  tabbarTest
//
//  Created by zhangzhihua on 16/3/30.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ClickView.h"
#import "my_cell.h"

@implementation ClickView

-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    
    if([hitView isKindOfClass:[UIView class]]){
        NSLog(@"1");
        return hitView;
    }
    return self;

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"click touch ");
    
}

@end
