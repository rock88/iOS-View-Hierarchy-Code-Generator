//
//  RCKUIKitConstraintsGenerator.m
//  ViewHierarchyCodeGenerator
//
//  Created by rock88 on 28/02/16.
//  Copyright © 2016 rock88. All rights reserved.
//

#import "RCKUIKitConstraintsGenerator.h"
#import "RCKConstraintItem.h"
#import "RCKUtilities.h"

@interface RCKUIKitConstraintsGenerator ()

@property NSArray* items;

@end

@implementation RCKUIKitConstraintsGenerator

- (instancetype)initWithItems:(NSArray *)items {
    self = [super init];
    if (self) {
        NSSortDescriptor* first = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES];
        NSSortDescriptor* second = [NSSortDescriptor sortDescriptorWithKey:@"constraint.firstAttribute" ascending:YES];
        _items = [items sortedArrayUsingDescriptors:@[first, second]];
    }
    return self;
}

- (NSString *)sourceCode {
    NSMutableString* string = [NSMutableString string];
    [string appendString:@"NSArray* constraints =\n@[\n"];
    for (RCKConstraintItem* item in _items) {
        [string appendFormat:@"[NSLayoutConstraint constraintWithItem:%@\n", item.firstName];
        [string appendFormat:@"attribute:%@\n", RCKLayoutAttributeString(item.constraint.firstAttribute)];
        [string appendFormat:@"relatedBy:%@\n", RCKLayoutRelationString(item.constraint.relation)];
        [string appendFormat:@"toItem:%@\n", item.secondName ?: @"nil"];
        [string appendFormat:@"attribute:%@\n", RCKLayoutAttributeString(item.constraint.secondAttribute)];
        [string appendFormat:@"multiplier:%@\n", RCKFloatString(item.constraint.multiplier)];
        [string appendFormat:@"constant:%@],\n", RCKFloatString(item.constraint.constant)];
        
        if (item.constraint.priority != UILayoutPriorityRequired) {
            NSLog(@"WARNING: need manualy set constraint priority to %f for %@", item.constraint.priority, item.constraint);
        }
    }
    [string appendString:@"];\n"];
    [string appendString:@"[NSLayoutConstraint activateConstraints:constraints];\n"];
    return string;
}

@end
