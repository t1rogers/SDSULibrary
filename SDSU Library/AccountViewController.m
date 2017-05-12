//
//  AccountViewController.m
//  SDSU Library
//
//  Created by Tyler Rogers on 5/9/17.
//  Copyright © 2017 San Diego State University. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AccountViewController.h"

@import SafariServices;
@implementation AccountViewController

-(void)viewDidLoad {
    self.view.backgroundColor = [UIColor grayColor];
    
}

-(void)accountViewController {
    NSURL *URL = [NSURL URLWithString:@"https://sdsu-primo.hosted.exlibrisgroup.com/primo-explore/account?vid=01CALS_SDL&section=overview&lang=en_US"];
    SFSafariViewController *webViewController = [[SFSafariViewController alloc] initWithURL:URL];
    webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:webViewController animated:YES completion:NULL];
}


-(void)readingListViewController {
    NSURL *URL = [NSURL URLWithString:@"https://sdsu-primo.hosted.exlibrisgroup.com/primo-explore/favorites?vid=01CALS_SDL&lang=en_US&section=items"];
    SFSafariViewController *webViewController = [[SFSafariViewController alloc] initWithURL:URL];
    webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:webViewController animated:YES completion:NULL];
}





@end
