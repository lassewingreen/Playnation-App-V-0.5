//
//  PNAppDelegate.h
//  Playnation App V 0.5
//
//  Created by Lasse Wingreen on 10/02/14.
//  Copyright (c) 2014 Playnation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
