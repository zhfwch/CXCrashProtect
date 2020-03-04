//
//  NSMutableString+CXProtect.m
//  CXProtect
//
//  Created by chuxiao on 2018/7/6.
//  Copyright © 2018年 CXProtect. All rights reserved.
//

#import "NSMutableString+CXProtect.h"
#import "NSObject+Protect.h"
#import "NSException+CXProtectLog.h"

@implementation NSMutableString (CXProtect)

+ (void)setupMutableStringProtect
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class __NSCFString = NSClassFromString(@"__NSCFString");
        
        [self exchangeInstanceMethod:__NSCFString originalSel:@selector(rangeOfString:options:range:locale:) swizzledSel:@selector(cx_rangeOfString:options:range:locale:)];
        
        [self exchangeInstanceMethod:__NSCFString originalSel:@selector(substringToIndex:) swizzledSel:@selector(cx_substringToIndex:)];
        
        [self exchangeInstanceMethod:__NSCFString originalSel:@selector(substringFromIndex:) swizzledSel:@selector(cx_substringFromIndex:)];
        
        //substringWithRange:
        [self exchangeInstanceMethod:__NSCFString originalSel:@selector(substringWithRange:) swizzledSel:@selector(cx_substringWithRange:)];
    });
}

- (NSRange)cx_rangeOfString:(NSString *)aString
                    options:(NSStringCompareOptions)mask
                      range:(NSRange)searchRange
                     locale:(NSLocale *)locale
{
    
    NSRange range;
    @try {
        range = [self cx_rangeOfString:aString options:mask range:searchRange locale:locale];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        return range;
    }
}

- (NSString *)cx_substringFromIndex:(NSUInteger)index {
    
    NSString *subString = nil;
    
    @try {
        subString = [self cx_substringFromIndex:index];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        return subString;
    }
}

- (NSString *)cx_substringToIndex:(NSUInteger)index {
    
    NSString *subString = nil;
    
    @try {
        subString = [self cx_substringToIndex:index];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        return subString;
    }
}

- (NSString *)cx_substringWithRange:(NSRange)range {
    
    NSString *subString = nil;
    
    @try {
        subString = [self cx_substringWithRange:range];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        return subString;
    }
}

@end
