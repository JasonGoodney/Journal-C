//
//  EntryDetailViewController.h
//  Journal-C
//
//  Created by Jason Goodney on 9/9/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"
#import "EntryController.h"

@interface EntryDetailViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) Entry *entry;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *entryTextView;

- (void) updateWithEntry:(Entry *)entry;

- (IBAction)saveButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)clearButtonTapped:(UIBarButtonItem *)sender;


@end
