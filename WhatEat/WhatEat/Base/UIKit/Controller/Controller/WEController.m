//
//  WEController.m
//  WhatEat
//
//  Created by 辛峰 on 2018/9/13.
//  Copyright © 2018年 WhatEat. All rights reserved.
//

#import "WEController.h"

@interface WEController () <WERouterProtocol>

@property (copy,nonatomic) NSString *curPageID;
    
@end

@implementation WEController


#pragma mark -
#pragma mark - Public Method
+ (NSString *)getCurrentClassName {
    NSString *className = [NSString stringWithFormat:@"%@",NSStringFromClass([self class])];
    NSString *routerName = [NSString stringWithFormat:@"hold://%@",className];
    return routerName;
}
    
- (void)updateSkinMode {
    // 更换皮肤
}
    
#pragma mark -
#pragma mark - Override
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupBaseData];
    [self setupNavigationBar];
    [self setupLayout];
    [self setupNotification];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
#pragma mark -
#pragma mark - Private Method
- (void)setupBaseData {
    
}
    
- (void)setupLayout {
    
}
    
- (void)setupNavigationBar {
    if (!_navigationView) {
        @WeakObj(self);
        WENavigationView *navigationView = [[WENavigationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kWENavigationBarHeight)];
        navigationView.backgroundColor = [UIColor whiteColor];
        [navigationView customLeftImage:@"btn_navigation_back" leftAction:^{
            if (selfWeak.presentingViewController) {
                [selfWeak dismissVCWithAnimation:YES completion:nil];
            } else {
                [selfWeak.navigationController popViewControllerAnimated:YES];
            }
        }];
        [self.view addSubview:navigationView];
        _navigationView = navigationView;
    }
}
    
- (void)setupNotification {
    @WeakObj(self);
    [self addObserverWithName:@"kWEHiddenCurrentRootTabbar" completionHandler:^(NSNotification * _Nonnull note) {
        [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            selfWeak.tabBarController.tabBar.y = kScreenHeight;
        } completion:^(BOOL finished) { }];
    }];
    
    [self addObserverWithName:@"kWEShowCurrentRootTabbar" completionHandler:^(NSNotification * _Nonnull note) {
        [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            selfWeak.tabBarController.tabBar.y = kScreenHeight - selfWeak.tabBarController.tabBar.height;
        } completion:^(BOOL finished) { }];
    }];
    
    [self addObserverWithName:@"kWESetCurrentTabbarIndex" completionHandler:^(NSNotification * _Nonnull note) {
        NSDictionary *dict = note.userInfo;
        
        NSInteger setIndex = [[dict getNotNilString:@"index"] integerValue];
        
        selfWeak.tabBarController.selectedIndex = setIndex;
    }];
}
    
#pragma mark -
#pragma mark - Router Init
+ (id)routerCreateControllerInstance:(NSDictionary *)params {
    return [[self alloc] init];
}

@end
