//
//  SectionCellView.h
//  SVPAccordionView
//
//  Created by Svetoslav Popov on 9/2/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVPSectionView : UIView
- (instancetype)initWithSectionElements:(NSArray*)sectionElements;

- (void) setHeightConstraintConstant: (CGFloat)constant;
@end
