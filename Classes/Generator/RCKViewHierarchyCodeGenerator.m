//
//  RCKViewHierarchyCodeGenerator.m
//  ViewHierarchyCodeGenerator
//
//  Created by rock88 on 28/02/16.
//  Copyright © 2016 rock88. All rights reserved.
//

#import "RCKViewHierarchyCodeGenerator.h"
#import "RCKViewItem.h"
#import "RCKConstraintItem.h"
#import "RCKUIKitConstraintsGenerator.h"
#import "RCKMasonryConstraintsGenerator.h"

@interface RCKViewHierarchyCodeGenerator ()

@property UIView* superview;
@property NSMapTable* map;
@property NSUInteger index;

@property NSMutableArray* viewItems, *constraintItems;

@end

@implementation RCKViewHierarchyCodeGenerator

- (instancetype)initWithSuperView:(UIView *)superview {
    self = [super init];
    if (self) {
        _superview = superview;
        _viewItems = [NSMutableArray array];
        _constraintItems = [NSMutableArray array];
        _map = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
    }
    return self;
}

#pragma mark - Generate source code

- (NSString *)sourceCode {
    _index = 1;
    [_map removeAllObjects];
    [_viewItems removeAllObjects];
    [_constraintItems removeAllObjects];
    
    [self generateViewItemsForView:_superview];
    
    NSMutableString* string = [NSMutableString string];
    [string appendString:@"\n// Views\n"];
    [string appendString:[RCKViewItem sourceCode:_viewItems]];
    
    id<RCKConstraintsGenerator> constraintsGenerator = nil;
    [self generateConstraintItemsForView:_superview];
    
    if (_constraintsType == RCKConstraintsTypeUIKit) {
        constraintsGenerator = [[RCKUIKitConstraintsGenerator alloc] initWithItems:_constraintItems];
    } else if (_constraintsType == RCKConstraintsTypeMasonry) {
        constraintsGenerator = [[RCKMasonryConstraintsGenerator alloc] initWithItems:_constraintItems];
    }
    
    if (constraintsGenerator) {
        [string appendString:@"// Constraints\n"];
        [string appendFormat:@"%@", [constraintsGenerator sourceCode]];
    }
    return string;
}

- (void)generateViewItemsForView:(UIView *)superview {
    for (UIView* view in superview.subviews) {
        if ([self allowClass:[view class]] && ![self skipView:view superview:view.superview]) {
            NSString* name = [self assignedPropertyNameForView:view];
            NSString* superviewName = [self assignedPropertyNameForView:view.superview];
            
            RCKViewItem* item = [RCKViewItem item:view name:name superviewName:superviewName];
            item.addFrameProperty = _constraintsType == RCKConstraintsTypeNone;
            [_viewItems addObject:item];
            
            if (![self skipSubviewsForClass:[view class]]) {
                [self generateViewItemsForView:view];
            }
        }
    }
}

- (void)generateConstraintItemsForView:(UIView *)view {
    for (NSLayoutConstraint* c in view.constraints) {
        id first = c.firstItem;
        id second = c.secondItem;
        
        if ([self allowClass:[first class]] && [self allowClass:[second class]]) {
            NSString* firstName = [self assignedPropertyNameForView:first];
            NSString* secondName = [self assignedPropertyNameForView:second];
            BOOL isSize = c.firstAttribute == NSLayoutAttributeWidth || c.firstAttribute == NSLayoutAttributeHeight;
            
            if ((firstName && secondName) || (firstName && isSize)) {
                RCKConstraintItem* item = [[RCKConstraintItem alloc] initWithFirst:firstName second:secondName constraint:c];
                [_constraintItems addObject:item];
            } else {
                NSLog(@"Warning: skip %@", c);
            }
        }
    }
    
    for (UIView* subview in view.subviews) {
        if (![self skipSubviewsForClass:[subview class]]) {
            [self generateConstraintItemsForView:subview];
        }
    }
}

#pragma mark -

- (NSString *)assignedPropertyNameForView:(UIView *)view {
    if (!view) {
        return nil;
    }
    if (view == _superview) {
        return @"superview";
    }
    
    NSString* name = [_map objectForKey:view];
    if (name) {
        return name;
    }
    
    if (view.accessibilityLabel.length > 0) {
        name = view.accessibilityLabel;
    } else {
        name = [[self nameForClass:[view class]] stringByAppendingFormat:@"%zd", _index++];
    }
    
    [_map setObject:name forKey:view];
    return name;
}

- (NSString *)nameForClass:(Class)class {
    NSString* name = NSStringFromClass(class);
    if ([name hasPrefix:@"UI"]) {
        name = [name substringFromIndex:2];
    }
    return [name stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[name lowercaseString] substringToIndex:1]];
}

- (BOOL)allowClass:(Class)class {
    NSString* string = NSStringFromClass(class);
    if ([string hasPrefix:@"_"]) {
        return NO;
    }
    return YES;
}

- (BOOL)skipSubviewsForClass:(Class)class {
    if (class == [UIButton class]) {
        return YES;
    } else if (class == [UILabel class]) {
        return YES;
    }
    return NO;
}

- (BOOL)skipView:(UIView *)view superview:(UIView *)superview {
    if ([superview isKindOfClass:[UIScrollView class]] && [view isKindOfClass:[UIImageView class]] && !view.alpha) {
        return YES;
    }
    return NO;
}

@end
