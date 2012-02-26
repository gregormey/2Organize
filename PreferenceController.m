//
//  PreferenceController.m
//  2Organize
//
//  Created by Gregor Meyenberg on 26.02.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PreferenceController.h"
NSString * const MAIL_SERVER=@"MAIL_SERVER";
NSString * const MAIL_PORT=@"MAIL_PORT";
NSString * const MAIL_USER=@"MAIL_USER";
NSString * const MAIL_PASSWORD=@"MAIL_PASSWORD";
NSString * const MAIL_USE_TLS=@"MAIL_USE_TLS";


@implementation PreferenceController

- (id)init
{
    if(![super initWithWindowNibName:@"Preferences"])
        return nil;
    
    return self;
}

- (BOOL)getUseTLS
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:MAIL_USE_TLS];
}

- (NSString *)getServer
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:MAIL_SERVER];
}  

- (NSString *)getPort
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:MAIL_PORT];
}  

- (NSString *)getPassword
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:MAIL_PASSWORD];
} 

- (NSString *)getUser
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:MAIL_USER];
} 

- (void)windowDidLoad
{
    NSLog(@"Nib file is loaded");
    [useTLS setState:[self getUseTLS]];
    [server setStringValue:[self getServer]];
    [port setStringValue:[self getPort]];
    [password setStringValue:[self getPassword]];
    [user setStringValue:[self getUser]];
    
    
}

- (IBAction)changeMailSettings:(id)sender
{
    NSLog(@"change mail settings");

    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setBool:[useTLS state] forKey:MAIL_USE_TLS];
    [defaults setObject:[server stringValue] forKey:MAIL_SERVER];
    [defaults setObject:[port stringValue] forKey:MAIL_PORT];
    [defaults setObject:[password stringValue] forKey:MAIL_PASSWORD];
    [defaults setObject:[user stringValue] forKey:MAIL_USER];
    
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
