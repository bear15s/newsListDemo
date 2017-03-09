//
//  MyNewsCellCell.m
//  newsListDemo
//
//  Created by 梁家伟 on 17/3/8.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "MyNewsCellCell.h"
#import "CZAdditions.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface MyNewsCellCell ()
@property(nonatomic,weak)UIImageView* imgView;
@property(nonatomic,weak)UILabel * titleLabel;
@property(nonatomic,weak)UILabel * timeLabel;
@property(nonatomic,weak)UILabel * siteLabel;
@end
@implementation MyNewsCellCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

-(void)setNewsObj:(MyNewsObj *)newsObj{
    
    _newsObj = newsObj;
  
    
    
    //无图片则隐藏
    if(![_newsObj.src_img isEqualToString:@""]){
        _imgView.hidden = NO;
        [_imgView sd_setImageWithURL:[NSURL URLWithString:_newsObj.src_img] placeholderImage:[UIImage imageNamed:@"c"]];
        
        [_imgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(80);
            make.width.offset(120);
        }];
        
        
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_imgView.mas_left).offset(-10);
        }];
        
    }else{
        _imgView.hidden = YES;
        
        [_imgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(80);
            make.width.offset(0);
        }];
        
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
        }];
    }
    _titleLabel.text = _newsObj.title;
    _timeLabel.text = [NSDate dateWithTimeIntervalSince1970:[_newsObj.addtime intValue]].description;
    _siteLabel.text = _newsObj.sitename;
}


-(void)setupUI{
    
    //图片
    UIImageView* imgView = [[UIImageView alloc]init];
    imgView.image = [UIImage imageNamed:@"c"];
    [self.contentView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(80);
        make.width.offset(120);
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    //标题
    UILabel* titleLabel = [UILabel cz_labelWithText:@"标题标题标题标题标题标题标题标题标题，标题标题标题标题标题标题标题标题标题，标题标题标题标题标题标题标题标题标题" fontSize:18 color:[UIColor blackColor]];
    [self.contentView addSubview:titleLabel];
    titleLabel.numberOfLines = 3;
  
     [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.contentView).offset(10);
         make.right.equalTo(imgView.mas_left).offset(-10);
         make.top.equalTo(self.contentView).offset(10);
     }];
    
    // 来源站
    UILabel* siteLabel = [UILabel cz_labelWithText:@"新浪新闻" fontSize:15 color:[UIColor grayColor]];
    [self.contentView addSubview:siteLabel];
    
    [siteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_greaterThanOrEqualTo(titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    
    //时间
    UILabel* timeLabel = [UILabel cz_labelWithText:@"5分钟前" fontSize:15 color:[UIColor blackColor]];
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_greaterThanOrEqualTo(imgView.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    
    _imgView = imgView;
    _timeLabel = timeLabel;
    _siteLabel = siteLabel;
    _titleLabel = titleLabel;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
