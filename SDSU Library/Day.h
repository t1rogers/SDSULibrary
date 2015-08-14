//
//  Day.h
//  SDSU Library
//
//  Created by Tyler Rogers on 8/24/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Day : NSObject

{
    NSString *day;
    NSString *hours;
    
}

@property (nonatomic, retain) NSString	 *day;
@property (nonatomic, retain) NSString	 *hours;

@end