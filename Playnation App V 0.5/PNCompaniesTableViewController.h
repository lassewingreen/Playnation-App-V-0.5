//
//  PNCompaniesTableViewController.h
//  Playnation App V 0.4
//
//  Created by Lasse Wingreen on 06/02/14.
//  Copyright (c) 2014 Playnation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNCompaniesTableViewController : UITableViewController

@property (strong,nonatomic) NSDictionary *companiesJsonWrapper;
@property (strong,nonatomic) NSArray *companiesArray;



@end
