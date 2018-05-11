//
//  ShenJRD_VC.m
//  Reha Mstim
//
//  Created by yuepr on 2016/10/26.
//  Copyright © 2016年 yuepr.Guangz. All rights reserved.

//

#import "ShenJRd_VC.h"
#import "RectItem.h"
#import "UIImage+ColorAtPoint.h"
#import "YTKKeyValueStore.h"
#import "NaocuzhongPrescripTion_VC.h"


#define LocationW (0.5*(SCREEN_WIDTH )/209)
#define LocationH (0.5*(SCREEN_HEIGHT - 94)/405)


#define kAlphaVisibleThreshold (0.1f)

@interface ShenJRD_VC ()
//@property(nonatomic,strong)UIView *                         contentWinView;
@property(nonatomic,assign)BOOL front;
@property(nonatomic,strong)NSArray <RectItem *>*            backRectItemArray;
@property(nonatomic,strong)NSArray <RectItem *>*            frontRectItemArray;
@property(nonatomic,assign)NSInteger                        selectModelCount;
@property(nonatomic,assign)NSInteger                        previousSelectCount;
@property(nonatomic,assign)NSInteger                        previousPtIndex;
@property(nonatomic,strong)UIImageView *                    contentBackImgV;
@property(nonatomic,strong)UIView *                         contentFontWinView;
@property(nonatomic,strong)UIView *                         contentBackWinView;



@property(nonatomic,strong)UIImageView *                    firstSelectImgV;
@property(nonatomic,strong)UIImageView *                    secendSelectImgV;
@property(nonatomic,strong)RectItem *                       rects;

@property(nonatomic,assign)BOOL                             isNolowerBady;
@property(nonatomic,assign)BOOL                             isFront;
@property(nonatomic,assign)NSInteger                        firstSelectIndex;
@property(nonatomic,assign)NSInteger                        scendSelectIndex;
@property(nonatomic,strong)NSArray *                        imgArr;
@property(nonatomic,strong)NSArray *                        locationBodyArr;
@property(nonatomic,strong)NSArray *                        alphaImgArr;
@property(nonatomic,assign)UInt32                           selectBits;



@property(nonatomic,assign)NSInteger                       frontSelectFirstIndex;
@property(nonatomic,assign)NSInteger                       frontSelectScendIndex;
@property(nonatomic,assign)NSInteger                       frontTatleCount;
@property(nonatomic,strong)NSArray<NSString *> *           bodyTitleArr;
@property(nonatomic,strong)NSArray<NSString *> *           bodyTitleArr2;
@property(nonatomic,copy)NSString *                        rightConfirmBarTitle;
@property(nonatomic,assign)NSInteger                       displaySelecCount;
@property(nonatomic,strong)UILabel *                       exchangeBtnTitleLabel;


@end

@implementation ShenJRD_VC


//static UInt32  selectBits = 0;

- (NSArray *)alphaImgArr{
    if (!_alphaImgArr) {
        _alphaImgArr = @[@"ic_prescription_disable00",@"ic_prescription_disable01",@"ic_prescription_disable02",@"ic_prescription_disable03",@"ic_prescription_disable04",@"ic_prescription_disable05",@"ic_prescription_disable06",@"ic_prescription_disable07",@"ic_prescription_disable08",@"ic_prescription_disable09",@"ic_prescription_disable10",@"ic_prescription_disable11",@"ic_prescription_disable12",@"ic_prescription_disable13",@"ic_prescription_disable14",@"ic_prescription_disable15",@"ic_prescription_disable16",@"ic_prescription_disable17",@"ic_prescription_disable18",@"ic_prescription_disable19",@"ic_prescription_disable20",@"ic_prescription_disable21"];
    }
    return _alphaImgArr;

}
-(NSArray *)imgArr{
    if (!_imgArr) {
        _imgArr = @[@"ic_prescription_enable00",@"ic_prescription_enable01",@"ic_prescription_enable02",@"ic_prescription_enable03",@"ic_prescription_enable04",@"ic_prescription_enable05",@"ic_prescription_enable06",@"ic_prescription_enable07",@"ic_prescription_enable08",@"ic_prescription_enable09",@"ic_prescription_enable10",@"ic_prescription_enable11",@"ic_prescription_enable12",@"ic_prescription_enable13",@"ic_prescription_enable14",@"ic_prescription_enable15",@"ic_prescription_enable16",@"ic_prescription_enable17",@"ic_prescription_enable18",@"ic_prescription_enable19",@"ic_prescription_enable20",@"ic_prescription_enable21"];
    }
    return _imgArr;
}
-(NSArray *)locationBodyArr{
    if (!_locationBodyArr) {
        NSArray * locationArr = [NSArray array];
        locationArr = @[@"1",@"1",@"0",@"0",@"0",@"0",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"0",@"0",@"0",@"0"];
        
        _locationBodyArr = locationArr;
    }
    return _locationBodyArr;
}


-(NSArray *)bodyTitleArr{
    if (!_bodyTitleArr) {
        _bodyTitleArr = @[NSLocalizedString(@"deltoid", nil),NSLocalizedString(@"deltoid", nil),NSLocalizedString(@"quadriceps_femoris", nil),NSLocalizedString(@"quadriceps_femoris", nil),NSLocalizedString(@"tibialis_anterior", nil),NSLocalizedString(@"tibialis_anterior", nil),NSLocalizedString(@"upper_trapezius", nil),NSLocalizedString(@"upper_trapezius", nil),NSLocalizedString(@"trapezius", nil),NSLocalizedString(@"trapezius", nil),NSLocalizedString(@"infraspinatus", nil),NSLocalizedString(@"infraspinatus", nil),NSLocalizedString(@"triceps_brachii", nil),NSLocalizedString(@"triceps_brachii", nil),NSLocalizedString(@"latissimus_dorsi", nil),NSLocalizedString(@"latissimus_dorsi", nil),NSLocalizedString(@"extensor_carpi", nil),NSLocalizedString(@"extensor_carpi", nil),NSLocalizedString(@"biceps_femoris", nil),NSLocalizedString(@"biceps_femoris", nil),NSLocalizedString(@"gastrocnemius", nil),NSLocalizedString(@"gastrocnemius", nil)];
    }
    return _bodyTitleArr;

}
//
//"upper_trapezius"= "斜方肌上部";
//"trapezius" = "斜方肌";
//"latissimus_dorsi" = "背阔肌";
//"deltoid" = "三角肌";
//"infraspinatus" = "冈下肌";
//"triceps_brachii" = "肱三头肌";
//"extensor_carpi" = "伸腕肌";
//"quadriceps_femoris" = "股四头肌";
//"biceps_femoris" = "股二头肌";
//"tibialis_anterior" = "胫骨前肌";
//"gastrocnemius" = "腓肠肌";
//"biceps_brachii" = "肱二头肌";
//"flexor_carpi" = "屈腕肌";
//"gluteus_maximus" = "臀大肌";
-(NSArray *)bodyTitleArr2{
    if (!_bodyTitleArr2) {
        _bodyTitleArr2 = @[@"三角肌",@"三角肌",@"股四头肌",@"股四头肌",@"胫骨前肌",@"胫骨前肌",@"斜方肌上部",@"斜方肌上部",@"斜方肌",@"斜方肌",@"冈下肌",@"冈下肌",@"肱三头肌",@"肱三头肌",@"背阔肌",@"背阔肌",@"伸腕肌",@"伸腕肌",@"股二头肌",@"股二头肌",@"腓肠肌",@"腓肠肌"];
    }
    return _bodyTitleArr2;
    
}
-(RectItem *)rects{
    if (_rects) {
        _rects = [[RectItem alloc]init];
    }
    return _rects;

}
-(NSArray<RectItem *> *)frontRectItemArray{
    NSMutableArray *buffeFrontArr = [NSMutableArray array];
    if (!self.rects) {
        self.rects = [[RectItem alloc]init];
    }
    for (unsigned int i = 0; i<22; i++) {
        
//        rects.selected = NO;
        switch (i) {
            case 0:
                self.rects.itemRect = CGRectMake(121*LocationW , 148*LocationH +84, 45*LocationW,58*LocationH );
                break;
            case 1:
                self.rects.itemRect = CGRectMake(249*LocationW , 148*LocationH +84, 46*LocationW,59*LocationH);
                break;
            case 2:
                self.rects.itemRect = CGRectMake(162*LocationW , 394*LocationH +84, 43*LocationW, 163 *LocationH);
                break;
            case 3:
                self.rects.itemRect = CGRectMake(215*LocationW , 395*LocationH +84, 43*LocationW, 160*LocationH);
                break;
            case 4:
                self.rects.itemRect = CGRectMake(168*LocationW , 590*LocationH +84, 40*LocationW, 162*LocationH);
                break;
            case 5:
                self.rects.itemRect = CGRectMake(218*LocationW , 590*LocationH +84, 40*LocationW, 162*LocationH);
                break;
                
                /*---------------------------------------------------------*/
            case 6:
                self.rects.itemRect = CGRectMake(168*LocationW , 78*LocationH +84, 38*LocationW,67*LocationH);
                break;
            case 7:
                self.rects.itemRect = CGRectMake(208*LocationW , 78*LocationH +84, 38*LocationW,67*LocationH);
                break;
            case 8:
                self.rects.itemRect = CGRectMake(150*LocationW , 148*LocationH +84, 58*LocationW, 75*LocationH);

                break;
            case 9:
                self.rects.itemRect = CGRectMake(210*LocationW , 148*LocationH +84, 58*LocationW, 75*LocationH);
                break;
                
                
                
            case 10:
                self.rects.itemRect = CGRectMake(145*LocationW , 160*LocationH +84, 40*LocationW, 60*LocationH);
                break;
            case 11:
                self.rects.itemRect = CGRectMake(240*LocationW , 160*LocationH +84, 40*LocationW, 60*LocationH);
                break;
            case 12:
                self.rects.itemRect = CGRectMake(120*LocationW , 190*LocationH +84, 40*LocationW, 80*LocationH);
                break;
            case 13:
                self.rects.itemRect = CGRectMake(270*LocationW , 190*LocationH +84, 40*LocationW, 80*LocationH);
                break;
                
            case 14:
                self.rects.itemRect = CGRectMake(145*LocationW , 200*LocationH +84, 70*LocationW, 115*LocationH);

                break;
            case 15:
                self.rects.itemRect = CGRectMake(210*LocationW , 200*LocationH +84, 70*LocationW, 115*LocationH);
                break;
        
            case 16:
                self.rects.itemRect = CGRectMake(80*LocationW , 280*LocationH +84, 55*LocationW, 100*LocationH);
                
                break;
            case 17:
                 self.rects.itemRect = CGRectMake(280*LocationW , 280*LocationH +84, 55*LocationW, 100*LocationH);
                break;

            case 18:
                self.rects.itemRect = CGRectMake(145*LocationW , 425*LocationH +84, 50*LocationW, 140*LocationH);
                
                break;
            case 19:
                self.rects.itemRect = CGRectMake(215*LocationW , 425*LocationH +84, 50*LocationW, 140*LocationH);
                break;

            case 20:
                self.rects.itemRect = CGRectMake(145*LocationW , 550*LocationH +84, 50*LocationW, 140*LocationH);
                
                break;
            case 21:
                self.rects.itemRect = CGRectMake(215*LocationW , 550*LocationH +84, 50*LocationW, 140*LocationH);
                break;

            default:
                break;
        }
        [buffeFrontArr addObject:_rects];
    }
    _frontRectItemArray = buffeFrontArr;
    return _frontRectItemArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectModelCount = 0;
    _selectBits &= 0;
    self.isFront = YES;
    [self setDefautData];
    [self exchangeBtnDefaultStyle];
    self.rightConfirmBarTitle = [NSString stringWithFormat:@"%@ (%d/2)",NSLocalizedString(@"ok", nil),0];
    [self setUpNavStyle];
    
}
-(void)setUpNavStyle{
    
//    self.rightConfirmBarTitle = [NSString stringWithFormat:@"确定 (%zd/2)",_selectModelCount];
    
    
    
    
    
    UIView *navRightItemView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 0, SCREEN_WIDTH - 100, 44)];
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, navRightItemView.width, 25)];
    [navRightItemView addSubview:titleL];
    UILabel *detailTitleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, navRightItemView.width, 14)];
    [navRightItemView addSubview:detailTitleL];
    
    
    
    titleL.text = @"NMES";
    detailTitleL.text = NSLocalizedString(@"desc_nmes", nil);
    titleL.textColor = RGB(63, 104, 144);
    detailTitleL.textColor  = RGB(63, 104, 144);
    titleL.textAlignment = NSTextAlignmentCenter;
    detailTitleL.textAlignment = NSTextAlignmentCenter;
    detailTitleL.font = [UIFont systemFontOfSize:13];
    
    self.navigationItem.rightBarButtonItem.customView = navRightItemView;
    
    UIBarButtonItem *releaseButon = [[UIBarButtonItem alloc] initWithTitle:self.rightConfirmBarTitle style:UIBarButtonItemStylePlain target:self action:@selector(navBarightreleaseInfo)];
    
    UIBarButtonItem *navBarLeftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navBarLeftItem"] style:UIBarButtonItemStylePlain target:self action:@selector(navaBarLeftItemAction)];
    self.navigationItem.leftBarButtonItem = navBarLeftItem;
    
    releaseButon.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = releaseButon;
    self.navigationItem.title = NSLocalizedString(@"select_treatment_part", nil);
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(63, 104, 144)}];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(63, 104, 144),NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    
}
-(void)navaBarLeftItemAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)navBarightreleaseInfo{
    if (self.displaySelecCount == 0) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setBackgroundColor:RGBA(1, 1, 1, 0.9)];//设置HUD的背景颜色
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"tip_select_empty", nil)];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]]; //字体颜色
        [self performSelector:@selector(svpDissmiss) withObject:nil afterDelay:1];
        return;
    }

    
    [self.navigationController pushViewController: [self createJingGQJRViewController] animated:YES];

    
}



-(NaocuzhongPrescripTion_VC *)createJingGQJRViewController{
    
    NaocuzhongPrescripTion_VC *vc = [[NaocuzhongPrescripTion_VC alloc]init];
    
    unsigned int selectCountNaoc = 0;
    unsigned int selectFirstC  = 0,selectScendC = 0;
    
    for (unsigned int i = 0; i < 22; i++) {
        if ((((_selectBits & (0x1<<i))) == (0x1<<i))) {
            selectCountNaoc++;
            if(selectCountNaoc==1){
                selectFirstC = i;
                
            }else if (selectCountNaoc==2){
                
                    selectScendC = i;
                
                
            }

        }
    }
    
    
     if (self.displaySelecCount==1) {
        vc.mainTitle = self.bodyTitleArr[self.firstSelectIndex];
        vc.mainImageName =  [NSString stringWithFormat:@"%@.jpg",self.bodyTitleArr2[selectFirstC]];
        vc.leftTitle = @"";
        vc.leftImageName = @"";
        vc.ritghtTitle = @"";
        vc.rightImageName = @"";
        
        vc.nemsItem.outputFrequency = [self.locationBodyArr[selectFirstC] integerValue]==1? 40:50;
         vc.nemsItem.puseWidth = [self.locationBodyArr[selectFirstC] integerValue]==1 ?200:300;
    }
    if (self.displaySelecCount==2) {
       
        if (![self.bodyTitleArr[selectFirstC] isEqualToString:self.bodyTitleArr[selectScendC]]) {
            vc.leftTitle = self.bodyTitleArr[selectFirstC];
            vc.leftImageName = [NSString stringWithFormat:@"%@.jpg",self.bodyTitleArr2[selectFirstC] ];
            vc.ritghtTitle = self.bodyTitleArr[selectScendC];
            vc.rightImageName = [NSString stringWithFormat:@"%@.jpg",self.bodyTitleArr2[selectScendC] ];
        }
        if ([self.bodyTitleArr[selectFirstC] isEqualToString:self.bodyTitleArr[selectScendC]]){
            vc.mainTitle = self.bodyTitleArr[selectScendC];
            vc.mainImageName =  [NSString stringWithFormat:@"%@.jpg",self.bodyTitleArr2[selectFirstC]];
            vc.leftTitle = @"";
            vc.leftImageName = @"";
            vc.ritghtTitle = @"";
            vc.rightImageName = @"";
            
        }
        
        vc.nemsItem.outputFrequency = [self.locationBodyArr[selectFirstC] integerValue]==1? 40:50;
        vc.nemsItem.puseWidth = [self.locationBodyArr[selectFirstC] integerValue]==1 ?200:300;
    }else if (self.displaySelecCount == 0){
        
    }

    
//    "cerebral_stroke" = "脑卒中";
//    "special_nmes" = "神经肌肉电刺激";
    vc.navItemTitle = NSLocalizedString(@"special_nmes", nil);
    vc.navMainItemTitle = NSLocalizedString(@"cerebral_stroke", nil);
    vc.nemsItem.status_CHA = YES;
    vc.nemsItem.status_CHB = (self.displaySelecCount==2)?YES:NO;
    vc.nemsItem.outputModel = self.displaySelecCount==2?NSLocalizedString(@"nmes_output_model_same", nil):@"--";
    
    
    vc.nemsItem.durationTime = 20;
    
    vc.lplineChartItem.upTime = 5.f;
    vc.lplineChartItem.houldTime = 5.0;
    vc.lplineChartItem.downTime = 5.0;
    vc.lplineChartItem.restTime = 20.0;
    
    return vc;
    
}
-(void)exchangeBtnDefaultStyle{
    UIButton  *exchangeBtn2 = [[UIButton alloc]init];
    [self.view addSubview:exchangeBtn2];
    [exchangeBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-30);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-65);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@40);
    }];
    
    [exchangeBtn2 setImage:[UIImage imageNamed:@"btn_prescription_turn_over"] forState:UIControlStateNormal];
//    exchangeBtn2.backgroundColor = [UIColor redColor];
//    [exchangeBtn2 setTitle:@"更换" forState:UIControlStateNormal];
    [exchangeBtn2 addTarget:self action:@selector(exchangeBtnActions) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *btnTitleLabel = [[UILabel alloc]init];
    btnTitleLabel.text = NSLocalizedString(@"label_front", nil);
    btnTitleLabel.textColor = [UIColor orangeColor];
    
    [self.view addSubview:btnTitleLabel];
    btnTitleLabel.textAlignment = NSTextAlignmentCenter;
    [btnTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-40 );
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@50);
    }];
    
    self.exchangeBtnTitleLabel = btnTitleLabel;
    
}
-(void)exchangeBtnActions{
    DLog(@".....")
    
    self.isFront  = !self.isFront;
    self.exchangeBtnTitleLabel.text = self.isFront?NSLocalizedString(@"label_front", nil):NSLocalizedString(@"label_back", nil);
        if (self.firstSelectImgV) {
            [self.firstSelectImgV removeFromSuperview];
            self.firstSelectImgV = nil;
        }
        if (self.secendSelectImgV) {
            [self.secendSelectImgV removeFromSuperview];
            self.secendSelectImgV = nil;
        }
    [self setDefautData];
    [self setBackDefaultData];
}
-(void)setDefautData{
    _frontTatleCount = 0;
    if(!self.isFront)   return;
    
    if (self.contentBackImgV) {
//        [self.contentBackImgV removeFromSuperview];
        self.contentBackImgV  = nil;
    }
    if (self.contentFontWinView) {
        for (UIView *view in _contentFontWinView.subviews) {
            [view removeFromSuperview];
        }
//        [self.contentBackWinView removeFromSuperview];
//        self.contentBackWinView = nil;
    }
    if (!self.contentFontWinView) {
        UIView *FontWinView = [[UIView alloc]init];
        [self.view addSubview:FontWinView];
        [FontWinView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.and.bottom.equalTo(self.view).with.offset(0);
            
        }];
        self.contentFontWinView = FontWinView;
    }
    
    if (!self.contentBackImgV) {
        UIImageView *contentBackImagV = [[UIImageView alloc]init];
        contentBackImagV.userInteractionEnabled = YES;
        [self.contentFontWinView addSubview:contentBackImagV];
        
        [contentBackImagV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).with.offset(40);
            make.right.equalTo(self.view.mas_right).with.offset(-40);
            make.top.equalTo(self.view.mas_top).with.offset(94);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
        }];
        
        contentBackImagV.image = [UIImage imageNamed:@"frontAll"];
        self.contentBackImgV = contentBackImagV;

    }
    
    for (unsigned int i = 0; i<6 ; ++i) {
        UIView *vie0 = [[UIView alloc]init];
        vie0.tag = i;
        
        [vie0 viewWithTag:i].frame = self.frontRectItemArray[i].itemRect;
        vie0.backgroundColor = RGBA(205, 205, 205, 0);
        
        vie0.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuViewClick:)];
        [tap setNumberOfTapsRequired:1];
        [tap setNumberOfTouchesRequired:1];
        [vie0 addGestureRecognizer:tap];
        [self.contentFontWinView addSubview:[vie0 viewWithTag:i]];
        
        if ((((_selectBits & (0x1<<i)))==(0x1<<i))) {
            self.frontTatleCount ++;
            if( self.firstSelectImgV){
                [self.firstSelectImgV removeFromSuperview];
                
                self.firstSelectImgV = nil;
            }
            if (_frontTatleCount == 1) {
                self.frontSelectFirstIndex = i;
                self.previousPtIndex = i;
                
                if (!self.firstSelectImgV) {
                    _firstSelectImgV = [[UIImageView alloc]init];
                    [self.view addSubview:_firstSelectImgV];
                    [_firstSelectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.view.mas_left).with.offset(40);
                        make.right.equalTo(self.view.mas_right).with.offset(-40);
                        make.top.equalTo(self.view.mas_top).with.offset(94);
                        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
                    }];
                }
                self.firstSelectImgV.image = [UIImage imageNamed:self.imgArr[_frontSelectFirstIndex]];
                if (self.secendSelectImgV) {
                    
                    [self.secendSelectImgV removeFromSuperview];
                    self.secendSelectImgV = nil;
                }
                
                //  selectBits &= 1<<i;
                
            }else if (_frontTatleCount == 2){
                self.frontSelectScendIndex = i;
                self.firstSelectImgV = nil;
                self.secendSelectImgV = nil;
                //  selectBits &= ((1<<(_firstSelectIndex))+(1<<_scendSelectIndex));
                if (!self.secendSelectImgV) {
                    _secendSelectImgV = [[UIImageView alloc]init];
                    [self.view addSubview:_secendSelectImgV];
                    [_secendSelectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.view.mas_left).with.offset(40);
                        make.right.equalTo(self.view.mas_right).with.offset(-40);
                        make.top.equalTo(self.view.mas_top).with.offset(94);
                        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
                    }];
                }
                
                if (!self.firstSelectImgV) {
                    _firstSelectImgV = [[UIImageView alloc]init];
                    [self.view addSubview:_firstSelectImgV];
                    [_firstSelectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.view.mas_left).with.offset(40);
                        make.right.equalTo(self.view.mas_right).with.offset(-40);
                        make.top.equalTo(self.view.mas_top).with.offset(94);
                        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
                    }];
                }
                self.secendSelectImgV.image = [UIImage imageNamed:self.imgArr[_frontSelectScendIndex]];
                self.firstSelectImgV.image = [UIImage imageNamed:self.imgArr[_frontSelectFirstIndex]];
                
                
            }
            
        }

    }
}
-(void)setBackDefaultData{
    
    _selectModelCount = 0;
    if(self.isFront)   return;
    if (self.contentBackImgV) {
        self.contentBackImgV  = nil;
    }
    
    if (self.contentFontWinView) {
        for (UIView *view in self.contentFontWinView.subviews) {
            [view removeFromSuperview];
        }
//        [self.contentFontWinView removeFromSuperview];
//        self.contentFontWinView = nil;
    }
    
    if (!self.contentFontWinView) {
        UIView * BackWinView = [[UIView alloc]init];
        
        [self.view addSubview:BackWinView];
        [BackWinView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.and.bottom.equalTo(self.view).with.offset(0);
        }];
        self.contentFontWinView = BackWinView;
    }
    
    if (!self.contentBackImgV) {
        UIImageView *contentBackImagV = [[UIImageView alloc]init];
        [self.contentFontWinView addSubview:contentBackImagV];
        contentBackImagV.userInteractionEnabled = YES;
//        self.contentBackWinView.userInteractionEnabled = YES;
        
        [contentBackImagV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).with.offset(40);
            make.right.equalTo(self.view.mas_right).with.offset(-40);
            make.top.equalTo(self.view.mas_top).with.offset(94);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
        }];
        contentBackImagV.image = [UIImage imageNamed:@"backAll"];
        self.contentBackImgV = contentBackImagV;
    }
    for (unsigned int i = 6; i<self.frontRectItemArray.count; ++i) {
        UIView *vie0 = [[UIView alloc]init];
        vie0.tag = i;
        [vie0 viewWithTag:i].frame = self.frontRectItemArray[i].itemRect;
        vie0.backgroundColor = RGBA(205, 205, 205, 0);
        vie0.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuViewClick:)];
        [tap setNumberOfTapsRequired:1];
        [tap setNumberOfTouchesRequired:1];
        [vie0 addGestureRecognizer:tap];
        [self.contentFontWinView addSubview:[vie0 viewWithTag:i]];
        if ((((_selectBits & (0x1 << i)))==(0x1 << i))) {
            self.selectModelCount ++;
            if( self.firstSelectImgV){
                [self.firstSelectImgV removeFromSuperview];
            
                self.firstSelectImgV = nil;
            }
            if (_selectModelCount == 1) {
                if (!self.firstSelectImgV) {
                    _firstSelectImgV = [[UIImageView alloc]init];
                    [self.view addSubview:_firstSelectImgV];
                    [_firstSelectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.view.mas_left).with.offset(40);
                        make.right.equalTo(self.view.mas_right).with.offset(-40);
                        make.top.equalTo(self.view.mas_top).with.offset(94);
                        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
                    }];
                }
                self.firstSelectImgV.image = [UIImage imageNamed:self.imgArr[i]];
                if (self.secendSelectImgV) {
                    
                    [self.secendSelectImgV removeFromSuperview];
                    self.secendSelectImgV = nil;
                }
                self.firstSelectIndex = i;
                self.previousPtIndex = i;
                
//                selectBits &= 1<<i;
                
            }else if (_selectModelCount == 2){
                self.scendSelectIndex = i;
                self.firstSelectImgV = nil;
                self.secendSelectImgV = nil;
                
//                selectBits &= ((1<<(_firstSelectIndex))+(1<<_scendSelectIndex));
                if (!self.secendSelectImgV) {
                    _secendSelectImgV = [[UIImageView alloc]init];
                    [self.view addSubview:_secendSelectImgV];
                    [_secendSelectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.view.mas_left).with.offset(40);
                        make.right.equalTo(self.view.mas_right).with.offset(-40);
                        make.top.equalTo(self.view.mas_top).with.offset(94);
                        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
                    }];
                }
                
                if (!self.firstSelectImgV) {
                    _firstSelectImgV = [[UIImageView alloc]init];
                    [self.view addSubview:_firstSelectImgV];
                    [_firstSelectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.view.mas_left).with.offset(40);
                        make.right.equalTo(self.view.mas_right).with.offset(-40);
                        make.top.equalTo(self.view.mas_top).with.offset(94);
                        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
                    }];
                }
                self.secendSelectImgV.image = [UIImage imageNamed:self.imgArr[i]];
                self.firstSelectImgV.image = [UIImage imageNamed:self.imgArr[_firstSelectIndex]];
                
                
            }
            
        }
        
    }

}
-(void)svpDissmiss{
    [SVProgressHUD dismiss];
}

#pragma mark -

- (BOOL)isAlphaVisibleAtPoint:(CGPoint)point forImage:(UIImage *)image {
    
    CGSize iSize = image.size;
    CGSize bSize = self.view.bounds.size;
    point.x *= (bSize.width != 0) ? (iSize.width / bSize.width) : 1;
    point.y *= (bSize.height != 0) ? (iSize.height / bSize.height) : 1;
    
    UIColor *pixelColor = [image colorAtPoint:point];
    CGFloat alpha = 0.0;
    
    if ([pixelColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        
        [pixelColor getRed:NULL green:NULL blue:NULL alpha:&alpha];
    } else {
        CGColorRef cgPixelColor = [pixelColor CGColor];
        alpha = CGColorGetAlpha(cgPixelColor);
    }
    return alpha >= kAlphaVisibleThreshold;
}

- (void)menuViewClick:(UIPanGestureRecognizer *)recognizer{
    
    
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)recognizer;
    NSInteger tag = tap.view.tag;
    RectItem *items = [[RectItem alloc]init];
    items = self.frontRectItemArray[tag];
    UIImage *alphaImg = [UIImage imageNamed:self.alphaImgArr[tag]];
    UIImageView *alphaImgV = [[UIImageView alloc]init];
    alphaImgV.image = alphaImg;
    [self.view addSubview:alphaImgV];
    [alphaImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(40);
        make.right.equalTo(self.view.mas_right).with.offset(-40);
        make.top.equalTo(self.view.mas_top).with.offset(94);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
    }];
    CGPoint tapPoint = [recognizer locationInView:recognizer.view];
    
 
    
    
    if ([self isAlphaVisibleAtPoint:tapPoint forImage:alphaImg]) return;
    
    [alphaImgV removeFromSuperview];
    BOOL selectStatus = false;
    _previousSelectCount = _selectModelCount;
    
    unsigned int  selectCount = 0,temSelectCount = 0;
    _selectModelCount = 0;
    for (unsigned int int_i = 0; int_i < 22; int_i++) {
        if ((((_selectBits & (0x1 << int_i))) == (0x1 << int_i))) {
            if ((temSelectCount ++) >= 2) {
                
                if (((self.frontTatleCount == 1)&&(self.isFront)&&(int_i != self.frontSelectFirstIndex))||((self.frontTatleCount == 2)&&(self.isFront)&&(int_i != self.frontSelectFirstIndex)&&(int_i != _frontSelectScendIndex))||((self.selectModelCount == 1)&&(!self.isFront)&&(int_i != self.firstSelectIndex))||((self.selectModelCount == 2)&&(!self.isFront)&&(int_i != self.firstSelectIndex)&&(int_i != _scendSelectIndex))){
                    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
                    [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"tip_select_maximum_amount", nil)];
                    [SVProgressHUD setBackgroundColor:RGBA(1, 1, 1, 0.9)];//设置HUD的背景颜色
                    [self performSelector:@selector(svpDissmiss) withObject:nil afterDelay:1];
                    [SVProgressHUD setFont:[UIFont systemFontOfSize:20]];
                    
                    return;
                }
            }

            
        }
    }
    _selectBits  ^= (0x1<<tag);
    
    //通过比特位移位，取位操作完成记忆区块对应的肌肉enable状态获取---<<< 实时
    for (unsigned int i = 0; i < 22; i++) {
        if ((((_selectBits & (0x1<<i))) == (0x1<<i))) {
           
            ++selectCount;
            
            if (i == tag) {
                selectStatus = true;
            }
            

        
            }
        if(((_selectBits & (1<<i)) == 0)){
            if (i == tag) {
                selectStatus = false;
            }
        }
        if (selectCount > 2) {
            
            _selectBits  ^= (0x1 << tag);
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
            [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"tip_select_maximum_amount", nil)];
            [SVProgressHUD setBackgroundColor:RGBA(1, 1, 1, 0.9)];//设置HUD的背景颜色
            [self performSelector:@selector(svpDissmiss) withObject:nil afterDelay:1];
            if (([self.locationBodyArr[tag] integerValue] != [self.locationBodyArr[self.previousPtIndex] integerValue])) {
                //WARNING 提示只能选择一个肌肉位区的点
                
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
                [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"tip_select_error", nil)];
                [SVProgressHUD setBackgroundColor:RGBA(1, 1, 1, 0.9)];//设置HUD的背景颜色
                [SVProgressHUD setFont:[UIFont systemFontOfSize:20]];
                
                [self performSelector:@selector(svpDissmiss) withObject:nil afterDelay:1];
            
            }                                                                                                                                            
            
        
            return;
            
        }
        if (selectCount == 2) {
            //  ---->判断是否是同一半身的肌肉位区
            //否
            if (([self.locationBodyArr[tag] integerValue] != [self.locationBodyArr[self.previousPtIndex] integerValue])) {
                //WARNING 提示只能选择一个肌肉位区的点
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
                [SVProgressHUD setBackgroundColor:RGBA(1, 1, 1, 0.9)];//设置HUD的背景颜色
                
                [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"tip_select_error", nil)];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]]; //字体颜色
                [self performSelector:@selector(svpDissmiss) withObject:nil afterDelay:1];
                [SVProgressHUD setFont:[UIFont systemFontOfSize:20]];
                
                DLog(@"只能同时选择同一半身的肌肉进行治疗<<<<<<<<<<<<<")
                _selectBits  ^= (0x1 << tag);
//                selectBits &= (1<<self.firstSelectIndex);
                return;
            }
        }
        
//        if (selectStatus == true) {
//            if (self.selectModelCount == 1) {
//                _firstSelectIndex = tag;
//                _selectBits &= (0x1<<_firstSelectIndex);
//            }
//            if (self.previousSelectCount == 2) {
//                _firstSelectIndex = tag;
//            }
//        }
        if (selectStatus == false) {
            if (tag == i) {
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
                [SVProgressHUD setBackgroundColor:RGBA(1, 1, 1, 0.9)];//设置HUD的背景颜色
                [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"tip_cancel_part", nil),self.bodyTitleArr[i]]];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]]; //字体颜色
                [self performSelector:@selector(svpDissmiss) withObject:nil afterDelay:1];
                [SVProgressHUD setFont:[UIFont systemFontOfSize:20]];
            
            }
        }
        if (selectStatus == true) {
            if (tag == i) {
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
                [SVProgressHUD setBackgroundColor:RGBA(1, 1, 1, 0.9)];//设置HUD的背景颜色
                [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"tip_select_part", nil),self.bodyTitleArr[i]]];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]]; //字体颜色
                [self performSelector:@selector(svpDissmiss) withObject:nil afterDelay:1];
                [SVProgressHUD setFont:[UIFont systemFontOfSize:20]];
                
            }
        }
    }
    self.rightConfirmBarTitle = [NSString stringWithFormat:@"%@ (%d/2)",NSLocalizedString(@"ok", nil),selectCount];
    [self setUpNavStyle];
    self.displaySelecCount = selectCount;
    if (self.firstSelectImgV) {
        [self.firstSelectImgV removeFromSuperview];
        self.firstSelectImgV = nil;
    }
    if (self.secendSelectImgV) {
        [self.secendSelectImgV removeFromSuperview];
        self.secendSelectImgV = nil;
    }
   
    [self setBackDefaultData];
    [self setDefautData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
