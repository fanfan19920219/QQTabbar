//
//  my_cell.m
//  celltest
//
//  Created by zhangzhihua on 16/3/21.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#define CELL_HEIGHT 60.f
#define DELETE_BUTTON_WIDTH 80.f
#define SAVE_BUTTON_WIDTH 80.f
#define CELL_CONTENT_X 160
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define VIEW_WIDTH  [UIScreen mainScreen].bounds.size.width



#import "my_cell.h"
#import "backscrollview.h"
#import "controlView.h"
@interface  my_cell()<UIScrollViewDelegate>
@property (nonatomic , strong)UIScrollView *backScrollview;
@property (nonatomic , strong)UIButton *saveButton,*deleteButton;
@property (nonatomic , strong)UIView *showView;
@property (nonatomic , strong)UIView *backGroundView;
@property (nonatomic , assign)BOOL orBringButton;
@property (nonatomic , assign)CGFloat current_x;
@property (nonatomic , strong)UIScrollView *currentScrollview;
@end

@implementation my_cell

-(instancetype)init{
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CELL_HEIGHT);
        self.backGroundView = [[controlView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, CELL_HEIGHT)];
        [self.contentView addSubview:self.backGroundView];
        [self.contentView addSubview:self.backGroundView];
        self.backScrollview = [[backscrollview alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CELL_HEIGHT)];
        self.backScrollview.delegate = self;
        self.backScrollview.showsHorizontalScrollIndicator = NO;
        self.backScrollview.showsVerticalScrollIndicator = NO;
        self.backScrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width + DELETE_BUTTON_WIDTH + SAVE_BUTTON_WIDTH, 0);
        self.backScrollview.bounces = NO;
        //createShowView
        self.showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , CELL_HEIGHT)];
        self.showView.backgroundColor = [UIColor whiteColor];
        //ceateButton
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteButton.frame = CGRectMake(VIEW_WIDTH - DELETE_BUTTON_WIDTH, 0, DELETE_BUTTON_WIDTH, CELL_HEIGHT);
        self.deleteButton.backgroundColor = RGBA(250, 74, 69, 1);
        [self.deleteButton addTarget:self action:@selector(deleteclick) forControlEvents:UIControlEventTouchUpInside];
        [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        
        self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.saveButton.frame = CGRectMake(VIEW_WIDTH - DELETE_BUTTON_WIDTH - SAVE_BUTTON_WIDTH, 0, SAVE_BUTTON_WIDTH, CELL_HEIGHT);
        [self.saveButton addTarget:self action:@selector(saveclick) forControlEvents:UIControlEventTouchUpInside];
        self.saveButton.backgroundColor = RGBA(252, 176, 44, 1);
        [self.saveButton setTitle:@"收藏" forState:UIControlStateNormal];
        
        [self.backGroundView addSubview:self.deleteButton];
        [self.backGroundView addSubview:self.saveButton];
        [self.backScrollview addSubview:self.showView];
        [self.backGroundView addSubview:self.backScrollview];
        [self registerNotifacetion];
    }
    return self;
}


-(void)deleteclick{
    [self.Delegate delete_buttonClick:self.indexPath];
}
-(void)saveclick{
    NSLog(@"saveClick");
    [self.Delegate save_buttonClick];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(scrollView.contentOffset.x < 159&&self.orBringButton){
        [self.backGroundView sendSubviewToBack:self.deleteButton];
        [self.backGroundView sendSubviewToBack:self.saveButton];
        self.orBringButton = NO;
        NSLog(@"slide");
    }
}

//这个方法是手起来时候调用的方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
     //NSLog(@"2");
//NSLog(@"%@",_currentScrollview);
    if(![_currentScrollview isEqual:scrollView]){
        // NSLog(@"复位");
        _currentScrollview.contentOffset = CGPointMake(0, 0);
    }
    
    if(scrollView.contentOffset.x >= 160){
        self.orBringButton = YES;
        [self.backGroundView bringSubviewToFront:self.deleteButton];
        [self.backGroundView bringSubviewToFront:self.saveButton];
       NSLog(@"进来了");
        NSLog(@"delegate --- %@",self.Delegate);
        [self.Delegate setcurrentCell:self];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"1");
    [self rightanimation];
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSLog(@"delegate begin");
//}
//注册通知
-(void)registerNotifacetion{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rightanimation) name:@"cell_tongzhi" object:nil];
}

//
-(void)leftanimation{
    [UIView animateWithDuration:0.2 animations:^{
        self.backScrollview.contentOffset = CGPointMake(160, 0);
    } completion:^(BOOL finished) {
        self.orBringButton = YES;
        [self.backGroundView bringSubviewToFront:self.deleteButton];
        [self.backGroundView bringSubviewToFront:self.saveButton];
        NSLog(@"2");
    }];
}
-(void)rightanimation{
    [UIView animateWithDuration:0.2 animations:^{
        self.backScrollview.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        NSLog(@"right");
    }];
}

-(void)refreshCell{
    [UIView animateWithDuration:0.2 animations:^{
        self.backScrollview.contentOffset = CGPointMake(0, 0);
    }];

}

-(my_cell*)returnself{
    return self;
}

@end
