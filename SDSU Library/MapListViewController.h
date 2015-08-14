//
//  MapListViewController.h
//  SDSU Library
//
//  Created by Tyler Rogers on 8/29/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllFloorsViewController.h"
#import "FirstFloorLLViewController.h"
#import "SecondFloorLLViewController.h"
#import "ThirdFloorLLViewController.h"
#import "FourthFloorLLViewController.h"
#import "FifthFloorLLViewController.h"





@interface MapListViewController : UICollectionViewController

{
    AllFloorsViewController *allfloors;
    FirstFloorLLViewController *onelove;
    SecondFloorLLViewController *twolove;
    ThirdFloorLLViewController *threelove;
    FourthFloorLLViewController *fourlove;
    FifthFloorLLViewController *fivelove;
}

@end


