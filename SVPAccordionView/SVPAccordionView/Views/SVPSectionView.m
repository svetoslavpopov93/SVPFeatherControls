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

static const CGFloat sectionBaseHeight = 30.0f;
@interface SVPSectionView()
@property (strong, nonatomic) UIView *contentView;
@property (assign, nonatomic) CGFloat separatorHeight;
@property (assign, nonatomic) NSInteger sectionElementsCount;
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
        
        UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [headerCellContainer addGestureRecognizer:singleFingerTap];
        
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

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    CGFloat sectionHeight = CGRectGetHeight(recognizer.view.superview.frame);
    
    if (sectionBaseHeight >= sectionHeight) {
        sectionHeight = sectionHeight * self.sectionElementsCount;
        
        for (NSInteger index = 0; index < recognizer.view.superview.subviews.count; index++) {
            
            [(SVPSectionView*)(recognizer.view.superview) setHeightConstraintConstant:100.0];
            [UIView animateWithDuration:0.5f animations:^{
                [recognizer.view.superview layoutIfNeeded];
                [recognizer.view.superview.superview layoutIfNeeded];
            }];
        }
    } else {
        sectionHeight = sectionBaseHeight;
        
        for (NSInteger index = 0; index < recognizer.view.superview.subviews.count; index++) {
            
            [(SVPSectionView*)(recognizer.view.superview) setHeightConstraintConstant:sectionHeight];
            [UIView animateWithDuration:0.5f animations:^{
                [recognizer.view.superview layoutIfNeeded];
                [recognizer.view.superview.superview layoutIfNeeded];
            }];
        }
    }
    
    NSLog(@""); // temp
}

@end

#warning TODO: Fix separator height on every place
