//
//  RCKViewHierarchyCodeGenerator.h
//  ViewHierarchyCodeGenerator
//
//  Created by rock88 on 28/02/16.
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
