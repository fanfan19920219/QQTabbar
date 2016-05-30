//
//  zzh_Tabbar.m
//  tabbarTest
//
//  Created by zhangzhihua on 16/3/8.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "zzh_Tabbar.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface zzh_Tabbar (){
    UIImageView *_tabBarView;//自定义的覆盖原先tabbar的控件
    
    NSMutableArray *_tabBarArray;
}
@end

@implementation zzh_Tabbar
//-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if(self){
//        
//    }
//    return self;
//}


-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    [self setTabbarView];
}

-(instancetype)initwithController:(NSMutableArray*)controllerArray{
    if(self){
        self.controllerArray = controllerArray;
        
    }
    return self;
}

-(void)setTabbarView{
    _tabBarView = [[UIImageView alloc]initWithFrame:self.tabBar.bounds];
    _tabBarView.userInteractionEnabled = YES;
    _tabBarView.backgroundColor = [UIColor greenColor];
    
    //隐藏导航
    [[UINavigationBar appearance]setHidden:YES];
    NSLog(@"2");
    [self setViewControllers:self.controllerArray animated:YES];
    //self.selectedIndex = 0;
    _mytabBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    _mytabBar.backgroundColor = RGBA(250, 250, 250, 1);
    [self.view addSubview:_mytabBar];
    
}

-(void)setTabbarColor:(UIColor*)tabbarColor{
    _mytabBar.backgroundColor = tabbarColor;
}
//禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}

@end
