//
//  MailComposerViewController.h
//  SDSU Library
//
//  Created by Tyler Rogers on 9/21/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MailComposerViewController : UIViewController <MFMailComposeViewControllerDelegate>
{
	IBOutlet UILabel *message;
}

@property (nonatomic, retain) IBOutlet UILabel *message;

-(IBAction)showPicker:(id)sender;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;

@end
