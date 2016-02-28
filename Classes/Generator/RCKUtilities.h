//
//  RCKUtilities.h
//  ViewHierarchyCodeGenerator
//
//  Created by rock88 on 28/02/16.
//  Copyright © 2016 rock88. All rights reserved.
//

#import <UIKit/UIKit.h>

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
