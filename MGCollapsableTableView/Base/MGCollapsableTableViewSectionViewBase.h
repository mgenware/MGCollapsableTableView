//
//  MGCollapsableTableViewSectionBase.h
//  MGCollapsableTableView
//
//  Created by Mgen on 15/11/10.
//  Copyright © 2015 Mgen. All rights reserved.
//  https://github.com/mgenware/MGCollapsableTableView
//

#import <Foundation/Foundation.h>

@protocol MGCollapsableTableViewSectionViewBaseDelegate <NSObject>

@optional

/**
 * Invoked when Section View's tableViewSectionCollapsed property changes.
 */
- (void)collapseableSection:(id)sectionView isCollapsed:(BOOL)isCollapsed;

@end


@protocol MGCollapsableTableViewSectionViewBase <NSObject>

@required

/**
 * Delegates section view's events.
 */
@property (nonatomic, weak) id<MGCollapsableTableViewSectionViewBaseDelegate> delegate;

/**
 * Indicates whether this section view is collapsed.
 */
@property (nonatomic, assign) BOOL tableViewSectionCollapsed;

@end

