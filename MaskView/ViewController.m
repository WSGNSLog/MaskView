//
//  ViewController.m
//  MaskView
//
//  Created by shiguang on 2017/10/25.
//  Copyright © 2017年 shiguang. All rights reserved.
//

#import "ViewController.h"
#import "Utils_DeviceInfo.h"
#import "Masonry.h"

#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,weak) UIView *coverView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpCoverView];
}

- (void)setUpCoverView{
    
    float y = 0;
    float sureBtn_y = 0;
    float guideImgV_x = 0;
    float guideImgV_y = 0;
    float guideImgV_w = 0;
    float guideImgV_h = 0;
    if ([Utils_DeviceInfo deviceSize] < iPhone47inch) {
        y = 300;
        sureBtn_y = 420;
        guideImgV_w = 180;
        guideImgV_x = (ScreenW - guideImgV_w)/2 + 10;
        guideImgV_h = 80;
        guideImgV_y = y - guideImgV_h - 2.5;
        
    }else if ([Utils_DeviceInfo deviceSize] == iPhone47inch){
        y = 300;
        sureBtn_y = 440;
        guideImgV_w = 190;
        guideImgV_x = (ScreenW - guideImgV_w)/2 + 5;
        guideImgV_h = 85;
        guideImgV_y = y - guideImgV_h - 2.5;
    }else if ([Utils_DeviceInfo deviceSize] <= iPhone55inch){
        y = 300;
        sureBtn_y = 445;
        guideImgV_w = 195;
        guideImgV_x = (ScreenW - guideImgV_w)/2;
        guideImgV_h = 87.5;
        guideImgV_y = y - guideImgV_h - 2.5;
    }
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.4;
    [window addSubview:maskView];
    
    //画一个矩形
    UIBezierPath *bpath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) cornerRadius:0];
    //画一个圆角矩形
    [bpath appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, y, 150, 48) cornerRadius:20] bezierPathByReversingPath]];
    //创建一个CAShapeLayer 图层
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bpath.CGPath;
    
    //添加图层蒙板
    maskView.layer.mask = shapeLayer;
    
    UIImageView *guideImgV = [[UIImageView alloc]initWithFrame:CGRectMake(guideImgV_x, guideImgV_y, guideImgV_w, guideImgV_h)];
    guideImgV.image = [UIImage imageNamed:@"hotLiveGuideImg"];
    [maskView addSubview:guideImgV];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"guidePageSureBtnImg"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [maskView addSubview:sureBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@120);
        make.height.equalTo(@50);
        make.centerX.equalTo(maskView);
        make.top.equalTo(@(sureBtn_y));
        
    }];
    
    self.coverView = maskView;
    

}
- (void)sureBtnClick{
    
    [self.coverView removeFromSuperview];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    else{
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UIImageView* imageView = [cell.contentView viewWithTag:1110];
    if (imageView != nil) {
        [imageView removeFromSuperview];
    }
    
    if (indexPath.section==0){
        if (indexPath.row==0) {
            cell.imageView.image = [UIImage imageNamed:@"FindHotLiveIcon"];
            cell.textLabel.text = @"搜索";
        }
        else if (indexPath.row==1){
            cell.imageView.image = [UIImage imageNamed:@"FindHotLiveIcon"];
            cell.textLabel.text = @"视精彩";
        }
        else if (indexPath.row==2){
            cell.imageView.image = [UIImage imageNamed:@"FindHotLiveIcon"];
            cell.textLabel.text = @"图精彩";
        }
        else if(indexPath.row==3){
            cell.imageView.image = [UIImage imageNamed:@"FindHotLiveIcon"];
            cell.textLabel.text = @"文推荐";
        }else{
            cell.imageView.image = [UIImage imageNamed:@"FindHotLiveIcon"];
            cell.textLabel.text = @"精彩直播";
            
        }
    }
    else{
        if (indexPath.row==0) {
            cell.imageView.image = [UIImage imageNamed:@"FindHotLiveIcon"];
            cell.textLabel.text = @"最热活动";
        }
        else{
            cell.imageView.image = [UIImage imageNamed:@"FindHotLiveIcon"];
            cell.textLabel.text = @"热门商品";
        }
    }
    return cell;
}

@end
