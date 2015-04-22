/**
 * This file is part of the SYRefreshTable package.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 743523983@qq.com>
 *
 * For more information, please view SYRefreshTable (https://github.com/reesun1130/SYRefreshTable)
 */

#import "SYTableViewController.h"
#import "SYTableHeaderView.h"
#import "SYTableFooterView.h"

static const CGFloat kDEFAULT_HEIGHT_OFFSET = 50.0;

@implementation SYTableViewController
 
- (void)initialize
{
    _canRefresh = YES;//默认可以刷新
    isLoadingMore = NO;
    isRefreshing = NO;
    isDragging = NO;
    _canLoadMore = NO;
    willLoadMore = NO;
    willRefresh = NO;
}

- (id)init
{
    if (self = [super init])
    {
        [self initialize];
    }
    
    return self;
}
 
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initialize];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    refreshDate = [NSDate date];
    dateFormatter = [[NSDateFormatter alloc] init];

    self.itemArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.pageCount = 1;
    
    //CGFloat height = CGRectGetHeight(self.view.bounds) - self.navigationController.navigationBar.frame.size.height;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), KDeviceHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.showsHorizontalScrollIndicator = NO;
    //self.tableView.showsVerticalScrollIndicator = NO;
    //self.tableView.scrollsToTop = NO;
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**
     *  取消cell的选中状态
     */
    NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
    
    if (selected)
    {
        [self.tableView deselectRowAtIndexPath:selected animated:animated];
    }
}

- (void)releaseViewComponents
{
    if (_headerView)
    {
        _headerView = nil;
    }
    
    if (_footerView)
    {
        _footerView = nil;
    }
    
    if (_tableView)
    {
        _tableView.delegate = nil;
        _tableView.dataSource = nil;
        _tableView = nil;
    }
    
    if (_itemArray)
    {
        [_itemArray removeAllObjects];
        _itemArray = nil;
    }
}

- (void)dealloc
{
    [self releaseViewComponents];
}

 
#pragma mark -
#pragma mark Pull to Refresh

- (void)setHeaderView:(UIView *)aView
{
    if (!_tableView)
        return;
  
    if (_headerView && [_headerView isDescendantOfView:_tableView])
    {
        [_headerView removeFromSuperview];
        _headerView = nil;
    }
    
    if (aView)
    {
        _headerView = aView;
        
        CGRect f = _headerView.frame;
        _headerView.frame = CGRectMake(f.origin.x + (_tableView.frame.size.width - f.size.width) / 2.0, 0 - f.size.height, f.size.width, f.size.height);
        [_tableView addSubview:_headerView];
    }
}
 
- (CGFloat)headerRefreshHeight
{
    if (_headerView)
        return _headerView.frame.size.height;
    else
        return 0;
}

- (void)headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
    SYTableHeaderView *hv = (SYTableHeaderView *)self.headerView;
    
    willRefresh = willRefreshOnRelease;
    
    if (willRefreshOnRelease)
    {
        [hv readyForRefresh];
    }
    else
    {
        [hv cancleForRefresh];
    }
    
    hv.time.text = [NSString stringWithFormat:@"最后刷新:%@",[self customTime]];
}

/**
 *  即将开始刷新
 */
- (void)willBeginRefresh
{ 
    if (_canRefresh)
    {
        [self pinHeaderView];
    }
}

/**
 *  开始刷新action
 */
- (void)pinHeaderView
{
    [UIView animateWithDuration:0.25 animations:^(void) {
        self.tableView.contentInset = UIEdgeInsetsMake([self headerRefreshHeight], 0, 0, 0);
    }];
    
    SYTableHeaderView *hv = (SYTableHeaderView *)self.headerView;
    [hv beginForRefresh];
}

/**
 *  结束刷新
 */
- (void)unpinHeaderView
{
    [UIView animateWithDuration:0.25 animations:^(void) {
        self.tableView.contentInset = UIEdgeInsetsZero;
    }];
    
    if (refreshDate) {
        refreshDate = nil;
    }
    refreshDate = [NSDate date];
    
    SYTableHeaderView *hv = (SYTableHeaderView *)self.headerView;
    [hv endForRefresh];
}

/**
 *  刷新动作
 *
 *  @return 现在是否可以刷新
 */
- (BOOL)refresh
{
    if (isRefreshing)
        return NO;
    
    [self willBeginRefresh];
    
    isRefreshing = YES;
    
    return YES;
}

/**
 *  结束刷新
 */
- (void)refreshCompleted
{
    isRefreshing = NO;
    willRefresh = NO;
    
    if (_canRefresh)
    {
        [self unpinHeaderView];
    }
}

 
#pragma mark -
#pragma mark Pull To Load More

- (void)setFooterView:(UIView *)aView
{
    if (!_tableView)
        return;
    
    _tableView.tableFooterView = nil;
    
    if (_footerView)
    {
        _footerView = nil;
    }
    
    if (aView)
    {
        _footerView = aView;
        _tableView.tableFooterView = _footerView;
        
        if ([aView isKindOfClass:[SYTableFooterView class]])
        {
            SYTableFooterView *fv = (SYTableFooterView *)aView;
            fv.loadMoreBlock = ^(){
                [self loadMore];
            };
        }
    }
}

- (CGFloat)footerLoadMoreHeight
{
    if (_footerView)
        return _footerView.frame.size.height;
    else
        return kDEFAULT_HEIGHT_OFFSET;
}

- (void)setFooterViewVisibility:(BOOL)visible
{
    if (visible && self.tableView.tableFooterView != _footerView)
    {
        self.tableView.tableFooterView = _footerView;
    }
    else if (!visible)
    {
        self.tableView.tableFooterView = nil;
        self.tableView.tableFooterView = [[UIView alloc] init];
    }
}

- (void)footerViewDidScroll:(BOOL)willLoadMoreOnRelease scrollView:(UIScrollView *)scrollView
{
    SYTableFooterView *fv = (SYTableFooterView *)self.footerView;
    
    willLoadMore = willLoadMoreOnRelease;

    if (willLoadMoreOnRelease)
    {
        [fv readyForLoadMore];
    }
    else
    {
        [fv endForLoadMore];
    }
}

/**
 *  将要加载更多
 */
- (void)willBeginLoadingMore
{
    SYTableFooterView *fv = (SYTableFooterView *)self.footerView;
    [fv beginForLoadMore];
}

/**
 *  加载结束
 */
- (void)loadMoreCompleted
{
    isLoadingMore = NO;
    willLoadMore = NO;
    
    SYTableFooterView *fv = (SYTableFooterView *)self.footerView;
    [fv endForLoadMore];

    //没有更多，就不需要在显示
    [self setFooterViewVisibility:_canLoadMore];
}

/**
 *  加载更多
 *
 *  @return 现在是否可以加载更多
 */
- (BOOL)loadMore
{
    if (isLoadingMore)
        return NO;
    
    [self willBeginLoadingMore];
    
    isLoadingMore = YES;
    
    return YES;
}

 
#pragma mark - 
#pragma mark 加载、刷新完毕

- (void)makeAllLoadingCompleted
{
    if (isRefreshing)
        [self refreshCompleted];
    if (isLoadingMore)
        [self loadMoreCompleted];
}

 
#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (isRefreshing || isLoadingMore)
        return;
    
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!isRefreshing && isDragging && scrollView.contentOffset.y < 0)
    {
        SYLog(@"---refresh----- %f",scrollView.contentOffset.y);
        
        /**
         *  拖到头部时才去更新刷新
         *  此时我设置更新UI的位置：等拖动过头部视图高时
         */

        if (self.headerView)
        {
            [self headerViewDidScroll:scrollView.contentOffset.y < 0 - [self headerRefreshHeight] scrollView:scrollView];
        }
        
        if (self.footerView)
        {
            [self footerViewDidScroll:NO scrollView:scrollView];
        }
    }
    else if (!isLoadingMore && isDragging && _canLoadMore)
    {
        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.size.height ;
        
        SYLog(@"---loadmore----- %f",scrollPosition);
        
        /**
         *  滚动到底部时才去更新加载更多
         *  此时我设置更新UI的位置：等拖动过底部视图高的2/3时
         */
        if (scrollPosition < 0)
        {
            if (self.footerView)
            {
                [self footerViewDidScroll:0 - scrollPosition > [self footerLoadMoreHeight] * 2 / 3.0 scrollView:scrollView];
            }
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (isRefreshing || isLoadingMore)
        return;
    
    isDragging = NO;
    
    if (_canRefresh && willRefresh)
    {
        [self refresh];
    }
    else if (_canLoadMore && willLoadMore)
    {
        [self loadMore];
    }
}


#pragma mark -
#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

 
#pragma mark -
#pragma mark 刷新的时间

- (NSString *)customTime
{
    NSTimeInterval  timeInterval = [refreshDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    
    long temp = 0;
    
    NSString *result = nil;
    
    if (timeInterval < 60)
    {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval / 60) < 60)
    {
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else
    {
        [dateFormatter setDateFormat:@"MM.dd HH:mm"];
        
        return [dateFormatter stringFromDate:refreshDate];
    }
    
    return  result;
}

@end
