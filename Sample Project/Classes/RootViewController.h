//
//  RootViewController.h
//  Reordering
//
//  Created by Daniel Shusta on 12/31/10.
//  Copyright 2010 Acacia Tree Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATSDragToReorderTableView.h"

@interface RootViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *arrayOfItems;
@property (nonatomic, strong) ATSDragToReorderTableView *tableView;
@end
