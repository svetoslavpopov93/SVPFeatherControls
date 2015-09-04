//
//  SectionCellView.m
//  SVPAccordionView
//
//  Created by Svetoslav Popov on 9/2/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "SVPSectionCellView.h"
@interface SVPSectionCellView()
@property (strong, nonatomic) UIView *contentView;
@property (assign, nonatomic) CGFloat separatorHeight;
@property (assign, nonatomic) NSInteger sectionElementsCount;
@property (strong, nonatomic) NSLayoutConstraint *heightConstraint;
@end

@implementation SVPSectionCellView

- (instancetype)initWithSectionElements:(NSArray*)sectionElements {
    self = [super init];
    
    if (self) {
        _separatorHeight = 1.0f;
        _sectionElementsCount = 0;
        [self addSectionViews:sectionElements];
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        _heightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:0
                                                        multiplier:1
                                                          constant:30.0f];
        [self addConstraint:_heightConstraint];
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
        UIView *headerCellContainer = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(headerCell.frame),
                                                                               CGRectGetMinY(headerCell.frame),
                                                                               CGRectGetWidth(headerCell.frame),
                                                                               CGRectGetHeight(headerCell.frame) - self.separatorHeight)];
        UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [headerCellContainer addGestureRecognizer:singleFingerTap];
        
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                     CGRectGetHeight(headerCellContainer.frame),
                                                                     CGRectGetWidth(headerCellContainer.frame),
                                                                     self.separatorHeight)];
        [separator setBackgroundColor:[UIColor grayColor]];
        [headerCellContainer addSubview:headerCell];
        [headerCellContainer addSubview:separator];
        
        [self addSubview:headerCellContainer];
        self.sectionElementsCount++;
        
        for (NSInteger index = 1; index < [sectionElements count]; index++) {
            UIView *cell =[sectionElements objectAtIndex:index];
            
            UIView *cellContainer = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(cell.frame),
                                                                             CGRectGetMinY(cell.frame),
                                                                             CGRectGetWidth(cell.frame),
                                                                             CGRectGetHeight(cell.frame) + self.separatorHeight)];
            
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                         CGRectGetHeight(cellContainer.frame) - self.separatorHeight,
                                                                         CGRectGetWidth(cellContainer.frame),
                                                                         self.separatorHeight)];
            
            [separator setBackgroundColor:[UIColor grayColor]];
            
            [cellContainer addSubview:cell];
            [cellContainer addSubview:separator];
            [self insertSubview:cellContainer belowSubview:headerCellContainer];
            self.sectionElementsCount++;
        }
    }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    CGFloat headerHeight =CGRectGetHeight(recognizer.view.frame);
    CGFloat sectionHeight = CGRectGetHeight(recognizer.view.superview.frame);
    
    if (headerHeight >= sectionHeight) {
        sectionHeight = sectionHeight * self.sectionElementsCount;
        
        for (NSInteger index = 0; index < recognizer.view.superview.subviews.count; index++) {
            
            [(SVPSectionCellView*)(recognizer.view.superview) setHeightConstraintConstant:100.0];
            [UIView animateWithDuration:0.5f animations:^{
                [recognizer.view.superview layoutIfNeeded];
                [recognizer.view.superview.superview layoutIfNeeded];
            }];
        }
    } else {
        sectionHeight = headerHeight;
        
        for (NSInteger index = 0; index < recognizer.view.superview.subviews.count; index++) {
            
            [(SVPSectionCellView*)(recognizer.view.superview) setHeightConstraintConstant:sectionHeight];
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
