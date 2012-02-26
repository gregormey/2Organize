//
//  PreferenceController.h
//  2Organize
//
//  Created by Gregor Meyenberg on 26.02.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferenceController : NSWindowController {
    IBOutlet NSTextField *server;
    IBOutlet NSTextField *port;
    IBOutlet NSTextField *user;
    IBOutlet NSSecureTextField *password;
    IBOutlet NSButton *useTLS;
    
}

- (IBAction)changeMailSettings:(id)sender;

@end
