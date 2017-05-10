//
//  ViewController.m
//  ResolveInstanceMethod
//
//  Created by JianRongCao on 3/22/17.
//  Copyright © 2017 JianRongCao. All rights reserved.
//

#import "ViewController.h"
#import "Human.h"
#import "TPKObject.h"
#import "FMDatabase.h"
#import "Student.h"
#import "FMDatabaseQueue.h"

@interface ViewController ()
{
    NSInteger count;
    BOOL isExecute;
    UIButton *_pwDisplayBtn;
    FMDatabase *_db;
}
@end

#define IsStringEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""])||([(_ref)isEqualToString:@"(null)"]))

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    Human *human = [[Human alloc] init];
//    [human name];
//    
//    TPKObject *tko = [[TPKObject alloc] init];
//    [tko TPKObjectAction:@"name" block:tko];
    
    _pwDisplayBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 32.5, 22.5)];
    [_pwDisplayBtn setImage:[UIImage imageNamed:@"yj2"] forState:UIControlStateNormal];
    [_pwDisplayBtn setImage:[UIImage imageNamed:@"yj"] forState:UIControlStateSelected];
    [_pwDisplayBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [_pwDisplayBtn addTarget:self action:@selector(passWordTextFieldRightBtnClik) forControlEvents:UIControlEventTouchUpInside];
    _pwDisplayBtn.imageView.contentMode = UIViewContentModeRight;
    [self.view addSubview:_pwDisplayBtn];
    
    [self createStudentTable];
}

- (void)createStudentTable
{
    //1.获得数据库文件的路径
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    
    NSString *fileName = [doc stringByAppendingPathComponent:@"student.sqlite"];
    
    //2.获得数据库
    _db = [FMDatabase databaseWithPath:fileName];
    
    //3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
    if ([_db open])
    {
        //4.创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL,age1 integer NOT NULL,age2 integer NOT NULL,age3 integer NOT NULL,age4 integer NOT NULL,age5 integer NOT NULL,age6 integer NOT NULL,age7 integer NOT NULL,age8 integer NOT NULL,age9 integer NOT NULL,age10 integer NOT NULL);"];
        NSLog(@"%@",result ? @"创建表成功" : @"创建表失败");
        if (result) {
            [self insertStudent];
        }
    }
}

- (void)insertStudent
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for(int idx = 0; idx < 100000; idx ++){
        Student *student = [[Student alloc] init];
        student.stuId = idx + 340000;
        student.name = [NSString stringWithFormat:@"学生%d",idx];
        student.age = arc4random()%10 + 10;
        [items addObject:student];
    }
    
    NSLog(@"1111111111");
    if ([_db open] == NO)
    {
        [_db close];
        return;
    }
   
    //************第一种数据插入方式，普通的队列插入方式************
//    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
//    NSString *fileName = [doc stringByAppendingPathComponent:@"student.sqlite"];
//    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
//    [queue inDatabase:^(FMDatabase *db) {
//        for (int i = 0;i < items.count ; i ++) {
//            Student *stu = [items objectAtIndex:i];
//            NSString *sql = [NSString stringWithFormat:@"insert into t_student (name,age,age1,age2,age3,age4,age5,age6,age7,age8,age9,age10) values ('%@',%d,'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",stu.name,stu.age,stu.name,stu.name,stu.name,stu.name,stu.name,stu.name,stu.name,stu.name,stu.name,stu.name];
//            [db executeUpdate:sql];
//        }
//    }];
    
    //************第二种数据插入方式，事务处理的方式************
//    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
//    NSString *fileName = [doc stringByAppendingPathComponent:@"student.sqlite"];
//    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
//    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
//        for (int i = 0;i < items.count ; i ++) {
//            Student *stu = [items objectAtIndex:i];
//            NSString *sql = [NSString stringWithFormat:@"insert into t_student (name,age,age1,age2,age3,age4,age5,age6,age7,age8,age9,age10) values ('%@',%d,'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",stu.name,stu.age,stu.name,stu.name,stu.name,stu.name,stu.name,stu.name,stu.name,stu.name,stu.name,stu.name];
//            [db executeUpdate:sql];
//        }
//    }];
    
    //************第三种数据插入方式，事务处理的方式************
    [_db beginTransaction];
    @try {
        for (int i = 0;i < items.count ; i ++) {
            Student *stu = [items objectAtIndex:i];
            NSString *sql = [NSString stringWithFormat:@"insert into t_student (name,age,age1,age2,age3,age4,age5,age6,age7,age8,age9,age10) values ('%@',%d,'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",stu.name,stu.age,stu.name,stu.name,stu.name,stu.name,stu.name,stu.name,stu.name,stu.name,stu.name,stu.name];
            [_db executeUpdate:sql];
        }
    }
    @catch (NSException *exception)
    {
        [_db rollback];
    }
    @finally
    {
        [_db commit];
    }
    
    [_db close];
    NSLog(@"1111111111");
}

- (void)passWordTextFieldRightBtnClik
{
    [_pwDisplayBtn setSelected:![_pwDisplayBtn isSelected]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    count ++;
    [self showCount];
}

- (void)showCount
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (isExecute == NO) {
            [self logCount];
        }
    });
}

- (void)logCount
{
    isExecute = YES;
    NSLog(@"%ld",count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
