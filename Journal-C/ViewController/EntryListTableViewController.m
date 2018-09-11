//
//  JGEntryListTableViewController.m
//  Journal-C
//
//  Created by Jason Goodney on 9/9/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

#import "EntryListTableViewController.h"

@interface EntryListTableViewController ()

@end

@implementation EntryListTableViewController

static NSString * const reuseIdentifier = @"entryCell";
static NSString * const toEntryView = @"toEntryView";
static NSString * const toAddEntry = @"toAddEntry";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![[EntryController shared].entries isEqual:nil]) {
        [[EntryController shared] loadFromPersistantStore];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self tableView] reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return EntryController.shared.entries.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Entry *entry = [[EntryController shared].entries objectAtIndex:indexPath.row];
    
    cell.textLabel.text = entry.title;
    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Entry *entry = EntryController.shared.entries[indexPath.row];
        [EntryController.shared removeEntry:entry];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqual:toEntryView]) {
        
        EntryDetailViewController *destinationVC = [segue destinationViewController];
        
        NSInteger index = [self.tableView indexPathForSelectedRow].row;
        Entry *entry = EntryController.shared.entries[index];
        destinationVC.entry = entry;
    }
}


@end
