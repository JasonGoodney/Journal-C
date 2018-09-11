//
//  Entry.m
//  Journal-C
//
//  Created by Jason Goodney on 9/9/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

#import "Entry.h"

@implementation Entry

static NSString * const TimeStampKey = @"timestamp";
static NSString * const TitleKey = @"title";
static NSString * const TextKey = @"text";

- (instancetype)initWithTitle:(NSString *)title text:(NSString *)text {
    self = [super init];
    if (self) {
        _title = title;
        _text = text;
        _timestamp = [NSDate date];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        if ([dictionary[TimeStampKey] isEqual:nil] ||
            [dictionary[TitleKey] isEqual:nil] ||
            [dictionary[TextKey] isEqual:nil]) {
            return nil;
        }
        
        _title = dictionary[TitleKey];
        _text = dictionary[TextKey];
        _timestamp = dictionary[TimeStampKey];
    }
    return self;
}

- (NSMutableDictionary *)dictionaryCopy {
    NSMutableDictionary *dictionaryToReturn = nil;
    dictionaryToReturn[TitleKey] = _title;
    dictionaryToReturn[TextKey] = _text;
    dictionaryToReturn[TimeStampKey] = _timestamp;
    
    return dictionaryToReturn;
}

@end
