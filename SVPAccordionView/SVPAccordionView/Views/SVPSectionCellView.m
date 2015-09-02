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
@property (strong, nonatomic) UIView *separatorView;
@end

@implementation SVPSectionCellView

- (instancetype)initWithSeparatorHeight:(CGFloat)height{
    self = [super init];
    
    if (self) {
        [self addSubviewsWithSeparatorHeight:height];
    }
    
    return self;
}

-(void)addSubviewsWithSeparatorHeight:(CGFloat)height{
    self.contentView = [[UIView alloc] init];
    self.separatorView = [[UIView alloc] init];
    [self.separatorView setBackgroundColor:[UIColor grayColor]];
    
    [self addSubview:self.contentView];
    [self addSubview:self.separatorView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_contentView, _separatorView);
    
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView][separatorView]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views];
    
    NSArray *horizontalConstraintForContentView = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|"
                                                                                          options:0
                                                                                          metrics:nil
                                                                                            views:views];
    
    NSArray *horizontalConstraintForSeparatorView = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[separatorView]|"
                                                                                          options:0
                                                                                          metrics:nil
                                                                                            views:views];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.separatorView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:1
                                                                         constant:1];
    
    
    [self addConstraints:verticalConstraints];
    [self addConstraints:horizontalConstraintForContentView];
    [self addConstraints:horizontalConstraintForSeparatorView];
    [self addConstraint:heightConstraint];
}

@end
