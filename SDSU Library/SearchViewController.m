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

-(void)oneSearchViewController {
    NSURL *URL = [NSURL URLWithString:@"https://sdsu-primo.hosted.exlibrisgroup.com/primo-explore/search?vid=01CALS_SDL&sortby=rank&lang=en_US"];
    SFSafariViewController *webViewController = [[SFSafariViewController alloc] initWithURL:URL];
    webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:webViewController animated:YES completion:NULL];
}


-(void)dbazController {
    NSURL *URL = [NSURL URLWithString:@"http://library.sdsu.edu/guides/dbaz.php"];
    SFSafariViewController *webViewController = [[SFSafariViewController alloc] initWithURL:URL];
    webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:webViewController animated:YES completion:NULL];
}

-(void)researchGuidesController {
    NSURL *URL = [NSURL URLWithString:@"http://library.sdsu.edu/guides/index.php"];
    SFSafariViewController *webViewController = [[SFSafariViewController alloc] initWithURL:URL];
    webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:webViewController animated:YES completion:NULL];
}


@end
