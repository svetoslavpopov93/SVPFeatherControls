//
//  SVPAccordion.m
//  SVPAccordionView
//
//  Created by Svetoslav Popov on 9/2/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "SVPAccordion.h"
#import "SVPSectionCellView.h"

@interface SVPAccordion()

@property (strong, nonatomic) UIScrollView *accordion;
@property (strong, nonatomic) NSArray *sections;
@property (assign, nonatomic) CGFloat ySectionPosition;
@property (assign, nonatomic) CGFloat separatorHeight;
@property (strong, nonatomic) UIView *previousElement;

@end

@implementation SVPAccordion

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sections = [[NSArray alloc] init];
        [self addSubviews];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _sections = [[NSArray alloc] init];
    [self addSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _sections = [[NSArray alloc] init];
        _separatorHeight = 1.0f;
        _accordion = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    self.ySectionPosition = 0.0f;

    
    [_accordion setBackgroundColor:[UIColor blueColor]];
    [self addSubview:_accordion];
    
    [self setAccordionConstraints];
}

- (void)setAccordionConstraints{
    [_accordion setTranslatesAutoresizingMaskIntoConstraints:NO];// Set accordion constraints

    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.accordion
                                                                         attribute:NSLayoutAttributeLeading
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeLeading
                                                                        multiplier:1
                                                                          constant:0];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.accordion
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:0];
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.accordion
                                                                          attribute:NSLayoutAttributeTrailing
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeTrailing
                                                                         multiplier:1
                                                                           constant:0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.accordion
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self 
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1
                                                                         constant:0];
    
    [self addConstraint:leadingConstraint];
    [self addConstraint:topConstraint];
    [self addConstraint:trailingConstraint];
    [self addConstraint:bottomConstraint];
    
    
//    NSDictionary *views = NSDictionaryOfVariableBindings(_accordion);
//    
//    NSArray *accordionHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_accordion]|"
//                                                                                      options:0
//                                                                                      metrics:nil
//                                                                                        views:views];
//    
//    NSArray *accordionVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_accordion]|"
//                                                                                    options:0
//                                                                                    metrics:nil
//                                                                                      views:views];
//    [self addConstraints:accordionHorizontalConstraints];
//    [self addConstraints:accordionVerticalConstraints];
}

- (void) reloadAccordion{    
    for (NSInteger index = 0; index < [self getNumberOfSections]; index++) {
        NSMutableArray *sectionElementsArray = [NSMutableArray new];
        [sectionElementsArray addObject:[self getViewForSectionHeaderAtIndex:index]];
        NSInteger numberOfRows = [self getNumberOfRowsInSection:index];
        
        for (NSInteger rowIndex = 0; rowIndex < numberOfRows; rowIndex++) {
            [sectionElementsArray addObject: [self getCellForRowAtIndexPath:[NSIndexPath indexPathForRow:rowIndex inSection:index]]];
        }
        
        SVPSectionCellView *sectionCell = [[SVPSectionCellView alloc] initWithSectionElements:[NSArray arrayWithArray:sectionElementsArray]];
        
        // TEMP
        if (index % 2 == 0) {
            [sectionCell setBackgroundColor:[UIColor purpleColor]];
        } else {
            [sectionCell setBackgroundColor:[UIColor redColor]];
        }
        
        [self.accordion addSubview:sectionCell];
        
        [sectionCell setHeightConstraintConstant:CGRectGetHeight([[sectionElementsArray lastObject] frame])];
        
        NSLayoutConstraint *sectionCellWidthConstraint = [NSLayoutConstraint constraintWithItem:sectionCell
                                                                                      attribute:NSLayoutAttributeWidth
                                                                                      relatedBy:NSLayoutRelationEqual
                                                                                         toItem:nil
                                                                                      attribute:0
                                                                                     multiplier:1
                                                                                       constant:CGRectGetWidth(self.accordion.frame)];
        
        
        NSLayoutConstraint *sectionCellLeadingConstraint = [NSLayoutConstraint constraintWithItem:sectionCell
                                                                                        attribute:NSLayoutAttributeLeading
                                                                                        relatedBy:NSLayoutRelationEqual
                                                                                           toItem:self.accordion
                                                                                        attribute:NSLayoutAttributeLeading
                                                                                       multiplier:1
                                                                                         constant:0];
        
        NSLayoutConstraint *sectionCellTopConstraint;
        if (index == 0) {
            self.previousElement = self.accordion;
            sectionCellTopConstraint = [NSLayoutConstraint constraintWithItem:sectionCell
                                                                    attribute:NSLayoutAttributeTop
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.previousElement
                                                                    attribute:NSLayoutAttributeTop
                                                                   multiplier:1
                                                                     constant:0];
        } else{
            sectionCellTopConstraint = [NSLayoutConstraint constraintWithItem:sectionCell
                                                                    attribute:NSLayoutAttributeTop
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.previousElement
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1
                                                                     constant:0];
        }
        
        NSLayoutConstraint *sectionCellTrailingConstraint = [NSLayoutConstraint constraintWithItem:sectionCell
                                                                                         attribute:NSLayoutAttributeTrailing
                                                                                         relatedBy:NSLayoutRelationEqual
                                                                                            toItem:self.accordion
                                                                                         attribute:NSLayoutAttributeTrailing
                                                                                        multiplier:1
                                                                                          constant:0];
        
        [sectionCell addConstraint:sectionCellWidthConstraint];
        [self.accordion addConstraint:sectionCellLeadingConstraint];
        [self.accordion addConstraint:sectionCellTopConstraint];
        [self.accordion addConstraint:sectionCellTrailingConstraint];
        
        self.previousElement = sectionCell;
    }
}

#pragma mark - Calculations
- (CGFloat)sectionHeightAtIndex:(NSInteger)index{
    CGFloat height = 0.0f;
    NSIndexPath *currentIndexPath;
    
    height = height + CGRectGetHeight([[self getViewForSectionHeaderAtIndex:index] frame]) + [self getSizeForCellSeparator];
    
    for (NSInteger rowIndex = 0; rowIndex < [self getNumberOfRowsInSection:index]; rowIndex++) {
        currentIndexPath = [NSIndexPath indexPathForRow:rowIndex inSection:index];
        
        height = height + CGRectGetHeight([[self getCellForRowAtIndexPath:currentIndexPath] frame]);
    }

    return height;
}

#pragma mark - Datasource
- (NSInteger)getNumberOfSections{
    return [self.datasource numberOfSections];
}

- (NSInteger)getNumberOfRowsInSection:(NSInteger)sectionIndex{
    return [self.datasource numberOfRowsInSection:sectionIndex];
}

- (UIView*)getCellForRowAtIndexPath:(NSIndexPath*)indexPath{
    return [self.datasource cellForRowAtIndexPath:indexPath];
}

#pragma mark - Delegate
- (UIView*)getViewForSectionHeaderAtIndex:(NSInteger)sectionIndex{
    if ([self.delegate respondsToSelector:@selector(getViewForSectionHeaderAtIndex:)]) {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.accordion.frame), 40)];
    }
    
    return [self.delegate viewForSectionHeaderAtIndex:sectionIndex];
}

- (CGFloat)getSizeForCellSeparator{
    if ([self.delegate respondsToSelector:@selector(sizeForCellSeparator)]) {
        return [self.delegate sizeForCellSeparator];
    }
    
    return 0.0f;
}

-(CGFloat)getSizeForHeaderCellSeparator{
    if ([self.delegate respondsToSelector:@selector(sizeForHeaderCellSeparator)]) {
        return [self.delegate sizeForHeaderCellSeparator];
    }
    
    return 0.0f;
}

@end
