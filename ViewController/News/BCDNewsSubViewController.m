//
//  BCDNewsSubViewController.m
//  BCDNews
//
//  Created by bigcd on 16/3/10.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "BCDNewsSubViewController.h"

@interface BCDNewsSubViewController ()

@end

@implementation BCDNewsSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    
    
    
    return cell;
}




@end
