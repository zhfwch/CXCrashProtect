//
//  CXProtectDemoTests.m
//  CXProtectDemoTests
//
//  Created by chuxiao on 2018/12/11.
//  Copyright © 2018年 chuxiao. All rights reserved.
//

#import <XCTest/XCTest.h>
#define SuppressPerformSelectorLeakWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)


@interface CXProtectDemoTests : XCTestCase

@end

@implementation CXProtectDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 array 防护
 */
- (void)testArrayProtect
{
    NSString *string;
    NSArray *array = @[string, @"1", @"2"];
    
    NSArray *array0 = @[];
    array0[4];
    [array0 objectAtIndex:4];
    [array0 objectAtIndexedSubscript:4];

    NSArray *array1 = @[@"1"];
    array1[4];
    [array1 objectAtIndex:4];
    [array1 objectAtIndexedSubscript:4];

    NSArray *array2 = @[@"1", @"2"];
    array2[4];
    [array2 objectAtIndex:4];
    [array2 objectAtIndexedSubscript:4];

    NSArray *array3 = @[@"1", @"2", @"3"];
    array3[4];
    [array3 objectAtIndex:4];
    [array3 objectAtIndexedSubscript:4];
}

/**
 MutableArray 防护
 */
- (void)testMutableArrayProtect
{
    NSString *string = nil;
    
    NSMutableArray *marray = @[string].mutableCopy;
    
    marray = @[@"a", @"b"].mutableCopy;
    
    marray[3];
    [marray objectAtIndex:7];
    [marray removeObjectAtIndex:7];
    [marray insertObject:@"c" atIndex:7];
    [marray replaceObjectAtIndex:9 withObject:@"c"];
}

/**
 Dictionary 防护
 */
- (void)testDictionaryProtect
{
    NSString *string = nil;
    
    NSDictionary *dictionary = @{
        string : string
    };
}

/**
 MutableDictionary 防护
 */
- (void)testMutableDictionaryProtect
{
    NSString *string = nil;
    
    NSMutableDictionary *mdictionary = @{
        string : string
    }.mutableCopy;
    
    mdictionary = @{
        @"string" : @"string"
    }.mutableCopy;
    
    [mdictionary setObject:string forKey:string];
    mdictionary[string] = string;
    [mdictionary removeObjectForKey:string];
}

/**
 String 防护
 */
- (void)testStringProtect
{
    NSString *string = @"abc";
    
    NSString *rangOfString;
    [string rangeOfString:rangOfString];

    [string substringFromIndex:8];
    [string substringToIndex:8];
    [string substringWithRange:NSMakeRange(8, 8)];
}

/**
 MutableString 防护
 */
- (void)testMutableStringProtect
{
    NSMutableString *string = @"abc".mutableCopy;
    
    NSString *rangOfString;
    [string rangeOfString:rangOfString];
    
    [string substringFromIndex:8];
    [string substringToIndex:8];
    [string substringWithRange:NSMakeRange(8, 8)];
}

- (void)testAttributedStringProtect
{
    NSString *string = nil;
    
    [[NSAttributedString alloc] initWithString:string];
    [[NSAttributedString alloc] initWithString:string attributes:nil];
}

/**
 unrecognized selector 防护
 
 包含实例方法以及类方法的防护
 */
- (void)testSelectorProtect
{
    SuppressPerformSelectorLeakWarning(
        [self performSelector:NSSelectorFromString(@"nonSelector")];
        [[self class] performSelector:NSSelectorFromString(@"nonSelector")];
    );
}

@end
