//
//  zzh_Tabbar.h
//  tabbarTest
//
//  Created by zhangzhihua on 16/3/8.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zzh_Tabbar : UITabBarController

@property (nonatomic ,strong)NSMutableArray *controllerArray;
@property (nonatomic , strong)UIView *mytabBar;


-(instancetype)initwithController:(NSMutableArray*)controllerArray;
-(void)setTabbarColor:(UIColor*)tabbarColor;
@end
