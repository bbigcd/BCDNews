//
//  BCDLeftTagViewController.m
//  BCDNews
//
//  Created by bigcd on 16/3/12.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "BCDLeftTagViewController.h"

@interface BCDLeftTagViewController ()

@end

@implementation BCDLeftTagViewController

static NSString * const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd", self.title, indexPath.row+1] ;
    
    return cell;
}

@end
