//
//  LCList.m
//  SDSU Library
//
//  Created by Tyler Rogers on 8/24/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import "LCList.h"

static NSArray *_allCallNumbers;

@interface LCList () {
    NSAttributedString *_attributedText;
}

@property (nonatomic, assign, getter=shouldStripRichFormatting) BOOL stripRichFormatting;
@end

@implementation LCList
+ (NSArray *)allCallNumbers
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *callNumbers = [NSMutableArray array];
        
        LCList *currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"A - General";
        currentCallNumber.textStoragePath = @"lcco_a.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"B - Philosophy. Psychology. Religion";
        currentCallNumber.textStoragePath = @"lcco_b.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"C - Sciences of History";
        currentCallNumber.textStoragePath = @"lcco_c.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"D - World History";
        currentCallNumber.textStoragePath = @"lcco_d.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"E-F - History of the Americas";
        currentCallNumber.textStoragePath = @"lcco_ef.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"G - Geography, Anthropology, Recreation";
        currentCallNumber.textStoragePath = @"lcco_g.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"H - Social Sciences ";
        currentCallNumber.textStoragePath = @"lcco_h.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"J - Political Science";
        currentCallNumber.textStoragePath = @"lcco_j.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"K - Law";
        currentCallNumber.textStoragePath = @"lcco_k.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"L - Education";
        currentCallNumber.textStoragePath = @"lcco_l.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"M - Music";
        currentCallNumber.textStoragePath = @"lcco_m.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"N - Art";
        currentCallNumber.textStoragePath = @"lcco_n.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"P - Language and Literature";
        currentCallNumber.textStoragePath = @"lcco_p.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"Q - Science";
        currentCallNumber.textStoragePath = @"lcco_q.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"R - Medicine";
        currentCallNumber.textStoragePath = @"lcco_r.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"S - Agriculture";
        currentCallNumber.textStoragePath = @"lcco_s.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"T - Technology";
        currentCallNumber.textStoragePath = @"lcco_t.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"U - Military Science";
        currentCallNumber.textStoragePath = @"lcco_u.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"V - Naval Science";
        currentCallNumber.textStoragePath = @"lcco_v.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"Z - Library Science";
        currentCallNumber.textStoragePath = @"lcco_z.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        currentCallNumber = [[LCList alloc] init];
        currentCallNumber.title = @"U.S. Government Documents";
        currentCallNumber.textStoragePath = @"SUDOC.rtf";
        currentCallNumber.viewControllerIdentifier = @"LCBasicInteractionViewController";
        [callNumbers addObject:currentCallNumber];
        currentCallNumber = nil;
        
        
        
        
        //NSUInteger totalCallNumbers = 20;

        _allCallNumbers = [callNumbers copy];
    });
    
    return _allCallNumbers;
}

+ (LCList *)callNumberForIndexPath:(NSIndexPath *)anIndexPath
{
    return [[self allCallNumbers] objectAtIndex:[anIndexPath row]];
}

+ (NSUInteger)callNumberCount
{
    return [[self allCallNumbers] count];
}

- (NSAttributedString *)attributedText
{
    if (!_attributedText) {
        NSURL *url = nil;
        
        if (self.textStoragePath) {
            url = [[NSBundle mainBundle] URLForResource:self.textStoragePath withExtension:nil];
        } else {
            url = [[NSBundle mainBundle] URLForResource:self.title withExtension:@"rtf"];
        }
        
        if (!url) {
            return [[NSAttributedString alloc] initWithString:@""];
        }
        
        if (!self.stripRichFormatting) {
            NSMutableAttributedString *attributedTextHolder = [[NSMutableAttributedString alloc] initWithURL:url options:@{} documentAttributes:nil error:nil];
            [attributedTextHolder addAttribute:NSFontAttributeName value:[UIFont preferredFontForTextStyle:UIFontTextStyleBody] range:NSMakeRange(0, attributedTextHolder.length)];
            
            _attributedText = [attributedTextHolder copy];
        } else {
            NSString *newFlatText = [[[NSAttributedString alloc] initWithURL:url options:@{} documentAttributes:nil error:nil] string];
            _attributedText = [[NSAttributedString alloc] initWithString:newFlatText attributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]}];
        }
    }
    
    return _attributedText;
}
@end
