//
//  _Organize_AppDelegate.h
//  2Organize
//
//  Created by Stephan Bansemer on 21.11.11.
//  Copyright Stephan Bansemer - Datenbankprogrammierung 2011 . All rights reserved.
//

#import <Cocoa/Cocoa.h>
//-->
#import "PXSourceList.h"
//<--

//@interface _Organize_AppDelegate : NSObject 
@interface _Organize_AppDelegate : NSObject <NSApplicationDelegate, PXSourceListDataSource, PXSourceListDelegate>
{
    NSWindow *window;
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
	//-->
	IBOutlet PXSourceList *sourceList;
	IBOutlet NSTextField *selectedItemLabel;
	NSMutableArray *sourceListItems;
	//<--
    IBOutlet NSDrawer *archivDrawer;
    IBOutlet NSTabView *tabView;
}

@property (nonatomic, retain) IBOutlet NSWindow *window;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:sender;
- (IBAction)toggleArchivDrawer:(id)sender;
- (IBAction)tabSelect:sender;

@end
