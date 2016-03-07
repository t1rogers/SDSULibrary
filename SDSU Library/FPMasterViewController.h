//
//  FPMasterViewController.h
//  Footprint
//
//  Created by Admin jrogers on 2/9/16.
//  Copyright © 2016 Apple, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLOneViewController.h"
#import "LLTwoViewController.h"
#import "LLThreeViewController.h"



@class FPMasterViewController;

@interface FPMasterViewController : UITableViewController


{
    
    LLOneViewController *ll1ViewController;
    LLTwoViewController *ll2ViewController;
    LLThreeViewController *ll3ViewController;
    
}

@property (nonatomic, retain) IBOutlet FPMasterViewController *subLevel;


@end
