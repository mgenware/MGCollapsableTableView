//
//  MGCollapsableTableViewSectionSource.m
//  MGCollapsableTableView
//
//  Created by Mgen on 15/11/11.
//  Copyright © 2015 Mgen. All rights reserved.
//  https://github.com/mgenware/MGCollapsableTableView
//

#import "MGCollapsableTableViewSectionSource.h"

@implementation MGCollapsableTableViewSectionSource

- (instancetype)initWithSectionInfo:(id)sectionInfo rows:(NSArray *)rows {
    self = [super init];
    if (self) {
        _sectionInfo = sectionInfo;
        _rows = rows;
    }
    
    return self;
}

- (instancetype)initWithRows:(NSArray *)rows {
    return [self initWithSectionInfo:nil rows:rows];
}

- (id)objectAtIndex:(NSUInteger)index {
    return [self.rows objectAtIndex:index];
}

@end
