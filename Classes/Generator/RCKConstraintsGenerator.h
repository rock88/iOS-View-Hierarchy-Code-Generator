//
//  RCKConstraintsGenerator.h
//  ViewHierarchyCodeGenerator
//
//  Created by rock88 on 28/02/16.
//  Copyright © 2016 rock88. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RCKConstraintsGenerator <NSObject>
@required

- (instancetype)initWithItems:(NSArray *)items;

- (NSString *)sourceCode;

@end
