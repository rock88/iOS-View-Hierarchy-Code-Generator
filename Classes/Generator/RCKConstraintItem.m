//
//  RCKConstraintItem.m
//  ViewHierarchyCodeGenerator
//
//  Created by rock88 on 28/02/16.
//  Copyright © 2016 rock88. All rights reserved.
//

#import "RCKConstraintItem.h"
#import "RCKUtilities.h"

@implementation RCKConstraintItem

- (instancetype)initWithFirst:(NSString *)firstName second:(NSString *)secondName constraint:(NSLayoutConstraint *)constraint {
    self = [super init];
    if (self) {
        _firstName = firstName;
        _secondName = secondName;
        _constraint = constraint;
    }
    return self;
}

@end
