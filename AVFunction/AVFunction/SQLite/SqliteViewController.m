//
//  SqliteViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/18.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "SqliteViewController.h"
#import <sqlite3.h>
@interface SqliteViewController ()
@end

@implementation SqliteViewController
static sqlite3 *db;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self openSqlite];
}
-(void)openSqlite{
    if (db != nil) {
        NSLog(@"数据库已经打开");
        return;
    }
    //获取文件路径
    NSString *sqlPath = [NSString stringWithFormat:@"%@/my.sqlite",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject];
    NSLog(@"path:%@",sqlPath);
    //打开数据库
    //将OC字符串转换为C语言的字符串
    const char *cFileName = sqlPath.UTF8String;
    
    //打开数据库文件(如果数据库文件不存在，那么该函数会自动创建数据库文件)
    int rusult = sqlite3_open(cFileName, &db);
    if (rusult == SQLITE_OK) {//打开成功
        NSLog(@"成功打开数据库");
        [self createTable:&rusult];
    }else NSLog(@"打开数据库失败");
    
}
-(void)createTable:(int *)result{
    //创建表
    const char *sql = "CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT,name text NOT NULL ,age integer NOT NULL);";
    char *errmeg = NULL;
    *result = sqlite3_exec(db, sql, NULL, NULL, &errmeg);
    if (*result == SQLITE_OK) {
        NSLog(@"创表成功");
    }else NSLog(@"创表失败 --- %s",errmeg);
}
- (IBAction)insert:(id)sender {
    for (int i = 0; i<20; i++) {
        NSString *name = [NSString stringWithFormat:@"小明--%d",arc4random_uniform(100)];
        int age = arc4random_uniform(20)+10;
        NSString *sql = [NSString stringWithFormat:@"insert into t_student (name,age) values('%@','%d')",name,age];
        //执行SQL语句
        char *errmsg = NULL;
        sqlite3_exec(db, sql.UTF8String, NULL, NULL, &errmsg);
        if (errmsg) {
            //如果有错误信息
            NSLog(@"插入数据失败 -- %s",errmsg);
        }else{
            NSLog(@"插入数据成功");
        }
    }
}
- (IBAction)delete:(id)sender {
    const  char * sql = "delete from t_student where score < 10";
    int ret = sqlite3_exec(db, sql, NULL, NULL, NULL);
    if (ret == SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
}
- (IBAction)update:(id)sender {
}
- (IBAction)select:(id)sender {
    const char *sql = "select id,name,age from t_student where age<20;";
    sqlite3_stmt *stmt = NULL;//stmt来获取查询数据
    //进行查询前的准备
    if(sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK){//SQL语句没有问题
        while (sqlite3_step(stmt)==SQLITE_ROW) {//找到一条记录
            //取出数据
            //(1)取出第(0)列字段的值(int类型的值)
            int ID = sqlite3_column_int(stmt, 0);
            //(2)取出第一列的值(text类型的值);
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            NSString *nameStr = [NSString stringWithUTF8String:name];
            //(3)取出第二列的值(int类型的值)
            int age = sqlite3_column_int(stmt, 2);
            printf("%d %s %d\n",ID,name,age);
        }
        
    }else NSLog(@"查询语句有问题");
    //5.关闭伴随指针
    sqlite3_finalize(stmt);
    
}
-(void)closeSqlite{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
    } else {
        NSLog(@"数据库关闭失败");
    }
    
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
