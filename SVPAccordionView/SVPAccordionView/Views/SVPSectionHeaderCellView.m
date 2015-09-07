//
//  SVPSectionHeaderCellView.m
//  SVPAccordionView
//
//  Created by Svetoslav Popov on 9/4/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "SVPSectionHeaderCellView.h"
@interface SVPSectionHeaderCellView()
@property (strong, nonatomic) UIView *separatorView;
@end

@implementation SVPSectionHeaderCellView

-(void)layoutSubviews{
     [self setupConstraints];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _separatorHeight = 1.0f;
        _contentView = [[UIView alloc] init];
        _separatorView = [[UIView alloc] init];
        [_separatorView setBackgroundColor:[UIColor grayColor]];
        
        UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singleFingerTap];
        
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    [self addSubview:self.contentView];
    [self addSubview:self.separatorView];
}

- (void)setupConstraints{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.separatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *headerCellHeightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:0
                                                                       multiplier:1
                                                                         constant:CGRectGetHeight(self.superview.frame)];
    
    NSLayoutConstraint *headerCellLeadingConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                         attribute:NSLayoutAttributeLeading
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.superview
                                                                         attribute:NSLayoutAttributeLeading 
                                                                        multiplier:1
                                                                          constant:0];
    
    NSLayoutConstraint *headerCellTopConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.superview
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:0];
    
    NSLayoutConstraint *headerCellTrailingConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                                    attribute:NSLayoutAttributeTrailing 
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.superview
                                                                                    attribute:NSLayoutAttributeTrailing 
                                                                                   multiplier:1
                                                                                     constant:0];
    [self addConstraint:headerCellHeightConstraint];
    [self.superview addConstraint:headerCellLeadingConstraint];
    [self.superview addConstraint:headerCellTopConstraint];
    [self.superview addConstraint:headerCellTrailingConstraint];
    
    NSLayoutConstraint *contentViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                    attribute:NSLayoutAttributeLeading 
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self
                                                                                    attribute:NSLayoutAttributeLeading
                                                                                   multiplier:1
                                                                                     constant:0];
    
    NSLayoutConstraint *contentViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                attribute:NSLayoutAttributeTop
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeTop
                                                                               multiplier:1
                                                                                 constant:0];
    
    NSLayoutConstraint *contentViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                     attribute:NSLayoutAttributeTrailing
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:self
                                                                                     attribute:NSLayoutAttributeTrailing
                                                                                    multiplier:1
                                                                                      constant:0];
    
    NSLayoutConstraint *contentViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                   attribute:NSLayoutAttributeBottom 
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.separatorView
                                                                                   attribute:NSLayoutAttributeBottom
                                                                                  multiplier:1
                                                                                    constant:0];
    
    NSLayoutConstraint *separatorViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.separatorView
                                                                                     attribute:NSLayoutAttributeHeight
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:nil
                                                                                     attribute:0
                                                                                    multiplier:1
                                                                                      constant:self.separatorHeight];
    
    NSLayoutConstraint *separatorViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.separatorView
                                                                                      attribute:NSLayoutAttributeLeading
                                                                                      relatedBy:NSLayoutRelationEqual
                                                                                         toItem:self
                                                                                      attribute:NSLayoutAttributeLeading
                                                                                     multiplier:1
                                                                                       constant:0];
    
    NSLayoutConstraint *separatorViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.separatorView
                                                                                       attribute:NSLayoutAttributeTrailing
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:self
                                                                                       attribute:NSLayoutAttributeTrailing
                                                                                      multiplier:1
                                                                                        constant:0];
    
    NSLayoutConstraint *separatorViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.separatorView
                                                                                     attribute:NSLayoutAttributeBottom
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:self
                                                                                     attribute:NSLayoutAttributeBottom
                                                                                    multiplier:1
                                                                                      constant:0];
    
    [self addConstraint:contentViewLeadingConstraint];
    [self addConstraint:contentViewTopConstraint];
    [self addConstraint:contentViewTrailingConstraint];
    [self addConstraint:contentViewBottomConstraint];
    
    [self.separatorView addConstraint:separatorViewHeightConstraint];
    [self addConstraint:separatorViewLeadingConstraint];
    [self addConstraint:separatorViewTrailingConstraint];
    [self addConstraint:separatorViewBottomConstraint];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self.delegate userDidTapOnHeader];
}


@end

