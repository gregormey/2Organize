//
//  AppController.h
//  2Organize
//
//  Created by Gregor Meyenberg on 26.02.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class PreferenceController;

@interface AppController : NSObject{
    PreferenceController *preferenceController;
}
- (IBAction)showPreferencePanel:(id)sender;

@end
