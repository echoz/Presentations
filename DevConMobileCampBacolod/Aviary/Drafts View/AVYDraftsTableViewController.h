//
//  AVYDraftsTableViewController.h
//  Aviary
//
//  Created by Jeremy Foo on 21/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVYDraftsTableViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *drafts;

- (void)addButtonTapped:(id)sender;
@end
