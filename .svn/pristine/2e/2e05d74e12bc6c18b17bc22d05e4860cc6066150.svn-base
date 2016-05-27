//
//  LDCalendarView.m
//
//  Created by lidi on 15/9/1.
//  Copyright (c) 2015年 lidi. All rights reserved.
//

#import "LDCalendarView.h"
#import "NSDate+extend.h"

#define UNIT_WIDTH  35 * SCREEN_RAT

//行 列 每小格宽度 格子总数
static const NSInteger kRow = 7;
static const NSInteger kCol = 7;
static const NSInteger kTotalNum = (kRow - 1) * kCol;

@implementation UIColor (Extend)
+ (UIColor *)hexColorWithString:(NSString *)string
{
    return [UIColor hexColorWithString:string alpha:1.0f];
}

+ (UIColor *)hexColorWithString:(NSString *)string alpha:(float) alpha
{
    if ([string hasPrefix:@"#"]) {
        string = [string substringFromIndex:1];
    }
    
    NSString *pureHexString = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([pureHexString length] != 6) {
        return [UIColor whiteColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [pureHexString substringWithRange:range];
    
    range.location += range.length ;
    NSString *gString = [pureHexString substringWithRange:range];
    
    range.location += range.length ;
    NSString *bString = [pureHexString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}
@end

@interface LDCalendarView() {
    NSMutableArray *_currentMonthDateArray;
    NSMutableArray *_selectArray;
    
    UIView *_dateBgView;//日期的背景
    UIView  *_contentBgView;
    CGRect _touchRect;//可操作区域
    UIButton *_done; //确定按钮
}
@property (nonatomic, assign)int32_t month;
@property (nonatomic, assign)int32_t year;
@property (nonatomic, strong)UILabel *titleLab;//标题
@property (nonatomic, strong)NSDate *today; //今天0点的时间
@end

@implementation LDCalendarView
- (NSDate *)today {
    if (!_today) {
        NSDate *currentDate = [NSDate date];
        NSInteger tYear = currentDate.year;
        NSInteger tMonth = currentDate.month;
        NSInteger tDay = currentDate.day;
        
        //字符串转换为日期
        //实例化一个NSDateFormatter对象
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        _today =[dateFormat dateFromString:[NSString stringWithFormat:@"%@-%@-%@",@(tYear),@(tMonth),@(tDay)]];
    }
    return _today;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //内容区的背景
        _contentBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.width+50)];
        _contentBgView.layer.cornerRadius = 2.0;
        _contentBgView.layer.masksToBounds = YES;
        _contentBgView.userInteractionEnabled = YES;
        [self addSubview:_contentBgView];
        
        
        UIImageView *leftImage = [UIImageView new];
        leftImage.image = [UIImage imageNamed:@"Group22.png"];
        [_contentBgView addSubview:leftImage];
        leftImage.frame = CGRectMake(CGRectGetWidth(_contentBgView.frame)/3.0 - 8 - 10, (42-13)/2.0, 30, 20);
        
        UIImageView *rightImage = [UIImageView new];
        rightImage.image = [UIImage imageNamed:@"Group 21"];
        [_contentBgView addSubview:rightImage];
        rightImage.frame = CGRectMake(CGRectGetWidth(_contentBgView.frame)*2/3.0 - 10, (42-13)/2.0, 30, 20);
    
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_contentBgView.frame), 42)];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = [UIFont systemFontOfSize:15];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.userInteractionEnabled = YES;
        [_contentBgView addSubview:_titleLab];
        
        UITapGestureRecognizer *titleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchMonthTap:)];
        [_titleLab addGestureRecognizer:titleTap];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLab.frame) - 0.5, CGRectGetWidth(_contentBgView.frame), 0.5)];
        line.backgroundColor = [UIColor darkGrayColor];
        [_contentBgView addSubview:line];
        
        _dateBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLab.frame), CGRectGetWidth(_contentBgView.frame), CGRectGetWidth(_contentBgView.frame))];
        _dateBgView.userInteractionEnabled = YES;
        _dateBgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_contentBgView addSubview:_dateBgView];
        
        UIView *_bottomLine  = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dateBgView.frame), CGRectGetWidth(_contentBgView.frame), 0.5)];
        _bottomLine.backgroundColor = [UIColor darkGrayColor];
        [_contentBgView addSubview:_bottomLine];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_dateBgView addGestureRecognizer:tap];
        
        //初始化数据
        [self initData];

    }
    return self;
}

- (void)initData {
    _selectArray = @[].mutableCopy;
    
    //获取当前年月
    NSDate *currentDate = [NSDate date];
    self.month = (int32_t)currentDate.month;
    self.year = (int32_t)currentDate.year;
    [self refreshDateTitle];

    _currentMonthDateArray = [NSMutableArray array];
    for (int i = 0; i < kTotalNum; i++) {
        [_currentMonthDateArray addObject:@(0)];
    }
    
    [self showDateView];
}

- (void)switchMonthTap:(UITapGestureRecognizer *)tap {
   CGPoint loc =  [tap locationInView:_titleLab];
    CGFloat titleLabWidth = CGRectGetWidth(_titleLab.frame);
    if (loc.x <= titleLabWidth/3.0) {
        //左
        [self leftSwitch];
    }else if(loc.x >= titleLabWidth/3.0*2.0){
        //右
        [self rightSwitch];
    }
}

- (void)leftSwitch{
    //左
    if (self.month > 1) {
        self.month -= 1;
    }else {
        self.month = 12;
        self.year -= 1;
    }
    [_selectArray removeAllObjects];
    [self refreshDateTitle];
}

- (void)rightSwitch {
    if (self.month < 12) {
        self.month += 1;
    }else {
        self.month = 1;
        self.year += 1;
    }
    
    [self refreshDateTitle];
}

- (void)refreshDateTitle {
    _titleLab.text = [NSString stringWithFormat:@"%@月,%@年",@(self.month),@(self.year)];
    
    [self showDateView];
}

- (void)showDateView {
    //移除之前子视图
    [_dateBgView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    CGFloat offX = 0.0;
    CGFloat offY = 0.0;
    CGFloat w = (CGRectGetWidth(_dateBgView.frame)) / kCol;
    CGFloat h = (CGRectGetHeight(_dateBgView.frame)) / kRow;
    CGRect baseRect = CGRectMake(offX,offY, w, h);
    NSArray *tmparr = @[@"S",@"M",@"T",@"W",@"T",@"F",@"S"];
    
    for(int i = 0 ;i < 7; i++)
    {
        UILabel *lab = [[UILabel alloc] initWithFrame:baseRect];
        lab.textColor = [UIColor hexColorWithString:@"848484"];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:15];
        lab.backgroundColor = [UIColor clearColor];
        lab.text = [tmparr objectAtIndex:i];
        [_dateBgView addSubview:lab];
        
        baseRect.origin.x += baseRect.size.width;
    }

    //字符串转换为日期
    //实例化一个NSDateFormatter对象
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *firstDay =[dateFormat dateFromString:[NSString stringWithFormat:@"%@-%@-%@",@(self.year),@(self.month),@(1)]];
    
    CGFloat startDayIndex = [NSDate acquireWeekDayFromDate:firstDay];
    //第一天是今天，特殊处理
    if (startDayIndex == 1) {
        //星期天（对应一）
        startDayIndex = 0;
//        startDayIndex = 6;
    }else {
        //周一到周六（对应2-7）
        startDayIndex -= 1;
//        startDayIndex -= 2;
    }
    
    baseRect.origin.x = w * startDayIndex;
    baseRect.origin.y += (baseRect.size.height);
    NSInteger baseTag = 100;
    for(int i = startDayIndex; i < kTotalNum;i++)
    {
        if (i % kCol == 0 && i!= 0)
        {
            baseRect.origin.y += (baseRect.size.height);
            baseRect.origin.x = offX;
        }
        
        //设置触摸区域
        if (i == startDayIndex)
        {
            _touchRect.origin = baseRect.origin;
            _touchRect.origin.x = 0;
            _touchRect.size.width = kCol * w;
            _touchRect.size.height = kRow * h;
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = baseTag + i;
        [btn setFrame:baseRect];
        btn.userInteractionEnabled = NO;
        btn.backgroundColor = [UIColor clearColor];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        
        NSDate * date = [firstDay dateByAddingTimeInterval:(i - startDayIndex) *24*60*60];
        _currentMonthDateArray[i] = @(([date timeIntervalSince1970]) * 1000);
        NSString *title = INTTOSTR(date.day);
        if(date.day == 1)
        {//是1号
            //在下面标一下月份
            UILabel *monthLab = [[UILabel alloc] initWithFrame:CGRectMake(baseRect.origin.x, baseRect.origin.y + baseRect.size.height - 12, baseRect.size.width, 7)];
            monthLab.backgroundColor = [UIColor clearColor];
            monthLab.textAlignment = NSTextAlignmentCenter;
            monthLab.font = [UIFont systemFontOfSize:11];
            monthLab.textColor = [UIColor blueColor];
            monthLab.text = [NSString stringWithFormat:@"%@月",@(date.month)];
            [_dateBgView addSubview:monthLab];
        } else {
            if ([date isToday])
            {//今天
                [btn setBackgroundImage:[UIImage imageNamed:@"Oval 277"] forState:UIControlStateNormal];
            }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(baseRect.origin.x + 25, baseRect.origin.y - 3 + baseRect.size.height - 12, 6, 6)];
            label.backgroundColor = [UIColor hexColorWithString:@"bfbfbf"];
        label.layer.cornerRadius = 3;
        label.layer.masksToBounds = YES;
        [_dateBgView addSubview:label];
        }
        [btn setTitle:title forState:UIControlStateNormal];
        if ([self.today compare:date] < 0) {
            //时间比今天大,同时是当前月
            [btn setTitleColor:[UIColor hexColorWithString:@"2b2b2b"] forState:UIControlStateNormal];
        }else {
            [btn setTitleColor:[UIColor hexColorWithString:@"bfbfbf"] forState:UIControlStateNormal];
        }
        [btn setBackgroundColor:[UIColor clearColor]];
        [_dateBgView addSubview:btn];
        [_dateBgView sendSubviewToBack:btn];
        
        baseRect.origin.x += (baseRect.size.width);
    }
    
    //高亮选中的
    [self refreshDateView];
}

- (void)setDefaultDates:(NSArray *)defaultDates {
    _defaultDates = defaultDates;
    
    if (defaultDates) {
        _selectArray = [defaultDates mutableCopy];
    }else {
        _selectArray = @[].mutableCopy;
    }
}

- (void)refreshDateView {
    for(int i = 0; i < kTotalNum; i++)
    {
        UIButton *btn = (UIButton *)[_dateBgView viewWithTag:100 + i];
        NSNumber *interval = [_currentMonthDateArray objectAtIndex:i];

        if (i < [_currentMonthDateArray count] && btn)
        {
            if ([_selectArray containsObject:interval]) {
                [btn setBackgroundImage:[UIImage imageNamed:@"Today Ba ckground"] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)show {
    self.hidden = NO;
}

- (void)hide {
    self.hidden = YES;
}

-(void)tap:(UITapGestureRecognizer *)gesture{
    CGPoint point = [gesture locationInView:_dateBgView];
    if (CGRectContainsPoint(_touchRect, point)) {
        CGFloat w = (CGRectGetWidth(_dateBgView.frame)) / kCol;
        CGFloat h = (CGRectGetHeight(_dateBgView.frame)) / kRow;
        int row = (int)((point.y - _touchRect.origin.y) / h);
        int col = (int)((point.x) / w);
        
        NSInteger index = row * kCol + col;
        [self clickForIndex:index];
    }
}

- (void)clickForIndex:(NSInteger)index
{
    UIButton *button = (UIButton *)[_dateBgView viewWithTag:100 + self.indexNumber];
    UIButton *btn = (UIButton *)[_dateBgView viewWithTag:100 + index];
    if (index < [_currentMonthDateArray count]) {
        NSNumber *interval = [_currentMonthDateArray objectAtIndex:index];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval.doubleValue/1000.0];
        if ([self.today  compare:date] < 0) {
            //时间比今天大,同时是当前月
        }else {
            return;
        }
        if (_selectArray.count == 0) {
            if (date.month > self.month) {
                [self rightSwitch];
                return;
            }
            [_selectArray addObject:interval];
            self.indexNumber = [_currentMonthDateArray indexOfObject:interval];
            [btn setBackgroundImage:[UIImage imageNamed:@"Today Ba ckground"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            return;
        }
            if (_selectArray.count == 1) {
                if (date.month > self.month) {
                    [self rightSwitch];
                    return;
                }
            if ([_selectArray containsObject:interval]) {
                [_selectArray removeObject:interval];
                [btn setBackgroundImage:nil forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor hexColorWithString:@"2b2b2b"] forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor clearColor]];
            } else {
                [_selectArray removeAllObjects];
                [_selectArray addObject:interval];
                [btn setBackgroundImage:[UIImage imageNamed:@"Today Ba ckground"] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setBackgroundImage:nil forState:UIControlStateNormal];
                [button setTitleColor:[UIColor hexColorWithString:@"2b2b2b"] forState:UIControlStateNormal];
                [button setBackgroundColor:[UIColor clearColor]];
                self.indexNumber = [_currentMonthDateArray indexOfObject:interval];
            }
                return;
        }
    }
}

@end
