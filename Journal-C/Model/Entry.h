//
//  Entry.h
//  Journal-C
//
//  Created by Jason Goodney on 9/9/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject

@property NSDate *timestamp;
@property NSString *title;
@property NSString *text;

- (instancetype) initWithTitle:(NSString *)title text:(NSString *)text;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *) dictionaryCopy;

@end
