//
//  RCKViewHierarchyCodeGenerator.m
//  iOS-View-Hierarchy-Code-Generator
//
//  Created by rock88, file generated at Sun Feb 28 10:20:18 UTC 2016
//  Copyright © 2016 rock88. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCKViewHierarchyCodeGenerator.h"


NS_INLINE NSString* RCKFloatString(CGFloat number) {
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumIntegerDigits = 1;
    formatter.minimumFractionDigits = 1;
    formatter.maximumFractionDigits = 4;
    return [[formatter stringFromNumber:@(number)] stringByAppendingString:@"f"];
}

NS_INLINE NSString* RCKColorString(UIColor* color) {
    CGFloat r, g, b, a;
    if ([color getRed:&r green:&g blue:&b alpha:&a]) {
        NSString* sr = RCKFloatString(r);
        NSString* sg = RCKFloatString(g);
        NSString* sb = RCKFloatString(b);
        NSString* sa = RCKFloatString(a);
        return [NSString stringWithFormat:@"[UIColor colorWithRed:%@ green:%@ blue:%@ alpha:%@]", sr, sg, sb, sa];
    }
    return nil;
}

NS_INLINE NSString* RCKButtonTypeString(UIButtonType buttonType) {
    switch (buttonType) {
        case UIButtonTypeSystem:
            return @"UIButtonTypeSystem";
        case UIButtonTypeDetailDisclosure:
            return @"UIButtonTypeDetailDisclosure";
        case UIButtonTypeInfoLight:
            return @"UIButtonTypeInfoLight";
        case UIButtonTypeInfoDark:
            return @"UIButtonTypeInfoDark";
        case UIButtonTypeContactAdd:
            return @"UIButtonTypeContactAdd";
        default:
            return @"UIButtonTypeCustom";
    }
}

NS_INLINE NSString* RCKContentModeString(UIViewContentMode contentMode) {
    switch (contentMode) {
        case UIViewContentModeScaleAspectFit:
            return @"UIViewContentModeScaleAspectFit";
        case UIViewContentModeScaleAspectFill:
            return @"UIViewContentModeScaleAspectFill";
        case UIViewContentModeRedraw:
            return @"UIViewContentModeRedraw";
        case UIViewContentModeCenter:
            return @"UIViewContentModeCenter";
        case UIViewContentModeTop:
            return @"UIViewContentModeTop";
        case UIViewContentModeBottom:
            return @"UIViewContentModeBottom";
        case UIViewContentModeLeft:
            return @"UIViewContentModeLeft";
        case UIViewContentModeRight:
            return @"UIViewContentModeRight";
        case UIViewContentModeTopLeft:
            return @"UIViewContentModeTopLeft";
        case UIViewContentModeTopRight:
            return @"UIViewContentModeTopRight";
        case UIViewContentModeBottomLeft:
            return @"UIViewContentModeBottomLeft";
        case UIViewContentModeBottomRight:
            return @"UIViewContentModeBottomRight";
        default:
            return @"UIViewContentModeScaleToFill";
    }
}

NS_INLINE NSString* RCKFontString(UIFont* font) {
    if (font) {
        return [NSString stringWithFormat:@"[UIFont fontWithName:@\"%@\" size:%@]", font.fontName, RCKFloatString(font.pointSize)];
    }
    return @"nil";
}

NS_INLINE NSString* RCKFrameString(CGRect frame) {
    NSString* x = RCKFloatString(frame.origin.x);
    NSString* y = RCKFloatString(frame.origin.y);
    NSString* w = RCKFloatString(frame.size.width);
    NSString* h = RCKFloatString(frame.size.height);
    return [NSString stringWithFormat:@"CGRectMake(%@, %@, %@, %@)", x, y, w, h];
}

NS_INLINE NSString* RCKTextAlignmentString(NSTextAlignment textAlignment) {
    switch (textAlignment) {
        case NSTextAlignmentCenter:
            return @"NSTextAlignmentCenter";
        case NSTextAlignmentRight:
            return @"NSTextAlignmentRight";
        case NSTextAlignmentJustified:
            return @"NSTextAlignmentJustified";
        case NSTextAlignmentNatural:
            return @"NSTextAlignmentNatural";
        default:
            return @"NSTextAlignmentLeft";
    }
}

NS_INLINE NSString* RCKLayoutAttributeString(NSLayoutAttribute attribute) {
    switch (attribute) {
        case NSLayoutAttributeLeft:
            return @"NSLayoutAttributeLeft";
        case NSLayoutAttributeRight:
            return @"NSLayoutAttributeRight";
        case NSLayoutAttributeTop:
            return @"NSLayoutAttributeTop";
        case NSLayoutAttributeBottom:
            return @"NSLayoutAttributeBottom";
        case NSLayoutAttributeLeading:
            return @"NSLayoutAttributeLeading";
        case NSLayoutAttributeTrailing:
            return @"NSLayoutAttributeTrailing";
        case NSLayoutAttributeWidth:
            return @"NSLayoutAttributeWidth";
        case NSLayoutAttributeHeight:
            return @"NSLayoutAttributeHeight";
        case NSLayoutAttributeCenterX:
            return @"NSLayoutAttributeCenterX";
        case NSLayoutAttributeCenterY:
            return @"NSLayoutAttributeCenterY";
        case NSLayoutAttributeBaseline:
            return @"NSLayoutAttributeBaseline";
        case NSLayoutAttributeFirstBaseline:
            return @"NSLayoutAttributeFirstBaseline";
        case NSLayoutAttributeLeftMargin:
            return @"NSLayoutAttributeLeftMargin";
        case NSLayoutAttributeRightMargin:
            return @"NSLayoutAttributeRightMargin";
        case NSLayoutAttributeTopMargin:
            return @"NSLayoutAttributeTopMargin";
        case NSLayoutAttributeBottomMargin:
            return @"NSLayoutAttributeBottomMargin";
        case NSLayoutAttributeLeadingMargin:
            return @"NSLayoutAttributeLeadingMargin";
        case NSLayoutAttributeTrailingMargin:
            return @"NSLayoutAttributeTrailingMargin";
        case NSLayoutAttributeCenterXWithinMargins:
            return @"NSLayoutAttributeCenterXWithinMargins";
        case NSLayoutAttributeCenterYWithinMargins:
            return @"NSLayoutAttributeCenterYWithinMargins";
        default:
            return @"NSLayoutAttributeNotAnAttribute";
    }
}

NS_INLINE NSString* RCKLayoutRelationString(NSLayoutRelation relation) {
    switch (relation) {
        case NSLayoutRelationLessThanOrEqual:
            return @"NSLayoutRelationLessThanOrEqual";
        case NSLayoutRelationGreaterThanOrEqual:
            return @"NSLayoutRelationGreaterThanOrEqual";
        default:
            return @"NSLayoutRelationEqual";
    }
}

NS_INLINE NSString* RCKMasonryAttributeString(NSLayoutAttribute attribute) {
    switch (attribute) {
        case NSLayoutAttributeLeft:
            return @"left";
        case NSLayoutAttributeRight:
            return @"right";
        case NSLayoutAttributeTop:
            return @"top";
        case NSLayoutAttributeBottom:
            return @"bottom";
        case NSLayoutAttributeLeading:
            return @"leading";
        case NSLayoutAttributeTrailing:
            return @"trailing";
        case NSLayoutAttributeWidth:
            return @"width";
        case NSLayoutAttributeHeight:
            return @"height";
        case NSLayoutAttributeCenterX:
            return @"centerX";
        case NSLayoutAttributeCenterY:
            return @"centerY";
        case NSLayoutAttributeBaseline:
        case NSLayoutAttributeFirstBaseline:
            return @"baseline";
        case NSLayoutAttributeLeftMargin:
            return @"leftMargin";
        case NSLayoutAttributeRightMargin:
            return @"rightMargin";
        case NSLayoutAttributeTopMargin:
            return @"topMargin";
        case NSLayoutAttributeBottomMargin:
            return @"bottomMargin";
        case NSLayoutAttributeLeadingMargin:
            return @"leadingMargin";
        case NSLayoutAttributeTrailingMargin:
            return @"trailingMargin";
        case NSLayoutAttributeCenterXWithinMargins:
            return @"centerXWithinMargins";
        case NSLayoutAttributeCenterYWithinMargins:
            return @"centerYWithinMargins";
        default:
            return @"";
    }
}

NS_INLINE NSString* RCKMasonryViewAttributeString(NSLayoutAttribute attribute) {
    return [@"mas_" stringByAppendingString:RCKMasonryAttributeString(attribute)];
}

NS_INLINE NSString* RCKMasonryRelationString(NSLayoutRelation relation) {
    switch (relation) {
        case NSLayoutRelationLessThanOrEqual:
            return @"lessThanOrEqualTo";
        case NSLayoutRelationGreaterThanOrEqual:
            return @"greaterThanOrEqualTo";
        default:
            return @"equalTo";
    }
}


@interface RCKViewItem : NSObject

@property BOOL addFrameProperty;

+ (instancetype)item:(UIView *)view name:(NSString *)name superviewName:(NSString *)superviewName;

+ (NSString *)sourceCode:(NSArray *)items;

@end


@interface RCKViewItem ()

@property __kindof UIView* view;
@property NSString* name;
@property NSString* superviewName;

@end

@interface RCKButtonItem : RCKViewItem
@end

@interface RCKLabelItem : RCKViewItem
@end

@implementation RCKViewItem

+ (instancetype)item:(UIView *)view name:(NSString *)name superviewName:(NSString *)superviewName {
    if ([view isKindOfClass:[UIButton class]]) {
        return [[RCKButtonItem alloc] initWithView:view name:name superviewName:superviewName];
    } else if ([view isKindOfClass:[UILabel class]]) {
        return [[RCKLabelItem alloc] initWithView:view name:name superviewName:superviewName];
    }
    return [[self alloc] initWithView:view name:name superviewName:superviewName];
}

- (instancetype)initWithView:(UIView *)view name:(NSString *)name superviewName:(NSString *)superviewName {
    self = [super init];
    if (self) {
        _view = view;
        _name = name;
        _superviewName = superviewName;
    }
    return self;
}

- (NSString *)allocString {
    return [NSString stringWithFormat:@"%@* %@ = [[%@ alloc] init];\n", [_view class], _name, [_view class]];
}

- (NSString *)propertiesString {
    NSMutableString* string = [NSMutableString string];
    if (_addFrameProperty) {
        [string appendFormat:@"%@.frame = %@;\n", _name, RCKFrameString(_view.frame)];
    } else {
        [string appendFormat:@"%@.translatesAutoresizingMaskIntoConstraints = NO;\n", _name];
    }
    if (_view.alpha != 1.0f) {
        [string appendFormat:@"%@.alpha = %@;\n", _name, RCKFloatString(_view.alpha)];
    }
    if (RCKColorString(_view.backgroundColor)) {
        [string appendFormat:@"%@.backgroundColor = %@;\n", _name, RCKColorString(_view.backgroundColor)];
    }
    if (_view.contentMode != UIViewContentModeScaleToFill) {
        [string appendFormat:@"%@.contentMode = %@;\n", _name, RCKContentModeString(_view.contentMode)];
    }
    if (_view.clipsToBounds) {
        [string appendFormat:@"%@.clipsToBounds = YES;\n", _name];
    }
    if (RCKColorString(_view.tintColor)) {
        [string appendFormat:@"%@.tintColor = %@;\n", _name, RCKColorString(_view.tintColor)];
    }
    return string;
}


+ (NSString *)sourceCode:(NSArray *)items {
    NSMutableString* string = [NSMutableString string];
    for (RCKViewItem* item in items) {
        [string appendString:[item allocString]];
        [string appendString:[item propertiesString]];
        [string appendFormat:@"[%@ addSubview:%@];\n\n", item.superviewName, item.name];
    }
    return string;
}

@end

@implementation RCKButtonItem

- (NSString *)allocString {
    Class class = [self.view class];
    UIButton* button = self.view;
    NSString* type = RCKButtonTypeString(button.buttonType);
    return [NSString stringWithFormat:@"%@* %@ = [%@ buttonWithType:%@];\n", class, self.name, class, type];
}

- (NSString *)propertiesString {
    UIButton* button = self.view;
    NSMutableString* string = [NSMutableString stringWithString:[super propertiesString]];
    UIFont* font = button.titleLabel.font;
    if (font) {
        [string appendFormat:@"%@.titleLabel.font = %@;\n", self.name, RCKFontString(font)];
    }
    NSString* title = [button titleForState:UIControlStateNormal];
    if (title.length > 0) {
        [string appendFormat:@"[%@ setTitle:@\"%@\" forState:UIControlStateNormal];\n", self.name, title];
    }
    NSString* titleColor = RCKColorString([button titleColorForState:UIControlStateNormal]);
    if (titleColor) {
        [string appendFormat:@"[%@ setTitleColor:%@ forState:UIControlStateNormal];\n", self.name, titleColor];
    }
    return string;
}

@end

@implementation RCKLabelItem

- (NSString *)propertiesString {
    UILabel* label = self.view;
    NSMutableString* string = [NSMutableString stringWithString:[super propertiesString]];
    if (label.font) {
        [string appendFormat:@"%@.font = %@;\n", self.name, RCKFontString(label.font)];
    }
    if (label.minimumScaleFactor) {
        [string appendFormat:@"%@.minimumScaleFactor = %@;\n", self.name, RCKFloatString(label.minimumScaleFactor)];
        [string appendFormat:@"%@.adjustsFontSizeToFitWidth = YES;\n", self.name];
    }
    if (label.numberOfLines != 1) {
        [string appendFormat:@"%@.numberOfLines = %zd;\n", self.name, label.numberOfLines];
    }
    if (label.text.length > 0) {
        [string appendFormat:@"%@.text = @\"%@\";\n", self.name, label.text];
    }
    if (label.textAlignment != NSTextAlignmentLeft) {
        [string appendFormat:@"%@.textAlignment = %@;\n", self.name, RCKTextAlignmentString(label.textAlignment)];
    }
    NSString* textColor = RCKColorString(label.textColor);
    if (textColor) {
        [string appendFormat:@"%@.textColor = %@;\n", self.name, textColor];
    }
    return string;
}

@end


@interface RCKConstraintItem : NSObject

@property (readonly) NSString* firstName;
@property (readonly) NSString* secondName;
@property (readonly) NSLayoutConstraint* constraint;

- (instancetype)initWithFirst:(NSString *)firstName second:(NSString *)secondName constraint:(NSLayoutConstraint *)constraint;

@end


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


@protocol RCKConstraintsGenerator <NSObject>
@required

- (instancetype)initWithItems:(NSArray *)items;

- (NSString *)sourceCode;

@end


@interface RCKUIKitConstraintsGenerator : NSObject <RCKConstraintsGenerator>

@end


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


@interface RCKMasonryConstraintsGenerator : NSObject <RCKConstraintsGenerator>

@end


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


- (NSString *)sourceCode {
    _index = 1;
    [_map removeAllObjects];
    [_viewItems removeAllObjects];
    [_constraintItems removeAllObjects];
    
    [self generateViewItemsForView:_superview];
    
    NSMutableString* string = [NSMutableString string];
    [string appendString:[RCKViewItem sourceCode:_viewItems]];
    
    id<RCKConstraintsGenerator> constraintsGenerator = nil;
    [self generateConstraintItemsForView:_superview];
    
    if (_constraintsType == RCKConstraintsTypeUIKit) {
        constraintsGenerator = [[RCKUIKitConstraintsGenerator alloc] initWithItems:_constraintItems];
    } else if (_constraintsType == RCKConstraintsTypeMasonry) {
        constraintsGenerator = [[RCKMasonryConstraintsGenerator alloc] initWithItems:_constraintItems];
    }
    
    if (constraintsGenerator) {
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
        if (![self skipSubviewsForClass:[view class]]) {
            [self generateConstraintItemsForView:subview];
        }
    }
}


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
