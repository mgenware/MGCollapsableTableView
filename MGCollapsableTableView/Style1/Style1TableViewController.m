//
//  Style1TableViewController.m
//  MGCollapsableTableView
//
//  Created by Mgen on 15/11/10.
//  Copyright © 2015 Mgen. All rights reserved.
//  https://github.com/mgenware/MGCollapsableTableView
//

#import "Style1TableViewController.h"
#import "Style1TableViewHeaderView.h"

#define kSectionHeaderHeight            40.0
#define kCellHeight                     30.0
#define kCellID                         @"Cell"
#define kSectionHeaderID                @"SectionHeader"

@interface Style1TableViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *rightBarButton;
@property (assign, nonatomic) BOOL rightBarButtonExpandAllFlag;

@end

@implementation Style1TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *dataSource = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        NSMutableArray *cells = [NSMutableArray array];
        for (int j = 0; j < 5; j++) {
            [cells addObject:[NSString stringWithFormat:@"Cell %@", @(j + 1)]];
        }
        
        MGCollapsableTableViewSectionSource *section = [[MGCollapsableTableViewSectionSource alloc] initWithSectionInfo:[NSString stringWithFormat:@"Section %@", @(i + 1)] rows:cells];
        [dataSource addObject:section];
    }
    
    self.sections = dataSource;
    
    int i = 1;
    for (MGCollapsableTableViewSectionSource *sectionSource in self.sections) {
        sectionSource.sectionInfo = [NSString stringWithFormat:@"Section - %@", @(i)];
        i++;
    }
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"Style1TableViewHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:kSectionHeaderID];
    
    [self refreshRightBarButtonText];
}

- (IBAction)rightButtonClick:(id)sender {
    if (_rightBarButtonExpandAllFlag) {
        [self expandAllSections];
    } else {
        [self collapseAllSections];
    }
    _rightBarButtonExpandAllFlag = !_rightBarButtonExpandAllFlag;
    [self refreshRightBarButtonText];
}

- (void)refreshRightBarButtonText {
    [_rightBarButton setTitle:_rightBarButtonExpandAllFlag ? @"Expand All" : @"Collapse All"];
}

#pragma mark -
#pragma mark UITableView DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kSectionHeaderHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    
    NSString *text = [self.sections[indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Style1TableViewHeaderView *headerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:kSectionHeaderID];
    
    [self setupCollapsableSection:headerView sectionIndex:section];
    
    MGCollapsableTableViewSectionSource *sectionSource = self.sections[section];
    
    headerView.headerTextLabel.text = sectionSource.sectionInfo;
    headerView.tableViewSectionCollapsed = sectionSource.collapsed;
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

@end
