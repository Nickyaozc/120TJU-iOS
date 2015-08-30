//
//  NewsTitleData.m
//  
//
//  Created by Qin Yubo on 15/8/23.
//
//

#import "NewsTitleData.h"

@implementation NewsTitleData

+ (NSString *)replacedKeyFromPropertyName121:(NSString *)propertyName {
    return [propertyName underlineFromCamel];
}

@end
