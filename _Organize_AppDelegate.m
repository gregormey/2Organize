//
//  _Organize_AppDelegate.m
//  2Organize
//
//  Created by Stephan Bansemer on 21.11.11.
//  Copyright Stephan Bansemer - Datenbankprogrammierung 2011 . All rights reserved.
//

#import "_Organize_AppDelegate.h"
//-->
#import "SourceListItem.h"
//<--

@implementation _Organize_AppDelegate

@synthesize window;

//-->
#pragma mark -
#pragma mark Init

- (void)awakeFromNib
{
	[selectedItemLabel setStringValue:@"(none)"];
	
	sourceListItems = [[NSMutableArray alloc] init];
	
	//Set up the "Topic1" parent item and children
	SourceListItem *Topic1 = [SourceListItem itemWithTitle:@"Topic1" identifier:@"Topic1"];
    
	SourceListItem *Topic1Sub1 = [SourceListItem itemWithTitle:@"Topic1Sub1" identifier:@"Topic1Sub1"];
	SourceListItem *Topic1Sub2 = [SourceListItem itemWithTitle:@"Topic1Sub2" identifier:@"Topic1Sub2"];
	SourceListItem *Topic1Sub3 = [SourceListItem itemWithTitle:@"Topic1Sub3" identifier:@"Topic1Sub3"];
	SourceListItem *Topic1Sub4 = [SourceListItem itemWithTitle:@"Topic1Sub4" identifier:@"Topic1Sub4"];
	[Topic1Sub1 setIcon:[NSImage imageNamed:@"Item.png"]];
	[Topic1Sub2 setIcon:[NSImage imageNamed:@"Item.png"]];
	[Topic1Sub3 setIcon:[NSImage imageNamed:@"Item.png"]];
	[Topic1Sub4 setIcon:[NSImage imageNamed:@"Item.png"]];
    [Topic1Sub3 setBadgeValue:20];
    
	[Topic1 setChildren:[NSArray arrayWithObjects:Topic1Sub1, Topic1Sub2, Topic1Sub3,Topic1Sub4, nil]];
		
	//Set up the "Topic2" parent item and children
	SourceListItem *Topic2 = [SourceListItem itemWithTitle:@"Topic2" identifier:@"Topic2"];
	
	//Create a second-level group to Topic2
	SourceListItem *Topic2Sub1 = [SourceListItem itemWithTitle:@"Topic2Sub1" identifier:@"Topic2Sub1"];
	SourceListItem *Topic2Sub2 = [SourceListItem itemWithTitle:@"Topic2Sub2" identifier:@"Topic2Sub2"];
	SourceListItem *Topic2Sub3 = [SourceListItem itemWithTitle:@"Topic2Sub3" identifier:@"Topic2Sub3"];
	[Topic2Sub1 setIcon:[NSImage imageNamed:@"Item.png"]];
	[Topic2Sub2 setIcon:[NSImage imageNamed:@"Item.png"]];
	[Topic2Sub3 setIcon:[NSImage imageNamed:@"Item.png"]];
	
	SourceListItem *Topic2SubGroup1 = [SourceListItem itemWithTitle:@"Topic2SubGroup1" identifier:@"Topic2SubGroup1"];
	SourceListItem *Topic2SubGroup1Sub1 = [SourceListItem itemWithTitle:@"Topic2SubGroup1Sub1" identifier:@"Topic2SubGroup1Sub1"];
    
	[Topic2SubGroup1 setIcon:[NSImage imageNamed:@"Folder.png"]];
	[Topic2SubGroup1Sub1 setIcon:[NSImage imageNamed:@"Item.png"]];
	[Topic2SubGroup1 setChildren:[NSArray arrayWithObject:Topic2SubGroup1Sub1]];
	
	[Topic2 setChildren:[NSArray arrayWithObjects:Topic2Sub1, Topic2SubGroup1,Topic2Sub2,
								Topic2Sub3, nil]];
	
	[sourceListItems addObject:Topic1];
	[sourceListItems addObject:Topic2];
	
	[sourceList reloadData];
}

#pragma mark Segment Control
- (IBAction)tabSelect:sender
{
    //NSLog(@"Segment control was clicked: segment %ld", [sender selectedSegment]);
    [tabView selectTabViewItemAtIndex:[sender selectedSegment]];
}

#pragma mark Drawers
- (void)toggleArchivDrawer:(id)sender {
    [archivDrawer setMinContentSize:NSMakeSize(328, 220)];
    [archivDrawer setMaxContentSize:NSMakeSize(328, 220)];
    NSDrawerState state = [archivDrawer state];
    if (NSDrawerOpeningState == state || NSDrawerOpenState == state) {
        [archivDrawer close];
    } else {
        [archivDrawer openOnEdge:NSMaxXEdge];
    }
}

#pragma mark -
#pragma mark Source List Data Source Methods

- (NSUInteger)sourceList:(PXSourceList*)sourceList numberOfChildrenOfItem:(id)item
{
	//Works the same way as the NSOutlineView data source: `nil` means a parent item
	if(item==nil) {
		return [sourceListItems count];
	}
	else {
		return [[item children] count];
	}
}


- (id)sourceList:(PXSourceList*)aSourceList child:(NSUInteger)index ofItem:(id)item
{
	//Works the same way as the NSOutlineView data source: `nil` means a parent item
	if(item==nil) {
		return [sourceListItems objectAtIndex:index];
	}
	else {
		return [[item children] objectAtIndex:index];
	}
}


- (id)sourceList:(PXSourceList*)aSourceList objectValueForItem:(id)item
{
	return [item title];
}


- (void)sourceList:(PXSourceList*)aSourceList setObjectValue:(id)object forItem:(id)item
{
	[item setTitle:object];
}


- (BOOL)sourceList:(PXSourceList*)aSourceList isItemExpandable:(id)item
{
	return [item hasChildren];
}


- (BOOL)sourceList:(PXSourceList*)aSourceList itemHasBadge:(id)item
{
	return [item hasBadge];
}


- (NSInteger)sourceList:(PXSourceList*)aSourceList badgeValueForItem:(id)item
{
	return [item badgeValue];
}


- (BOOL)sourceList:(PXSourceList*)aSourceList itemHasIcon:(id)item
{
	return [item hasIcon];
}


- (NSImage*)sourceList:(PXSourceList*)aSourceList iconForItem:(id)item
{
	return [item icon];
}

- (NSMenu*)sourceList:(PXSourceList*)aSourceList menuForEvent:(NSEvent*)theEvent item:(id)item
{
	if ([theEvent type] == NSRightMouseDown || ([theEvent type] == NSLeftMouseDown && ([theEvent modifierFlags] & NSControlKeyMask) == NSControlKeyMask)) {
		NSMenu * m = [[NSMenu alloc] init];
		if (item != nil) {
			[m addItemWithTitle:[item title] action:nil keyEquivalent:@""];
		} else {
			[m addItemWithTitle:@"clicked outside" action:nil keyEquivalent:@""];
		}
		return [m autorelease];
	}
	return nil;
}

#pragma mark -
#pragma mark Source List Delegate Methods

- (BOOL)sourceList:(PXSourceList*)aSourceList isGroupAlwaysExpanded:(id)group
{
	if([[group identifier] isEqualToString:@"Topic1"])
		return YES;
    else if([[group identifier] isEqualToString:@"Topic2"])
		return YES;

	return NO;
}


- (void)sourceListSelectionDidChange:(NSNotification *)notification
{
	NSIndexSet *selectedIndexes = [sourceList selectedRowIndexes];
	
	//Set the label text to represent the new selection
	if([selectedIndexes count]>1)
		[selectedItemLabel setStringValue:@"(multiple)"];
	else if([selectedIndexes count]==1) {
		NSString *identifier = [[sourceList itemAtRow:[selectedIndexes firstIndex]] identifier];
		
		[selectedItemLabel setStringValue:identifier];
	}
	else {
		[selectedItemLabel setStringValue:@"(none)"];
	}
}


- (void)sourceListDeleteKeyPressedOnRows:(NSNotification *)notification
{
	NSIndexSet *rows = [[notification userInfo] objectForKey:@"rows"];
	
	NSLog(@"Delete key pressed on rows %@", rows);
	
	//Do something here
}
//<--

#pragma mark -
#pragma mark Core data template methods

/**
    Returns the support directory for the application, used to store the Core Data
    store file.  This code uses a directory named "_Organize" for
    the content, either in the NSApplicationSupportDirectory location or (if the
    former cannot be found), the system's temporary directory.
 */

- (NSString *)applicationSupportDirectory {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:@"_Organize"];
}


/**
    Creates, retains, and returns the managed object model for the application 
    by merging all of the models found in the application bundle.
 */
 
- (NSManagedObjectModel *)managedObjectModel {

    if (managedObjectModel) return managedObjectModel;
	
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
    Returns the persistent store coordinator for the application.  This 
    implementation will create and return a coordinator, having added the 
    store for the application to it.  (The directory for the store is created, 
    if necessary.)
 */

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {

    if (persistentStoreCoordinator) return persistentStoreCoordinator;

    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSAssert(NO, @"Managed object model is nil");
        NSLog(@"%@:%s No model to generate a store from", [self class], _cmd);
        return nil;
    }

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *applicationSupportDirectory = [self applicationSupportDirectory];
    NSError *error = nil;
    
    if ( ![fileManager fileExistsAtPath:applicationSupportDirectory isDirectory:NULL] ) {
		if (![fileManager createDirectoryAtPath:applicationSupportDirectory withIntermediateDirectories:NO attributes:nil error:&error]) {
            NSAssert(NO, ([NSString stringWithFormat:@"Failed to create App Support directory %@ : %@", applicationSupportDirectory,error]));
            NSLog(@"Error creating application support directory at %@ : %@",applicationSupportDirectory,error);
            return nil;
		}
    }
    
    NSURL *url = [NSURL fileURLWithPath: [applicationSupportDirectory stringByAppendingPathComponent: @"storedata"]];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: mom];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSXMLStoreType 
                                                configuration:nil 
                                                URL:url 
                                                options:nil 
                                                error:&error]){
        [[NSApplication sharedApplication] presentError:error];
        [persistentStoreCoordinator release], persistentStoreCoordinator = nil;
        return nil;
    }    

    return persistentStoreCoordinator;
}

/**
    Returns the managed object context for the application (which is already
    bound to the persistent store coordinator for the application.) 
 */
 
- (NSManagedObjectContext *) managedObjectContext {

    if (managedObjectContext) return managedObjectContext;

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    managedObjectContext = [[NSManagedObjectContext alloc] init];
    [managedObjectContext setPersistentStoreCoordinator: coordinator];

    return managedObjectContext;
}

/**
    Returns the NSUndoManager for the application.  In this case, the manager
    returned is that of the managed object context for the application.
 */
 
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window {
    return [[self managedObjectContext] undoManager];
}


/**
    Performs the save action for the application, which is to send the save:
    message to the application's managed object context.  Any encountered errors
    are presented to the user.
 */
 
- (IBAction) saveAction:(id)sender {

    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%s unable to commit editing before saving", [self class], _cmd);
    }

    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}


/**
    Implementation of the applicationShouldTerminate: method, used here to
    handle the saving of changes in the application managed object context
    before the application terminates.
 */
 
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {

    if (!managedObjectContext) return NSTerminateNow;

    if (![managedObjectContext commitEditing]) {
        NSLog(@"%@:%s unable to commit editing to terminate", [self class], _cmd);
        return NSTerminateCancel;
    }

    if (![managedObjectContext hasChanges]) return NSTerminateNow;

    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
    
        // This error handling simply presents error information in a panel with an 
        // "Ok" button, which does not include any attempt at error recovery (meaning, 
        // attempting to fix the error.)  As a result, this implementation will 
        // present the information to the user and then follow up with a panel asking 
        // if the user wishes to "Quit Anyway", without saving the changes.

        // Typically, this process should be altered to include application-specific 
        // recovery steps.  
                
        BOOL result = [sender presentError:error];
        if (result) return NSTerminateCancel;

        NSString *question = NSLocalizedString(@"Could not save changes while quitting.  Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];

        NSInteger answer = [alert runModal];
        [alert release];
        alert = nil;
        
        if (answer == NSAlertAlternateReturn) return NSTerminateCancel;

    }

    return NSTerminateNow;
}


/**
    Implementation of dealloc, to release the retained variables.
 */

#pragma mark -
#pragma mark dealloc

- (void)dealloc {

    [window release];
    [archivDrawer release];
    [managedObjectContext release];
    [persistentStoreCoordinator release];
    [managedObjectModel release];

	//-->
	[sourceListItems release];
	//<--

    [super dealloc];
}


@end
