//
//  RootViewController.m
//  Reordering
//
//  Created by Daniel Shusta on 12/31/10.
//  Copyright 2010 Acacia Tree Software. All rights reserved.
//

/*
	This is standard UITableViewController stuff. I wrote this first as a UITableViewController and then changed the superclass to ATSDragToReorderTableViewController.
 
	Then made three differences:
		Called [super viewDidUnload] in -viewDidUnload
		Implemented -tableView:moveRowAtIndexPath:toIndexPath:
		Disabled reordering if there's only one item in -tableView:numberOfRowsInSection: (more complicated tableViewControllers might need to check for this condition in other places too)
 */


#import "RootViewController.h"


@implementation RootViewController


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[ATSDragToReorderTableView alloc] initWithFrame:CGRectMake(0,0,[self.view bounds].size.width,[self.view bounds].size.height) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];

	self.navigationItem.title = @"Reordering";
	
	/*
		Populate array.
	 */
	if (self.arrayOfItems == nil) {
		
		NSUInteger numberOfItems = 20;
		
		self.arrayOfItems = [[NSMutableArray alloc] initWithCapacity:numberOfItems];
		
		for (NSUInteger i = 0; i < numberOfItems; ++i)
			[self.arrayOfItems addObject:[NSString stringWithFormat:@"Item #%i", i + 1]];
	}
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	[self.tableView flashScrollIndicators];
}


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	/*
		Disable reordering if there's one or zero items.
		For this example, of course, this will always be YES.
	 */
	[self.tableView setReorderingEnabled:( self.arrayOfItems.count > 1 )];
	
	return self.arrayOfItems.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	cell.textLabel.text = [self.arrayOfItems objectAtIndex:indexPath.row];
	
    return cell;
}

/*
	Required for drag tableview controller
 */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	
	NSString *itemToMove = [self.arrayOfItems objectAtIndex:fromIndexPath.row];
	[self.arrayOfItems removeObjectAtIndex:fromIndexPath.row];
	[self.arrayOfItems insertObject:itemToMove atIndex:toIndexPath.row];

}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	
	/*
		Must call super for ATSDragToReorderTableViewController. Doesn't matter when.
	 */
	[super viewDidUnload];
}




@end

