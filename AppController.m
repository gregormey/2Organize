//
//  AppController.m
//  2Organize
//
//  Created by Gregor Meyenberg on 26.02.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "PreferenceController.h"

@implementation AppController

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (IBAction)showPreferencePanel:(id)sender
{
    //Is preferenceController nil?
    if(!preferenceController){
        preferenceController = [[PreferenceController alloc] init];
        NSLog(@"showing %@", preferenceController);
        [preferenceController showWindow:self];
    }
}

@end
