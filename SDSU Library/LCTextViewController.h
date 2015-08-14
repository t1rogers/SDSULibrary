//
//  TKDTextViewController.h
//  SDSU Library
//
//  Created by Tyler Rogers on 8/24/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCList.h"

@interface LCTextViewController : UIViewController
@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, strong) LCList *callNumber;


@end
