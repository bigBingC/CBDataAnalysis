//
//  TableViewCell.m
//  DKDataTrackKitDemo
//
//  Created by 崔冰smile on 2019/5/7.
//  Copyright © 2019 Ziwutong. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()
@property (nonatomic, copy) NSString *tips;

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tips = @"cell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
