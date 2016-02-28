//
//  RCKViewItem.h
//  ViewHierarchyCodeGenerator
//
//  Created by rock88 on 28/02/16.
//  Copyright © 2016 rock88. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCKViewItem : NSObject

@property BOOL addFrameProperty;

+ (instancetype)item:(UIView *)view name:(NSString *)name superviewName:(NSString *)superviewName;

+ (NSString *)sourceCode:(NSArray *)items;

@end
