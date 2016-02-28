//
//  RCKViewHierarchyCodeGenerator.h
//  iOS-View-Hierarchy-Code-Generator
//
//  Created by rock88, file generated at Sun Feb 28 10:20:18 UTC 2016
//  Copyright © 2016 rock88. All rights reserved.
//

#import <Foundation/Foundation.h>


@class UIView;

typedef NS_ENUM(NSInteger, RCKConstraintsType) {
    RCKConstraintsTypeNone = 0,
    RCKConstraintsTypeUIKit,
    RCKConstraintsTypeMasonry
};

@interface RCKViewHierarchyCodeGenerator : NSObject

@property RCKConstraintsType constraintsType;

- (instancetype)initWithSuperView:(UIView *)superview;

- (NSString *)sourceCode;

@end
