//
//  HoursXMLParser.m
//  SDSU Library
//
//  Created by Tyler Rogers on 8/24/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#include <stdio.h>
#import "HoursXMLParser.h"
#import "Day.h"

@implementation HoursXMLParser
@synthesize days;

-(id) loadXMLByURL:(NSString *)urlString
{
    days            = [[NSMutableArray alloc] init];
    NSURL *url      = [NSURL URLWithString:urlString];
    NSData *data    = [[NSData alloc] initWithContentsOfURL:url];
    parser          = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    return self;
}


- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if ([elementname isEqualToString:@"item"])
	{
		currentDay = [Day alloc];
	}
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
	if ([elementname isEqualToString:@"title"])
	{
		currentDay.day = currentNodeContent;
	}
	if ([elementname isEqualToString:@"description"])
	{
		currentDay.hours = currentNodeContent;
	}
	if ([elementname isEqualToString:@"item"])
	{
		[days addObject:currentDay];
		currentDay = nil;
		currentNodeContent = nil;
	}
    
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}



- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

@end