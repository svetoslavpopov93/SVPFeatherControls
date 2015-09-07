//
//  SectionCellView.m
//  SVPAccordionView
//
//  Created by Svetoslav Popov on 9/2/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "SVPSectionView.h"
#import "SVPSectionHeaderCellView.h"
#import "SVPSectionCellView.h"
#import "SVPConstants.h"

@interface SVPSectionView() <SVPSectionHeaderCellViewProtocol>
@property (strong, nonatomic) UIView *contentView;
@property (assign, nonatomic) CGFloat separatorHeight;
@property (strong, nonatomic) NSLayoutConstraint *heightConstraint;
@end

@implementation SVPSectionView

- (instancetype)initWithSectionElements:(NSArray*)sectionElements {
    self = [super init];
    
    if (self) {
        _separatorHeight = 1.0f;
        _sectionElementsCount = 0;
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        _heightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:0
                                                        multiplier:1
                                                          constant:sectionBaseHeight];
        [self addConstraint:_heightConstraint];
        [self addSectionViews:sectionElements];

    }
    
    return self;
}

- (void) setHeightConstraintConstant: (CGFloat)constant{
    [self.heightConstraint setConstant:constant];
}

- (void)addSectionViews:(NSArray*)sectionElements {
    if ([sectionElements count] > 0) {
        UIView *headerCell = [sectionElements objectAtIndex:0];
        [headerCell setBackgroundColor:[UIColor greenColor]];// temp
        SVPSectionHeaderCellView *headerCellContainer = [[SVPSectionHeaderCellView alloc] initWithFrame:CGRectMake(CGRectGetMinX(headerCell.frame),
                                                                               CGRectGetMinY(headerCell.frame),
                                                                               CGRectGetWidth(headerCell.frame),
                                                                               CGRectGetHeight(headerCell.frame))];
        
        headerCellContainer.delegate = self;
        
        [headerCellContainer.contentView addSubview:headerCell];
        
        [self addSubview:headerCellContainer];
        self.sectionElementsCount++;
        
        for (NSInteger index = 1; index < [sectionElements count]; index++) {
            UIView *cell =[sectionElements objectAtIndex:index];
            
            SVPSectionCellView *sectionCell = [[SVPSectionCellView alloc] init];
            [sectionCell setFrame:CGRectMake(CGRectGetMinX(cell.frame),
                                            CGRectGetMinY(cell.frame),
                                            CGRectGetWidth(cell.frame),
                                             CGRectGetHeight(cell.frame))];
            
            
            [sectionCell.contentView addSubview:cell];
            
            [self insertSubview:sectionCell belowSubview:headerCellContainer];
            self.sectionElementsCount++;
        }
    }
}

-(void)userDidTapOnHeader{
    
    [self.delegate sectionWillResize:self];
    //    NSLog(@""); // temp
}

@end

#warning TODO: Fix separator height on every place
