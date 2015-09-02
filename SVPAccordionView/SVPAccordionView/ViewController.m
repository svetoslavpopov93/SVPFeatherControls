//
//  ViewController.m
//  SVPAccordionView
//
//  Created by Svetoslav Popov on 9/2/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "ViewController.h"
#import "SVPAccordion.h"

@interface ViewController ()<SVPAccordionDataSource, SVPAccordionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SVPAccordion *accordion = [[SVPAccordion alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    accordion.datasource = self;
    accordion.delegate = self;
    [accordion reloadAccordion];
    
    [self.view addSubview:accordion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SVPAccordionDatasource

- (NSInteger)numberOfSections{
    return 3;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)sectionIndex{
    return 2;
}

- (UIView *)cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - SVPAccordionDelegate
- (UIView *)viewForSectionHeaderAtIndex:(NSInteger)sectionIndex{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 30.0f)];
    
    return headerView;
}

- (CGFloat)sizeForCellSeparator{
    return 1.0;
}

-(CGFloat)sizeForHeaderCellSeparator{
    return 1.0;
}

@end
