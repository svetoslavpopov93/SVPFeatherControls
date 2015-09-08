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
@property (strong, nonatomic) SVPAccordion *accordion;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.accordion = [[SVPAccordion alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
    self.accordion.datasource = self;
    self.accordion.delegate = self;
    
    [self.view addSubview:self.accordion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.accordion reloadAccordion];
}

#pragma mark - SVPAccordionDatasource

- (NSInteger)numberOfSections{
    return 3;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)sectionIndex{
    if (sectionIndex == 0) {
        return 5;
    } else if(sectionIndex == 1){
        return 2;
    } else{
        return 3;
    }
}

- (UIView *)cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
#warning TODO: FIX cellForRowAtIndexPath
    UIView *rowCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.accordion.frame.size.width, 30)];
    
    return rowCell;
}

#pragma mark - SVPAccordionDelegate
- (UIView *)viewForSectionHeaderAtIndex:(NSInteger)sectionIndex{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.accordion.frame), 30.0f)];
    
    return headerView;
}

- (CGFloat)sizeForCellSeparator{
    return 1.0;
}

-(CGFloat)sizeForHeaderCellSeparator{
    return 1.0;
}

@end
