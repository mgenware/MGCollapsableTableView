//
//  MGCollapsableTableViewController.h
//  MGCollapsableTableView
//
//  Created by Mgen on 15/11/10.
//  Copyright © 2015 Mgen. All rights reserved.
//  https://github.com/mgenware/MGCollapsableTableView
//

#import <UIKit/UIKit.h>
#import "MGCollapsableTableViewSectionViewBase.h"
#import "MGCollapsableTableViewSectionSource.h"

/**
 * Base class for implementing a collapsable UITableViewController
 */
@interface MGCollapsableTableViewController : UITableViewController<MGCollapsableTableViewSectionViewBaseDelegate>

/**
 * Section data, array of MGCollapsableTableViewSectionSource object.
 */
@property (nonatomic, strong) NSArray<MGCollapsableTableViewSectionSource *> *sections;

/**
 * Note to subclass implementation:  call this method in "- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section", this method will delegate UI(MGCollapsableTableViewSectionViewBase object) events to UITableViewController.
 */
- (id<MGCollapsableTableViewSectionViewBase>)setupCollapsableSection:(id<MGCollapsableTableViewSectionViewBase>)sectionView sectionIndex:(NSInteger)sectionIndex;

/**
 * Collapses all section headers.
 */
- (void)collapseAllSections;

/**
 * Expands all section headers.
 */
- (void)expandAllSections;

/**
 * Collapses a section header by specified index.
 */
- (void)collapseSection:(NSUInteger)section;

/**
 * Expands a section header by specified index.
 */
- (void)expandSection:(NSUInteger)section;

@end
