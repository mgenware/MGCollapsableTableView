//
//  MGCollapsableTableViewController.m
//  MGCollapsableTableView
//
//  Created by Mgen on 15/11/10.
//  Copyright © 2015 Mgen. All rights reserved.
//  https://github.com/mgenware/MGCollapsableTableView
//

#import "MGCollapsableTableViewController.h"
#import "UITableView+VisibleSections.h"

@interface MGCollapsableTableViewController ()
{
}
@end

@implementation MGCollapsableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Public Methods

/**
 * Note to subclass: call this method in "- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section", this will delegate MGCollapsableTableViewSectionViewBase events to UITableViewController.
 */
- (id<MGCollapsableTableViewSectionViewBase>)setupCollapsableSection:(UIView<MGCollapsableTableViewSectionViewBase> *)sectionView sectionIndex:(NSInteger)sectionIndex {
    
    NSAssert(sectionView, @"sectionView cannot be nil");
    sectionView.delegate = self;
    sectionView.tag = sectionIndex;
    return sectionView;
}

/**
 * Collapse all section headers.
 */
- (void)collapseAllSections {
    [self batchSetSectionState:YES];
}

/**
 * Expand all section headers.
 */
- (void)expandAllSections {
    [self batchSetSectionState:NO];
}

- (void)collapseSection:(NSUInteger)section {
    [self setSectionState:section collapsed:YES];
}

- (void)expandSection:(NSUInteger)section {
    [self setSectionState:section collapsed:NO];
}

#pragma mark -
#pragma mark Internal Methods

- (void)setSectionState:(NSUInteger)section collapsed:(BOOL)collapsed {
    [self.tableView beginUpdates];
    [self setSectionState:section isCollapsed:collapsed];
    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

- (void)batchSetSectionState:(BOOL)collapsed {
    [self.tableView beginUpdates];
    for (int i = 0; i < [self.tableView numberOfSections]; i++) {
        [self setSectionState:i isCollapsed:collapsed];
    }
    [self reloadVisibleSections];
    [self.tableView endUpdates];
}

/**
 * Returns an array of all NSIndexPath objects from a section index
 */
- (NSArray *)allIndexPathsFromSection:(NSInteger)section {
    NSInteger numOfRows = [self.sections[section] rows].count;
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (int i = 0; i < numOfRows; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    return indexPaths;
}

/**
 * Returns section index from a section view.
 */
- (NSInteger)collapsableSectionIndexFromSectionView:(UIView *)sectionView {
    NSAssert(sectionView, @"sectionView cannot be nil");
    return sectionView.tag;
}

/**
 * Reloads all visible sections in UITableView.
 */
- (void)reloadVisibleSections {
    NSMutableIndexSet *visibleSections = [[NSMutableIndexSet alloc] init];
    NSArray *sectionArray = [self.tableView indexesOfVisibleSections];
    for (NSNumber *index in sectionArray) {
        [visibleSections addIndex:[index unsignedIntegerValue]];
    }
    
    [self.tableView reloadSections:visibleSections withRowAnimation:UITableViewRowAnimationFade];
}

/**
 * This will set collapsed property on internal section data object(MGCollapsableTableViewSectionSource) and update UITableView section.
 */
- (void)setSectionState:(NSUInteger)section isCollapsed:(BOOL)isCollapsed {
    MGCollapsableTableViewSectionSource *sectionSource = _sections[section];
    if (sectionSource.collapsed == isCollapsed) {
        return;
    }
    
    NSArray *indexPaths = [self allIndexPathsFromSection:section];
    sectionSource.collapsed = isCollapsed;

    if (isCollapsed) {
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    } else {
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    }
}

#pragma mark -
#pragma mark UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSAssert(_sections, @"sections cannot be nil");
    
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MGCollapsableTableViewSectionSource *sectionSource = _sections[section];
    if (sectionSource.collapsed) {
        return 0;
    }
    return sectionSource.rows.count;
}

#pragma mark -
#pragma mark MGCollapsableTableViewSectionBaseDelegate

- (void)collapseableSection:(id)sectionView isCollapsed:(BOOL)isCollapsed {
    NSInteger sectionIndex = [self collapsableSectionIndexFromSectionView:sectionView];
    
    [self.tableView beginUpdates];
    [self setSectionState:sectionIndex isCollapsed:isCollapsed];
    [self.tableView endUpdates];
}

@end
