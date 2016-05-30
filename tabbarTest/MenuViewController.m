//
//  MenuViewController.m
//  tabbarTest
//
//  Created by zhangzhihua on 16/3/25.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "MenuViewController.h"
#import "oneViewController.h"
#import "twoViewController.h"
#import "threeViewController.h"
#import "leftViewController.h"
#import "zzh_Tabbar.h"
#import "SkinManager.h"
#define JUDGMENT_X self.view.frame.size.width-20
#define LEFT_CENTER_X self.view.frame.size.width+(110/375.0)*self.view.frame.size.width
#define LEFT_VIEW_CENTER_X (110/375.0)*self.view.frame.size.width
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define BLUE_COLOR RGBA(35.0, 131.0, 221.0, 1.0)
#define WHITE_COLOR RGBA(250, 250, 250, 1.0)

@interface MenuViewController(){
    //滑动时的坐标
    CGFloat current_x;
    CGFloat current_left_x;
    UIPanGestureRecognizer *_pan;
    UITapGestureRecognizer* _tap;
    
    zzh_Tabbar *_zhtab;
}

//放置手势的View
@property (nonatomic , strong)UIView *gestureView;
//侧滑出来的View
@property (nonatomic , strong)UIView *leftView;
@property (nonatomic ,assign)CGFloat center_x;
@end


@implementation MenuViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self create_leftView];
    [self addGesture];
    [self addControllerViews];
    
    _center_x = self.view.center.x;
   // NSLog(@"center_x %f",_center_x);
    self.tabBarController.tabBar.backgroundColor = [UIColor blackColor];
    
    
    //添加观察者
    //添加观察者
    [ [SkinManager sharedSkinManager]addObserver:self forKeyPath:@"skin" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
}

-(void)addControllerViews{
    oneViewController *one = [[oneViewController alloc]init];
    UINavigationController *oneNav = [[UINavigationController alloc]initWithRootViewController:one];
    oneNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_recent_press.png"];
    oneNav.tabBarItem.image = [UIImage imageNamed:@"tab_recent_nor.png"];
    oneNav.title = @"聊天";

    twoViewController *two = [[twoViewController alloc]init];
    UINavigationController *twoNav = [[UINavigationController alloc]initWithRootViewController:two];
    twoNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_buddy_press.png"];
    twoNav.tabBarItem.image = [UIImage imageNamed:@"tab_buddy_nor.png"];
    two.title = @"好友";
    
    threeViewController *three = [[threeViewController alloc]init];
    UINavigationController *threeNav = [[UINavigationController alloc]initWithRootViewController:three];
    three.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_qworld_press.png"];
    three.tabBarItem.image = [UIImage imageNamed:@"tab_qworld_nor.png"];
    three.title = @"空间";
    
    NSMutableArray *controllerArray = [[NSMutableArray alloc]initWithObjects:oneNav,twoNav,threeNav, nil];
    
    zzh_Tabbar *zhtab = [[zzh_Tabbar alloc]initwithController:controllerArray];
    
    _zhtab = zhtab;
    zhtab.view.frame = self.view.frame;
    //zhtab.selectedIndex = 1;
//    zhtab.selectedViewController = oneNav;
    [_gestureView addSubview:zhtab.view];
   // [self.view addSubview:zhtab.view];
    [self addChildViewController:zhtab];
  //  [self.view bringSubviewToFront:_gestureView];
    //[_gestureView bringSubviewToFront:zhtab.tabBar];
    
}


-(void)addGesture{
    UIScreenEdgePanGestureRecognizer* screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(screenEdgePan:)];
    screenEdgePan.edges = UIRectEdgeLeft;
    
    _gestureView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _gestureView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_gestureView];
    [_gestureView addGestureRecognizer:screenEdgePan];
    
    //滑动手势
    _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(screenEdgePan:)];
    [_gestureView addGestureRecognizer:_pan];
    _pan.enabled = NO;
    
    //点击手势
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchupInside)];
    [_gestureView addGestureRecognizer:_tap];
    _tap.enabled = NO;
}



-(void)create_leftView{
    _leftView = [[UIView alloc]initWithFrame:CGRectMake(-self.view.frame.size.width/2- 38, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _leftView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_leftView];
    
    leftViewController *leftController = [[leftViewController alloc]init];
    [self addChildViewController:leftController];
    [_leftView addSubview:leftController.view];
    
    current_left_x = _leftView.center.x;
    NSLog(@"leftView.x ---- %f",_leftView.center.x);
}


-(void)leftAnimation{
    [UIView animateWithDuration:0.3 animations:^{
        _gestureView.center = CGPointMake(self.view.frame.size.width/2, self.view.center.y);
        _leftView.center = CGPointMake(self.view.frame.size.width/2 - self.view.frame.size.width, self.view.center.y);
    } completion:^(BOOL finished) {
        _pan.enabled = NO;
        _tap.enabled = NO;
        //发送通知
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"no",@"orRight", nil];
        NSNotification *notification =[NSNotification notificationWithName:@"tongzhi_tableView" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }];
}

-(void)rightAnimation{
    [UIView animateWithDuration:0.3 animations:^{
        _gestureView.center = CGPointMake(LEFT_CENTER_X, self.view.center.y);
        _leftView.center = CGPointMake(LEFT_VIEW_CENTER_X, self.view.center.y);
    } completion:^(BOOL finished) {
        _pan.enabled =YES;
        _tap.enabled = YES;
        //发送通知
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"yes",@"orRight", nil];
        NSNotification *notification =[NSNotification notificationWithName:@"tongzhi_tableView" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }];
}

//手势的代理方法
-(void)screenEdgePan:(UIScreenEdgePanGestureRecognizer*)pan{
    //NSLog(@"调用了");
    CGPoint point = [pan locationInView:self.view];
    current_x = _center_x + point.x;
    current_left_x = _center_x + point.x/2 - self.view.frame.size.width/2.0 - 38;
        //判断一下手势的状态，通常使用的有三个
        //手势的每一个状态都会调用这个回调方法，所以我们需要判断一下，在不同的状态下，做不同的操作
        switch (pan.state) {
            case UIGestureRecognizerStateBegan:{
                //开始
            }
                break;
            case UIGestureRecognizerStateChanged:{
                //移动
                //self.view.center = CGPointMake(_center_x + point.x, self.view.center.y);
//                NSLog(@"gestureVIew.x ---- %f  ------ %f ------%f",current_x,JUDGMENT_X,current_left_x);
                if(current_x>LEFT_CENTER_X)return;
                _gestureView.center = CGPointMake(current_x, self.view.center.y);
                //_zhtab.view.center = _gestureView.center;
                _leftView.center = CGPointMake(current_left_x, self.view.center.y);
            }
                break;
            case UIGestureRecognizerStateEnded:{
                //完成时候判断是左移还是右移
                if(current_x > JUDGMENT_X){
                    NSLog(@"右移");
                    [self rightAnimation];
                }else{
                    NSLog(@"左移");
                    [self leftAnimation];
                }
            }
                break;
            default:
                break;
        }
}


//kvo
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSInteger skin = [change [@"new"]integerValue];
    switch (skin) {
        case 0:
            //设置导航条颜色
            [_zhtab setTabbarColor:BLUE_COLOR];
            //设置tabbar背景颜色
            _zhtab.tabBar.barTintColor = BLUE_COLOR;
            
            //改变导航字体的颜色
            break;
        case 1:
            //设置导航条颜色
            [_zhtab setTabbarColor:WHITE_COLOR];
            //设置tabbar背景颜色
            _zhtab.tabBar.barTintColor = WHITE_COLOR;
            break;
        case 2:
            self.view.backgroundColor = [UIColor blueColor];
            break;
        default:
            break;
    }
}

-(void)touchupInside{
    [self leftAnimation];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch");
}
@end
