//
//  LCList.h
//  SDSU Library
//
//  Created by Tyler Rogers on 8/24/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCList : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *viewControllerIdentifier;
@property (nonatomic, strong) NSString *textStoragePath;
@property (nonatomic, readonly) NSAttributedString *attributedText;

+ (NSUInteger)callNumberCount;
+ (LCList *)callNumberForIndexPath:(NSIndexPath *)anIndexPath;


@end
