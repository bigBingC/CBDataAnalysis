//
//  SecondViewConmtroller.m
//  DKDataTrackKitDemo
//
//  Created by 崔冰smile on 2019/5/6.
//  Copyright © 2019 Ziwutong. All rights reserved.
//

#import "SecondViewConmtroller.h"
#import "ThirdViewController.h"
#import "TableViewCell.h"

@interface SecondViewConmtroller () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *text;
@end

@implementation SecondViewConmtroller

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.text = @"tableview";

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:TableViewCellID bundle:nil] forCellReuseIdentifier:TableViewCellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellID];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[ThirdViewController new] animated:YES];
}

@end
