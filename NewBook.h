//
//  NewBook.h
//  SDSU Library
//
//  Created by Tyler Rogers on 9/15/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewBook : UITableViewCell

{
    NSMutableString *title;
    NSMutableString *description;
    NSMutableString *link;
    UIFont *font;
    UILabel *contentLabel;
    
    
}

@property (nonatomic) NSMutableString	 *title;
@property (nonatomic) NSMutableString	 *description;
@property (nonatomic) NSMutableString    *link;
@property (nonatomic) UIFont             *font;
@property (nonatomic) UILabel            *contentLabel;
@end