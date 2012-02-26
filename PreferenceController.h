//
//  PreferenceController.h
//  2Organize
//
//  Created by Gregor Meyenberg on 26.02.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const MAIL_SERVER;
extern NSString * const MAIL_PORT;
extern NSString * const MAIL_PASSWORD;
extern NSString * const MAIL_USE_TLS;
extern NSString * const MAIL_USE_USER;
extern NSString * const MAIL_USER;


@interface PreferenceController : NSWindowController {
    IBOutlet NSTextField *server;
    IBOutlet NSTextField *port;
    IBOutlet NSTextField *user;
    IBOutlet NSSecureTextField *password;
    IBOutlet NSButton *useTLS;
    
}

- (IBAction)changeMailSettings:(id)sender;

@end
