//
//  MapList.h
//  SDSU Library
//
//  Created by Tyler Rogers on 8/29/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapList : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *viewControllerIdentifier;
@property (nonatomic, readonly) NSAttributedString *attributedMap;

+ (NSUInteger)mapCount;
+ (MapList *)mapForIndexPath:(NSIndexPath *)anIndexPath;


@end