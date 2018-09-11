//
//  EntryController.m
//  Journal-C
//
//  Created by Jason Goodney on 9/9/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

#import "EntryController.h"

@implementation EntryController

+ (EntryController *)shared
{
    static EntryController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [EntryController new];
    });
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.entries = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addEntry:(Entry *)entry {
    [_entries addObject:entry];
    
    if (![_entries isEqual:nil]) {
        [self saveToPersistantStore];
    }
}

- (void)removeEntry:(Entry *)entry {
    [_entries removeObject:entry];
    
    if (![_entries isEqual:nil]) {
        [self saveToPersistantStore];
    }
}

- (void)saveToPersistantStore {
    NSMutableDictionary *entriesDictionary = [[NSMutableDictionary alloc] init];
    
    for (Entry *entry in _entries) {
        [entriesDictionary addEntriesFromDictionary:entry.dictionaryCopy];
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:entriesDictionary
                                                   options:NSJSONWritingPrettyPrinted error:nil];
    [data writeToURL:self.fileURL options:NSDataWritingAtomic error:nil];
}

// 0 == true
// 1 == false
// The object to be compared to the receiver. May be nil, in which case this method returns NO.
// ^ so ![[NSData dataWithContentsOfURL:self.fileURL] isEqual:nil]?
- (void)loadFromPersistantStore {
    if (![[NSData dataWithContentsOfURL:self.fileURL] isEqual:nil]) {
        NSLog(@"data from fileURL is, %@ \nexpect: true(1)\nactual: (%d)",
              [NSData dataWithContentsOfURL:self.fileURL],
              [[NSData dataWithContentsOfURL:self.fileURL] isEqual:nil]);
        return;
    } else {
        NSLog(@"data from fileURL is, %@ \nexpect: false(0)\nactual: (%d)",
              [NSData dataWithContentsOfURL:self.fileURL],
              [[NSData dataWithContentsOfURL:self.fileURL] isEqual:nil]
              );
        // Logs data is null, isEqual:nil false
    }
    
    NSData *data = [[NSData alloc] init];
    // data == <>
    data = [NSData dataWithContentsOfURL:self.fileURL];
    // data == nil
    
    if (![data isEqual:nil]) {
        return;
    }
    
    NSDictionary *entriesDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    
    
    // Need entries to be NSMutableArray to add/remove objects.
    // mutableCopy allows NSArray instance to act as NSMutableArray
    //self.entries = [entries mutableCopy];
    
}

- (NSURL *)fileURL {
    NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSString *fileName = @"entries.json";
    NSURL *documentDirectoryURL = [paths[0] URLByAppendingPathExtension:fileName];
    return documentDirectoryURL;
    
    /*
        url
        file:///var/mobile/Containers/Data/Application/C2C36DBD-0A2A-4A94-A47B-5E0D4455A9FF/Documents.entries.json/
     */
}


@end

