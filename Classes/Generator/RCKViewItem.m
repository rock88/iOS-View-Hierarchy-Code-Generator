//
//  RCKViewItem.m
//  ViewHierarchyCodeGenerator
//
//  Created by rock88 on 28/02/16.
//  Copyright © 2016 rock88. All rights reserved.
//

#import "RCKViewItem.h"
#import "RCKUtilities.h"

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

#pragma mark - Source code generate

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
