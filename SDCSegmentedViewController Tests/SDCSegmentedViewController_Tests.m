//
//  SDCSegmentedViewController_Tests.m
//  SDCSegmentedViewController Tests
//
//  Created by Scott Berrevoets on 8/17/14.
//  Copyright (c) 2014 Scotty Doesn't Code. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "SDCSegmentedViewController.h"

static NSString *const SDCViewControllerDefaultTitle1 = @"View controller 1";
static NSString *const SDCViewControllerDefaultTitle2 = @"View controller 2";

@interface SDCSegmentedViewController_Tests : XCTestCase
@property (nonatomic, strong) SDCSegmentedViewController *segmentedController;
@property (nonatomic, strong) NSArray *viewControllers;
@end

@implementation SDCSegmentedViewController_Tests

- (void)setUp {
    UIViewController *viewController1 = [[UIViewController alloc] init];
    viewController1.title = SDCViewControllerDefaultTitle1;
    
    UIViewController *viewController2 = [[UIViewController alloc] init];
    viewController2.title = SDCViewControllerDefaultTitle2;
    
    self.viewControllers = @[viewController1, viewController2];
    self.segmentedController = [[SDCSegmentedViewController alloc] initWithViewControllers:self.viewControllers];
}

- (void)testInitializingWithoutTitlesUsesViewControllerTitles {
    UISegmentedControl *segmentedControl = self.segmentedController.segmentedControl;
    
    XCTAssertEqualObjects([segmentedControl titleForSegmentAtIndex:0], SDCViewControllerDefaultTitle1, @"");
    XCTAssertEqualObjects([segmentedControl titleForSegmentAtIndex:1], SDCViewControllerDefaultTitle2, @"");
}

- (void)testInitializingWithUserProvidedTitlesUsesThoseTitles {
    NSString *userProvidedTitle1 = @"User title 1";
    NSString *userProvidedTitle2 = @"User title 2";
    
    self.segmentedController = [[SDCSegmentedViewController alloc] initWithViewControllers:self.viewControllers
                                                                                    titles:@[userProvidedTitle1, userProvidedTitle2]];
    UISegmentedControl *segmentedControl = self.segmentedController.segmentedControl;

    XCTAssertEqualObjects([segmentedControl titleForSegmentAtIndex:0], userProvidedTitle1, @"");
    XCTAssertEqualObjects([segmentedControl titleForSegmentAtIndex:1], userProvidedTitle2, @"");
}

- (void)testSegmentedControlShowsInNavigationBarWhenUserWantsItTo {
    self.segmentedController.position = SDCSegmentedViewControllerControlPositionNavigationBar;
    
    XCTAssertEqualObjects(self.segmentedController.segmentedControl, self.segmentedController.navigationItem.titleView, @"");
}

- (void)testSegmentedControlShowsCenteredInToolbarWhenUserWantsItTo {
    self.segmentedController.position = SDCSegmentedViewControllerControlPositionToolbar;
 
    XCTAssertNoThrow(self.segmentedController.toolbarItems[0], @"");
    XCTAssertNoThrow(self.segmentedController.toolbarItems[2], @"");
    
    UIBarButtonItem *segmentedControlItem;
    XCTAssertNoThrow(segmentedControlItem = self.segmentedController.toolbarItems[1], @"");
    XCTAssertEqualObjects(segmentedControlItem.customView, self.segmentedController.segmentedControl, @"");
}

@end
