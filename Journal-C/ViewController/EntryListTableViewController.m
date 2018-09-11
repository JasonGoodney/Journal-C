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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"entryCell" forIndexPath:indexPath];
    
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
    if ([[segue identifier]  isEqual: @"toUpdateEntry"]) {
        
        EntryDetailViewController *destinationVC = [segue destinationViewController];
        
        NSInteger index = [self.tableView indexPathForSelectedRow].row;
        Entry *entry = EntryController.shared.entries[index];
        [destinationVC updateWithEntry:entry];
    }
}


@end
