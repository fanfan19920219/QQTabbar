//
//  SkinManager.m
//  skin_test
//
//  Created by zhangzhihua on 16/3/15.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "SkinManager.h"

@implementation SkinManager

+(instancetype)sharedSkinManager {
    static SkinManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SkinManager alloc]init];
    });
    return manager;
}

-(id)init {
    if(self = [super init]){
        _skin = [[NSUserDefaults standardUserDefaults] integerForKey:@"skin"];
    }
    return self;
}

//重写set 方法,每次改变值，保存结果到本地
-(void)setSkin:(NSInteger)skin{
    _skin = skin;
    [[NSUserDefaults standardUserDefaults]setInteger:skin forKey:@"skin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
