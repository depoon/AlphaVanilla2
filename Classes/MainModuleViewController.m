//
//  MainModuleViewController.m
//  AlphaVanilla2
//
//  Created by Kenneth on 18/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import "MainModuleViewController.h"
#import "CreateBetViewController.h"
#import <Parse/Parse.h>
#import "BetListObject.h"
#import "ParseManager.h"
#import "PGColor.h"
#import <QuartzCore/QuartzCore.h>
#import "FacebookImageLoadManager.h"

int MainModuleViewController_imageViewTag = 100;

@implementation MainModuleViewController{
    @private BetListObject* betListObject;
    @private ParseManager* parseManager;
    @private FacebookImageLoadManager* facebookImageLoadManager;
    @private int selectedIndex;
    @private EGORefreshTableHeaderView *refreshHeaderView;
    
    @private BOOL _reloading;
}

-(id) init{
    self = [super init];
    betListObject = [[BetListObject alloc]init];
    parseManager = [[ParseManager alloc]init];
    [parseManager setParseQueryBetRequestDelegate:self];
    facebookImageLoadManager = [[FacebookImageLoadManager alloc]init];
    
    selectedIndex = -1;

    return self;
}

-(void) dealloc{
    if (betListObject){
        [betListObject release];
        betListObject = nil;
    }
    if (parseManager){
        [parseManager release];
        parseManager = nil;
    }
    if (facebookImageLoadManager){
        [facebookImageLoadManager release];
        facebookImageLoadManager = nil;
    }
    if (refreshHeaderView){
        [refreshHeaderView release];
        refreshHeaderView = nil;
    }
    [super dealloc];
}

-(void) setRefreshHeaderView: (EGORefreshTableHeaderView*) _refreshHeaderView{
    if (refreshHeaderView){
        [refreshHeaderView release];
        refreshHeaderView = nil;
    }
    refreshHeaderView = [_refreshHeaderView retain];
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void) setupBackgroundView{
    UIImage* backgroundImage = [UIImage imageNamed:@"generalBackground"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:backgroundImage]];
}

-(void) viewDidLoad{
    [super viewDidLoad];
    [self setupBackgroundView];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    
    UIBarButtonItem* createBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createBet)];
    [self.navigationItem setRightBarButtonItem:createBarButtonItem animated:YES];
    [createBarButtonItem release];
    
    EGORefreshTableHeaderView* _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];

    
    _refreshHeaderView.backgroundColor = [self.view backgroundColor];
    _refreshHeaderView.delegate = self;
    [self.tableView addSubview:_refreshHeaderView];
    [self setRefreshHeaderView:_refreshHeaderView];
    [_refreshHeaderView release];

    
    self.title = @"Bet Lists";
}

-(void) createBet{
    CreateBetViewController* createBetViewConroller = [[CreateBetViewController alloc]init];
    [self.navigationController pushViewController:createBetViewConroller animated:YES];
    [createBetViewConroller release];
}

-(void) reloadAllBets{
    [betListObject clearAllBets];
    [parseManager queryAllBets];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    selectedIndex = -1;
    
    [self reloadAllBets];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [betListObject getTotalCount];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == selectedIndex){
        return 170;
    }
    if (indexPath.row>=0 && indexPath.row<[betListObject getTotalCount]){
        return 60;
    }
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
	if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier] autorelease];
	}
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
	if([cell.contentView subviews]){
		for (UIView *subviews in [cell.contentView subviews]){
			[subviews removeFromSuperview];
		}

	}
    
    int heightToUse = 60;
    if (indexPath.row == selectedIndex){
        heightToUse = 170;
    }
    
    [cell.contentView setFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, heightToUse)];
    
    
    PGColor* pgColor = [[PGColor alloc]init];
    [pgColor setupGradientBackgroundColor:cell.contentView color:[PGColor defaultTableViewColor]];
    [pgColor release];
    
    BetObject* betObject = [betListObject getBetAtIndex:indexPath.row];
    
    NSString* facebookId = betObject.offerFacebookId;
    

    UIImageView* offerIdImageView = [[UIImageView alloc]initWithImage:nil];
    [offerIdImageView setFrame:CGRectMake(5, 5, 50, 50)];
    offerIdImageView.layer.cornerRadius = 5;
    offerIdImageView.layer.masksToBounds = YES;
    
    [facebookImageLoadManager loadUserFacebookImage:offerIdImageView facebookId:facebookId];

    [cell.contentView addSubview:offerIdImageView];
    [offerIdImageView release];

    UILabel* offerNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 250, 30)];
    [offerNameLabel setBackgroundColor:[UIColor clearColor]];
    [offerNameLabel setText:[NSString stringWithFormat:@"%@ predicts:", betObject.offerName]];
    [cell.contentView addSubview:offerNameLabel];
    [offerNameLabel release];


    UILabel* predictionLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 30, 220, 30)];
    [predictionLabel setBackgroundColor:[UIColor clearColor]];
    [predictionLabel setText:[NSString stringWithFormat:@"\"%@\"", betObject.prediction]];
    [cell.contentView addSubview:predictionLabel];
    [predictionLabel release];
    
//    [cell.textLabel setText:betObject.prediction];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //The user is selecting the cell which is currently expanded
    //we want to minimize it back
    if(selectedIndex == indexPath.row)
    {
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
    //First we check if a cell is already expanded.
    //If it is we want to minimize make sure it is reloaded to minimize it back
    if(selectedIndex >= 0)
    {
        NSIndexPath *previousPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:previousPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    //Finally set the selected index to the new selection and reload it to expand
    selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}
-(void) queryFinishedLoading: (NSArray*) resultsArray{
    [betListObject addBetsArray:resultsArray];    
    [self.tableView reloadData];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}

- (void)reloadTableViewDataSource{
    
    // should be calling your tableviews data source model to reload
    // put here just for demo
    _reloading = YES;
    
    
}

- (void)doneLoadingTableViewData{
    
    // model should call this when its done loading
    _reloading = NO;
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
}
@end
