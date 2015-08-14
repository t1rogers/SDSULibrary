//
//  HoursXMLParser.h
//  SDSU Library
//
//  Created by Tyler Rogers on 8/24/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Day.h"

@interface HoursXMLParser : NSXMLParser <NSXMLParserDelegate>
{
    NSMutableString *currentNodeContent;
    NSMutableArray *days;
    NSXMLParser *parser;
    Day *currentDay;
}


@property (readonly, retain) NSMutableArray *days;
-(id) loadXMLByURL:(NSString *)urlString;

@end
