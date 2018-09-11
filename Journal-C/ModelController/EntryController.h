//
//  EntryController.h
//  Journal-C
//
//  Created by Jason Goodney on 9/9/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entry.h"

@interface EntryController : NSObject

// Singleton
+ (EntryController *) shared;

// Source of truth
@property (nonatomic, strong) NSMutableArray *entries;

- (void) addEntry:(Entry *)entry;
- (void) removeEntry:(Entry *)entry;
- (void) saveToPersistantStore;
- (void) loadFromPersistantStore;
- (NSURL *) fileURL;

@end
