//
//  MGCollapsableTableViewSectionSource.h
//  MGCollapsableTableView
//
//  Created by Mgen on 15/11/11.
//  Copyright © 2015 Mgen. All rights reserved.
//  https://github.com/mgenware/MGCollapsableTableView
//

#import <Foundation/Foundation.h>

/**
 * Section data object
 */
@interface MGCollapsableTableViewSectionSource : NSObject

/**
 * Custom section info.
 */
@property (nonatomic, strong) id sectionInfo;

/**
 * Indicates whether this section is collapsed.
 */
@property (nonatomic, assign) BOOL collapsed;

/**
 * Custom data for each rows.
 */
@property (nonatomic, strong) NSArray *rows;

/**
 * Creates a MGCollapsableTableViewSectionSource object with custom row data.
 */
- (instancetype)initWithRows:(NSArray *)rows;

/**
 * Creates a MGCollapsableTableViewSectionSource object with custom section info and row data.
 */
- (instancetype)initWithSectionInfo:(id)sectionInfo rows:(NSArray *)rows;

/**
 * A shortcut for [self.rows objectAtIndex:index].
 */
- (id)objectAtIndex:(NSUInteger)index;

@end
