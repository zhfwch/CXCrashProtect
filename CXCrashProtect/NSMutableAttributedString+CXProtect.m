//
//  NSMutableAttributedString+CXProtect.m
//  CXProtectDemo
//
//  Created by fwzhou on 2020/3/5.
//  Copyright © 2020 chuxiao. All rights reserved.
//

#import "NSMutableAttributedString+CXProtect.h"
#import <objc/runtime.h>
#import "NSObject+Protect.h"
#import "NSException+CXProtectLog.h"

@implementation NSMutableAttributedString (CXProtect)

+ (void)setupMutableAttributedStringProtect
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class __NSConcreteMutableAttributedString = objc_getClass("NSConcreteMutableAttributedString");

        [self exchangeInstanceMethod:__NSConcreteMutableAttributedString originalSel:@selector(initWithString:) swizzledSel:@selector(cx_initWithString:)];
        
        [self exchangeInstanceMethod:__NSConcreteMutableAttributedString originalSel:@selector(initWithString:attributes:) swizzledSel:@selector(cx_initWithString:attributes:)];
        
    });
}

#pragma mark - new Methods

- (instancetype)cx_initWithString:(NSString *)str{
    
    id instance = nil;
    @try {
        instance = [self cx_initWithString:str];
    }
    @catch (NSException *exception) {
        
        [exception print];
    }
    @finally {
        return instance;
    }
}

- (instancetype)cx_initWithString:(NSString *)str attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs{
    
    id instance = nil;
    @try {
        instance = [self cx_initWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        
        [exception print];
    }
    @finally {
        return instance;
    }
}

@end
