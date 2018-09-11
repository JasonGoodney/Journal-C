//
//  JGEntryDetailViewController.m
//  Journal-C
//
//  Created by Jason Goodney on 9/9/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

#import "EntryDetailViewController.h"

@interface EntryDetailViewController ()

@end

@implementation EntryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)updateWithEntry:(Entry *)entry {
    _titleTextField.text = entry.title;
    _entryTextView.text = entry.text;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEEE, MMM d, yyyy";
    NSString *dateString = [formatter stringFromDate:entry.timestamp];
    
    [self navigationItem].title = dateString;
}

- (IBAction)saveButtonTapped:(UIBarButtonItem *)sender {
    
    if ([_titleTextField.text isEqual: @""] && [_entryTextView.text isEqual: @""]) {
        NSLog(@"empty textField");
        
    } else {
        NSString *title = _titleTextField.text;
        NSString *text = _entryTextView.text;
        
        NSLog(@"saving...");
        if (_entry == nil) {
            NSLog(@"new");
            Entry *entry = [[[Entry alloc] init] initWithTitle:title text:text];
            
            [EntryController.shared addEntry:entry];
        } else {
            NSLog(@"update");
            _entry.title = title;
            _entry.text = text;
            _entry.timestamp = [[NSDate alloc] init];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)clearButtonTapped:(UIBarButtonItem *)sender {
    NSLog(@"clearing...");
    [_titleTextField setText:@""];
    [_entryTextView setText:@""];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
