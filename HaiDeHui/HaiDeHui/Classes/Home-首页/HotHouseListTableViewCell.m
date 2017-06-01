//
//  HotHouseListTableViewCell.m
//  HaiDeHui
//
//  Created by junde on 2017/6/1.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "HotHouseListTableViewCell.h"

@interface HotHouseListTableViewCell ()

/** 图片 */
@property (nonatomic, weak) UIImageView *picImageView;
/** 公寓小区名 */
@property (nonatomic, weak) UILabel *apartmentNameLabel;
/** 户型 + 面积 */
@property (nonatomic, weak) UILabel *houseTypeLabel;
/** 售价范围 */
@property (nonatomic, weak) UILabel *priceRangeLabel;

@end

@implementation HotHouseListTableViewCell

#pragma mark - 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}






#pragma mark - 设置界面元素
/** 由于外界返回的固定行高,这里直接计算也可以,不需要使用自动布局 */
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    // 图片
    UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    picImageView.contentMode = UIViewContentModeScaleAspectFill;
    picImageView.clipsToBounds = YES;
    [self.contentView addSubview:picImageView];
    
    // 小区名称
    UILabel *apartmentNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(picImageView.right + 10, 15, Width_Screen - (picImageView.right + 20), 20)];
    apartmentNameLabel.font = [UIFont systemFontOfSize:17];
    apartmentNameLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:apartmentNameLabel];
    
    // 户型+面积
    UILabel *houseTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(picImageView.right + 10, apartmentNameLabel.bottom + 15, Width_Screen - (picImageView.right + 20), 20)];
    houseTypeLabel.font = [UIFont systemFontOfSize:17];
    houseTypeLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:houseTypeLabel];
    
    // 售价范围
    UILabel *priceRangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(picImageView.right + 10, houseTypeLabel.bottom + 15, Width_Screen - (picImageView.right + 20), 20)];
    priceRangeLabel.font = [UIFont systemFontOfSize:17];
    priceRangeLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:priceRangeLabel];
    
    
    // 属性记录
    _picImageView = picImageView;
    _apartmentNameLabel = apartmentNameLabel;
    _houseTypeLabel = houseTypeLabel;
    _priceRangeLabel = priceRangeLabel;
}

@end
