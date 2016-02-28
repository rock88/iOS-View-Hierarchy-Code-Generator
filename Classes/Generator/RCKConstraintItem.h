//
//  RCKConstraintItem.h
//  ViewHierarchyCodeGenerator
//
//  Created by rock88 on 28/02/16.
//  Copyright © 2016 rock88. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCKConstraintItem : NSObject

@property (readonly) NSString* firstName;
@property (readonly) NSString* secondName;
@property (readonly) NSLayoutConstraint* constraint;

- (instancetype)initWithFirst:(NSString *)firstName second:(NSString *)secondName constraint:(NSLayoutConstraint *)constraint;

@end
