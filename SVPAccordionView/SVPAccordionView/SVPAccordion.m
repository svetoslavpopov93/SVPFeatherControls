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
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    _accordion = [[UIScrollView alloc] init];
    [_accordion setBackgroundColor:[UIColor yellowColor]];
    
    [self addSubview:_accordion];
    [self setAccordionConstraints];
}

- (void)setAccordionConstraints{
    [_accordion setTranslatesAutoresizingMaskIntoConstraints:NO];// Set accordion constraints
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_accordion);
    
    NSArray *accordionHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_accordion]|"
                                                                                      options:0
                                                                                      metrics:nil
                                                                                        views:views];
    
    NSArray *accordionVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_accordion]|"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                      views:views];
    [self addConstraints:accordionHorizontalConstraints];
    [self addConstraints:accordionVerticalConstraints];
}

- (void) reloadAccordion{
    for (NSInteger index = 0; index < [self getNumberOfSections]; index++) {
        UIView *delegatedView = [self getViewForSectionHeaderAtIndex:index];
        [delegatedView setBackgroundColor:[UIColor blueColor]];

        
        
//        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(delegatedView.frame) * index, CGRectGetWidth(delegatedView.frame), CGRectGetHeight(delegatedView.frame))];
//        [headerView setBackgroundColor:[UIColor greenColor]];
//        
//        
//        [self.accordion addSubview:headerView];
    }
}

#pragma mark - Calculations
- (CGFloat)sectionHeightAtIndex:(NSInteger)index{
    CGFloat height = 0.0f;
    NSIndexPath *currentIndexPath;
    
    for (NSInteger sectionIndex = 0; sectionIndex < [self getNumberOfSections]; sectionIndex++) {
        height = height + CGRectGetHeight([[self getViewForSectionHeaderAtIndex:sectionIndex] frame]) + [self getSizeForCellSeparator];
        
        for (NSInteger rowIndex = 0; rowIndex < [self getNumberOfRowsInSection:sectionIndex]; rowIndex++) {
            currentIndexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
            
            height = height + CGRectGetHeight([[self getCellForRowAtIndexPath:currentIndexPath] frame]);
        }
    }
    
#warning // TODO: CONTINUE IMPLEMENTING

    return 1;
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
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 40)];
    }
    
    return [self.delegate viewForSectionHeaderAtIndex:sectionIndex];
}

- (CGFloat)getSizeForCellSeparator{
    if ([self.delegate respondsToSelector:@selector(sizeForCellSeparator)]) {
        return [self.delegate sizeForCellSeparator];
    }
    
    return 0.0f;
}

-(CGFloat)sizeForHeaderCellSeparator{
    if ([self.delegate respondsToSelector:@selector(sizeForHeaderCellSeparator)]) {
        return [self.delegate sizeForHeaderCellSeparator];
    }
    
    return 0.0f;
}

@end
