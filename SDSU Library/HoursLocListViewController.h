//
//  HoursLocListViewController.h
//  SDSU Library
//
//  Created by Tyler Rogers on 8/24/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoFourSevenHours.h"
#import "MainHours.h"
#import "MediaHours.h"
#import "RefHours.h"
#import "SCUAHours.h"

@interface HoursLocListViewController : UITableViewController

{
    MainHours *main;
    TwoFourSevenHours *twofourseven;
    MediaHours *media;
    RefHours *reference;
    SCUAHours *specialcoll;

}

@end
