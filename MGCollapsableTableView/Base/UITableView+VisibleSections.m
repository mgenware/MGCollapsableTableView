
#import "UITableView+VisibleSections.h"

@implementation UITableView (VisibleSections)

- (NSArray *)indexesOfVisibleSections {
    // Note: We can't just use indexPathsForVisibleRows, since it won't return index paths for empty sections.
    NSMutableArray *visibleSectionIndexes = [NSMutableArray arrayWithCapacity:self.numberOfSections];
    for (int i = 0; i < self.numberOfSections; i++) {
        CGRect headerRect;
        // In plain style, the section headers are floating on the top, so the section header is visible if any part of the section's rect is still visible.
        // In grouped style, the section headers are not floating, so the section header is only visible if it's actualy rect is visible.
        if (self.style == UITableViewStylePlain) {
            headerRect = [self rectForSection:i];
        } else {
            headerRect = [self rectForHeaderInSection:i];
        }
        // The "visible part" of the tableView is based on the content offset and the tableView's size.
        CGRect visiblePartOfTableView = CGRectMake(self.contentOffset.x, self.contentOffset.y, self.bounds.size.width, self.bounds.size.height);
        if (CGRectIntersectsRect(visiblePartOfTableView, headerRect)) {
            [visibleSectionIndexes addObject:@(i)];
        }
    }
    return visibleSectionIndexes;
}

- (NSArray *)visibleSections {
    NSMutableArray *visibleSects = [NSMutableArray arrayWithCapacity:self.numberOfSections];
    for (NSNumber *sectionIndex in self.indexesOfVisibleSections) {
        UITableViewHeaderFooterView *sectionHeader = [self headerViewForSection:sectionIndex.intValue];
        [visibleSects addObject:sectionHeader];
    }
    
    return visibleSects;
}

@end
