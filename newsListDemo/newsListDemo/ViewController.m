//
//  ViewController.m
//  newsListDemo
//
//  Created by 梁家伟 on 17/3/8.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "MyNewsCellCell.h"
#import "MyNewsObj.h"
#import "YYModel.h"
#import "MJRefresh.h"

@interface ViewController ()<UITableViewDataSource>
@property(nonatomic,weak)UITableView* tableView;
@property(nonatomic,strong)MJRefreshNormalHeader* header;
@property(nonatomic,strong)MJRefreshAutoNormalFooter* footer;
@property(nonatomic,assign)BOOL type;
@end

@implementation ViewController{
    NSMutableArray* _modelData;
}
static NSString* newsCell = @"newscell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //设置导航条标题
    self.navigationItem.title = @"科技头条";
    
    //加载网络数据
    [self loadData];
    
    //加载UI
    [self setupUI];
 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelData.count;
}

-(MyNewsCellCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyNewsCellCell* cell = [tableView dequeueReusableCellWithIdentifier:newsCell forIndexPath:indexPath];
    cell.newsObj = _modelData[indexPath.row];
    return cell;
}


//加载数据并解析JSON的方法
-(void)loadData{
    
    NSString* time = @"0";
    //下拉刷新
    if(_header.isRefreshing){
        time = _modelData.count > 0 ? [[_modelData firstObject] addtime] : @"0";
        _type = 0;
    }
    //下拉刷新
    if(_footer.isRefreshing){
        time = [[_modelData lastObject] addtime];
        _type = 1;
    }
    
    //URL获取
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://news.coolban.com/Api/Index/news_list/app/2/cat/4/limit/20/time/%@/type/%zd",time,_type]];
    //产生个请求
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"请求出错");
            return;
        }
        //获取字典数组
        NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        
        NSArray* modelArr = [NSArray yy_modelArrayWithClass:[MyNewsObj class] json:jsonArray];
        //加载完数据后更新数据
        
        if(!_type){
            _modelData = modelArr.mutableCopy;
        }else{
            [_modelData addObjectsFromArray:modelArr.mutableCopy];
        }
        
//        NSLog(@"%@",_modelData);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //停止刷新
            if(_header.isRefreshing){
                [_header endRefreshing];
            }
            
            if(_footer.isRefreshing){
                [_footer endRefreshing];
            }
            
            [_tableView reloadData];
        
        });
        
    }] resume];
    
}

-(void)setupUI{
    //添加tableView
    UITableView* tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView = tableView;
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    
    //预估行高
    tableView.estimatedRowHeight = 200;
    tableView.rowHeight = UITableViewAutomaticDimension;
    
    //设置上下拉刷新视图
    _header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    _footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    tableView.tableHeaderView = _header;
    tableView.tableFooterView = _footer;
    
    //注册cell
    [tableView registerClass:[MyNewsCellCell class] forCellReuseIdentifier:newsCell];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
