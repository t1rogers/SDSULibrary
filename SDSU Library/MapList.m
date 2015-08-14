//
//  MapList.m
//  SDSU Library
//
//  Created by Tyler Rogers on 8/29/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import "MapList.h"

static NSArray *_allMaps;

@interface MapList () {
    NSAttributedString *_attributedMap;
}

@property (nonatomic, assign, getter=shouldStripRichFormatting) BOOL stripRichFormatting;
@end

@implementation MapList
+ (NSArray *)allMaps
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *maps = [NSMutableArray array];
        
        MapList *currentMap = nil;
        
        currentMap = [[MapList alloc] init];
        currentMap.title = @"All Floors";
        currentMap.viewControllerIdentifier = @"AllFloorsViewController";
        [maps addObject:currentMap];
        currentMap = nil;
        
        currentMap = [[MapList alloc] init];
        currentMap.title = @"First Floor Love Library";
        currentMap.viewControllerIdentifier = @"FirstFloorLLViewController";
        [maps addObject:currentMap];
        currentMap = nil;
        
        currentMap = [[MapList alloc] init];
        currentMap.title = @"Second Floor Love Library";
        currentMap.viewControllerIdentifier = @"SecondFloorLLViewController";
        [maps addObject:currentMap];
        currentMap = nil;
        
        currentMap = [[MapList alloc] init];
        currentMap.title = @"Third Floor Love Library";
        currentMap.viewControllerIdentifier = @"ThirdFloorLLViewController";
        [maps addObject:currentMap];
        currentMap = nil;
        
        currentMap = [[MapList alloc] init];
        currentMap.title = @"Fourth Floor Love Library";
        currentMap.viewControllerIdentifier = @"FourthFloorLLViewController";
        [maps addObject:currentMap];
        currentMap = nil;
        
        currentMap = [[MapList alloc] init];
        currentMap.title = @"Fifth Floor Love Library";
        currentMap.viewControllerIdentifier = @"FifthFloorLLViewController";
        [maps addObject:currentMap];
        currentMap = nil;
        

        
        NSUInteger totalMaps = 7;
        NSUInteger extraMapsNeeded = totalMaps - [maps count];
        
        
        _allMaps = [maps copy];
    });
    
    return _allMaps;
}

+ (MapList *)mapForIndexPath:(NSIndexPath *)anIndexPath
{
    return [[self allMaps] objectAtIndex:[anIndexPath row]];
}

+ (NSUInteger)mapCount
{
    return [[self allMaps] count];
}




@end