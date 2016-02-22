//
//  NewBooksXMLParser.h
//  SDSU Library
//
//  Created by Tyler Rogers on 9/15/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

extern NSString *kAddBooksNotificationName;
extern NSString *kBooksResultsKey;

extern NSString *kBooksErrorNotificationName;
extern NSString *kBooksMessageErrorKey;


@interface NewBooksXMLParser : NSOperation

@property (copy, readonly) NSData *bookData;

- (id)initWithData:(NSData *)parseData;

+ (NSString *)AddNewBooksNotificationName;       // NSNotification name for sending earthquake data back to the app delegate
+ (NSString *)NewBooksResultsKey;                 // NSNotification userInfo key for obtaining the earthquake data

+ (NSString *)NewBooksErrorNotificationName;     // NSNotification name for reporting errors
+ (NSString *)NewBooksMessageErrorKey;           // NSNotification userInfo key for obtaining the error messa

 
@end

