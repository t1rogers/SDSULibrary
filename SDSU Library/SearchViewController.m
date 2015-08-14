//
//  SearchViewController.m
//  SDSU Library
//
//  Created by Tyler Rogers on 2/15/15.
//  Copyright (c) 2015 San Diego State University. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SearchViewController.h"
#import "SVWebViewController.h"
#import "SVModalWebViewController.h"

@implementation SearchViewController

-(void)viewDidLoad {
    

}

-(void)pacSearchViewController {
    NSURL *URL = [NSURL URLWithString:@"http://m.libpac.sdsu.edu"];
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithURL:URL];
    webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    self.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:webViewController animated:YES completion:NULL];
}

-(void)xerxesSearchViewController {
    NSURL *URL = [NSURL URLWithString:@"http://library.calstate.edu/sandiego/articles/"];
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithURL:URL];
    webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    self.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:webViewController animated:YES completion:NULL];
}


-(void)readingListController {
    NSURL *URL = [NSURL URLWithString:@"https://library.calstate.edu/sandiego/authenticate/login?return=%2Fsandiego%2F&is_mobile=0"];
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithURL:URL];
    webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    self.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:webViewController animated:YES completion:NULL];
}




@end