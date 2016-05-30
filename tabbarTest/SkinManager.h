//
//  SkinManager.h
//  skin_test
//
//  Created by zhangzhihua on 16/3/15.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <Foundation/Foundation.h>

//皮肤的管理单例类
@interface SkinManager : NSObject

+(instancetype)sharedSkinManager;

//表明我们当前使用的皮肤是哪一种
@property(nonatomic ,assign)NSInteger skin;

@end
