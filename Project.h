//
//  Project.h
//  2Organize
//
//  Created by Bansemer Stephan on 02.01.12.
//  Copyright (c) 2012 Stephan Bansemer - Datenbankprogrammierung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Project;

@interface Project : NSManagedObject

@property (nonatomic, retain) NSNumber * badge;
@property (nonatomic, retain) NSNumber * archived;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSData * icon;
@property (nonatomic, retain) NSNumber * sort;
@property (nonatomic, retain) Project *parent;
@property (nonatomic, retain) NSSet *todos;
@property (nonatomic, retain) NSSet *files;
@property (nonatomic, retain) NSSet *children;
@property (nonatomic, retain) NSSet *contacts;
@property (nonatomic, retain) NSSet *persons;
@property (nonatomic, retain) NSSet *events;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addTodosObject:(NSManagedObject *)value;
- (void)removeTodosObject:(NSManagedObject *)value;
- (void)addTodos:(NSSet *)values;
- (void)removeTodos:(NSSet *)values;
- (void)addFilesObject:(NSManagedObject *)value;
- (void)removeFilesObject:(NSManagedObject *)value;
- (void)addFiles:(NSSet *)values;
- (void)removeFiles:(NSSet *)values;
- (void)addChildrenObject:(Project *)value;
- (void)removeChildrenObject:(Project *)value;
- (void)addChildren:(NSSet *)values;
- (void)removeChildren:(NSSet *)values;
- (void)addContactsObject:(NSManagedObject *)value;
- (void)removeContactsObject:(NSManagedObject *)value;
- (void)addContacts:(NSSet *)values;
- (void)removeContacts:(NSSet *)values;
- (void)addPersonsObject:(NSManagedObject *)value;
- (void)removePersonsObject:(NSManagedObject *)value;
- (void)addPersons:(NSSet *)values;
- (void)removePersons:(NSSet *)values;
- (void)addEventsObject:(NSManagedObject *)value;
- (void)removeEventsObject:(NSManagedObject *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;
@end
