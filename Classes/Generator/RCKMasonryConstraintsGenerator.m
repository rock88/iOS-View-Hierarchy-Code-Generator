//
//  RCKMasonryConstraintsGenerator.m
//  ViewHierarchyCodeGenerator
//
//  Created by rock88 on 28/02/16.
//  Copyright © 2016 rock88. All rights reserved.
//

#import "RCKMasonryConstraintsGenerator.h"
#import "RCKConstraintItem.h"
#import "RCKUtilities.h"

@interface RCKMasonryConstraintsGenerator ()

@property NSArray* arrayItems;

@end

@implementation RCKMasonryConstraintsGenerator

- (instancetype)initWithItems:(NSArray *)items {
    self = [super init];
    if (self) {
        NSSortDescriptor* first = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES];
        NSSortDescriptor* second = [NSSortDescriptor sortDescriptorWithKey:@"constraint.firstAttribute" ascending:YES];
        NSArray* sortedItems = [items sortedArrayUsingDescriptors:@[first, second]];
        
        NSMutableArray* arrayItems = [NSMutableArray array];
        id current = nil;
        
        for (RCKConstraintItem* item in sortedItems) {
            if (current != item.constraint.firstItem) {
                current = item.constraint.firstItem;
                [arrayItems addObject:[NSMutableArray array]];
            }
            [arrayItems.lastObject addObject:item];
        }
        _arrayItems = [NSArray arrayWithArray:arrayItems];
    }
    return self;
}

- (NSString *)sourceCode {
    NSMutableString* string = [NSMutableString string];
    [string appendString:@"NSMutableArray* constraints = [NSMutableArray array];\n"];
    for (NSArray* items in _arrayItems) {
        RCKConstraintItem* item = items.firstObject;
        [string appendFormat:@"[constraints addObjectsFromArray:[%@ mas_makeConstraints:^(MASConstraintMaker *make) {\n", item.firstName];
        for (RCKConstraintItem* item in items) {
            NSLayoutConstraint* constraint = item.constraint;
            
            [string appendFormat:@"make.%@", RCKMasonryAttributeString(constraint.firstAttribute)];
            [string appendFormat:@".%@", RCKMasonryRelationString(constraint.relation)];
            
            if (constraint.secondItem) {
                if (constraint.firstAttribute == constraint.secondAttribute) {
                    [string appendFormat:@"(%@)", item.secondName];
                } else {
                    [string appendFormat:@"(%@.%@)", item.secondName, RCKMasonryViewAttributeString(constraint.secondAttribute)];
                }
                if (constraint.constant) {
                    [string appendFormat:@".with.offset(%@)", RCKFloatString(constraint.constant)];
                }
                if (constraint.multiplier != 1.0f) {
                    [string appendFormat:@".multipliedBy(%@)", RCKFloatString(constraint.multiplier)];
                }
                if (constraint.priority != UILayoutPriorityRequired) {
                    [string appendFormat:@".priority(%@)", RCKFloatString(constraint.priority)];
                }
            } else {
                [string appendFormat:@"(@(%@))", RCKFloatString(constraint.constant)];
            }
            [string appendFormat:@";\n"];
        }
        [string appendString:@"}]];\n"];
    }
    [string appendString:@"[constraints makeObjectsPerformSelector:@selector(activate)];\n"];
    return string;
}

@end
