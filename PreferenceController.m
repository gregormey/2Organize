//
//  PreferenceController.m
//  2Organize
//
//  Created by Gregor Meyenberg on 26.02.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PreferenceController.h"

@implementation PreferenceController

- (id)init
{
    if(![super initWithWindowNibName:@"Preferences"])
        return nil;
    
    return self;
}

- (void)windowDidLoad
{
    NSLog(@"Nib file is loaded");
}

- (IBAction)changeMailSettings:(id)sender
{
    NSLog(@"change mail settings");
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}



@end
