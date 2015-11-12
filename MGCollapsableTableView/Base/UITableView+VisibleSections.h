//
// Original Source: http://stackoverflow.com/questions/15204328/how-to-retrieve-all-visible-table-section-header-views/
//

#import <UIKit/UIKit.h>

@interface UITableView (VisibleSections)

// Returns an array of NSNumbers of the current visible section indexes
- (NSArray *)indexesOfVisibleSections;
// Returns an array of UITableViewHeaderFooterView objects of the current visible section headers
- (NSArray *)visibleSections;

@end
