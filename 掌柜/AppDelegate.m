//
//  AppDelegate.m
//  掌柜
//
//  Created by yubing on 16/10/31.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic,strong) UITabBarController * tabBarController;
@property (nonatomic,strong) UIImageView * tabBarbg;
@property (nonatomic,assign) int flag;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    CGFloat a = MUT_HEIGHT;
    
    _flag = 0;
    
    _tabBarController = [[UITabBarController alloc] init];
    HomePageViewController * hvc = [[HomePageViewController alloc] init];
    UINavigationController * nvc1 = [[UINavigationController alloc] initWithRootViewController:hvc];
    hvc.delegate = self;
    
    ShopViewController * svc = [[ShopViewController alloc] init];
    UINavigationController * nvc2 = [[UINavigationController alloc] initWithRootViewController:svc];
    
    NewsViewController * nvc = [[NewsViewController alloc] init];
    UINavigationController * nvc3 = [[UINavigationController alloc] initWithRootViewController:nvc];
    
    ShoppingtrolleyViewController * stvc = [[ShoppingtrolleyViewController alloc] init];
    UINavigationController * nvc4 = [[UINavigationController alloc]initWithRootViewController:stvc];
    
    CenterViewController * cvc = [[CenterViewController alloc] init];
    UINavigationController * nvc5 = [[UINavigationController alloc] initWithRootViewController:cvc];
    
    _tabBarController.tabBar.hidden = YES;
    _tabBarController.viewControllers =@[nvc1,nvc2,nvc3,nvc4,nvc5];
    self.window.rootViewController = _tabBarController;
    
    _tabBarbg = [[UIImageView alloc] initWithFrame:CGRectMake(0,HEIGHT-40*a,WIDTH,40*a)];
    _tabBarbg.tag = 1001;
    _tabBarbg.image = [UIImage imageNamed:@"2015001.png"];
    [self.window addSubview:_tabBarbg];
    _tabBarbg.userInteractionEnabled = YES;
    NSArray * arr = @[@"首页",@"开店",@"消息",@"购物车",@"掌柜中心"];
    for (int i=0;i<arr.count;i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(WIDTH/5*i+18*a,5*a,25*a,20*a);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-1.png",i+1]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-2.png",i+1] ]forState:UIControlStateSelected];
        button.tag =100+i;
        [_tabBarbg addSubview:button];
        
        if(i==4){
            button.titleEdgeInsets=UIEdgeInsetsMake(35*a,-10*a,0
                                                    ,-10*a);
        }else if (i==3){
           button.titleEdgeInsets=UIEdgeInsetsMake(35*a,-8*a,0
                                                    ,-10*a);
        }
        else{
            button.titleEdgeInsets=UIEdgeInsetsMake(35*a,0,0
                                                    , 0);
        }
        button.titleLabel.font = [UIFont systemFontOfSize:10*a];
        [button setTitleColor:[UIColor colorWithRed:255/255.0 green:80/255.0 blue:0/255.0 alpha:1] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAtion:) forControlEvents:UIControlEventTouchUpInside];
        if (button.tag ==100) {
            button.selected =YES;
            
        }
        
    }

    return YES;
}
-(void)buttonAtion:(UIButton*)button{
    
    for (int i =0;i<5;i++) {
        UIButton * button1 = (UIButton*)[_tabBarbg viewWithTag:100+i];
        button1.selected =NO;
        button1.userInteractionEnabled = YES;
    }
    button.selected=YES;
    if (button.selected==YES) {
        button.userInteractionEnabled = NO;
    }
    _tabBarController.selectedIndex =button.tag-100;
    
}
-(void)hiddenButton{
    _tabBarbg.hidden = YES;
}
-(void)showButton{
    _tabBarbg.hidden = NO;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "self.com.__" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"__" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    NSLog(@"11");
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"__.sqlite"];
    NSLog(@"%@",storeURL);
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
