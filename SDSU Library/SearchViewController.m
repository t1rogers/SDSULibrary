//
//  SearchViewController.m
//  SDSU Library
//
//  Created by Tyler Rogers on 2/15/15.
//  Copyright (c) 2015 San Diego State University. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SearchViewController.h"

@import SafariServices;
@implementation SearchViewController

-(void)viewDidLoad {
    self.view.backgroundColor = [UIColor grayColor];

}

-(void)pacSearchViewController {
    NSURL *URL = [NSURL URLWithString:@"http://m.libpac.sdsu.edu"];
    SFSafariViewController *webViewController = [[SFSafariViewController alloc] initWithURL:URL];
    webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    self.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:webViewController animated:YES completion:NULL];
}

-(void)xerxesSearchViewController {
    NSURL *URL = [NSURL URLWithString:@"http://library.calstate.edu/sandiego/articles/"];
    SFSafariViewController *webViewController = [[SFSafariViewController alloc] initWithURL:URL];
    webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    self.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:webViewController animated:YES completion:NULL];
}

-(void)readingListController {
    NSURL *URL = [NSURL URLWithString:@"https://library.calstate.edu/sandiego/authenticate/login?return=%2Fsandiego%2F&is_mobile=0"];
    SFSafariViewController *webViewController = [[SFSafariViewController alloc] initWithURL:URL];
    webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    self.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:webViewController animated:YES completion:NULL];
}

-(void)dbazController {
    NSURL *URL = [NSURL URLWithString:@"https://library.calstate.edu/sandiego/authenticate/login?return=%2Fsandiego%2F&is_mobile=0"];
    SFSafariViewController *webViewController = [[SFSafariViewController alloc] initWithURL:URL];
    webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    self.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:webViewController animated:YES completion:NULL];
}

-(void)researchGuidesController {
    NSURL *URL = [NSURL URLWithString:@"https://library.calstate.edu/sandiego/authenticate/login?return=%2Fsandiego%2F&is_mobile=0"];
    SFSafariViewController *webViewController = [[SFSafariViewController alloc] initWithURL:URL];
    webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    self.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:webViewController animated:YES completion:NULL];
}


@end