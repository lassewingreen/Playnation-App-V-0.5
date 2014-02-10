//
//  PNCompaniesTableViewController.m
//  Playnation App V 0.4
//
//  Created by Lasse Wingreen on 06/02/14.
//  Copyright (c) 2014 Playnation. All rights reserved.
//

#import "PNCompaniesTableViewController.h"





#import "CoreData+MagicalRecord.h"

#import "NSDictionary+LowercaseDicionary.h"

//#import "Companies.h"

//#import "Companies+safeSetValuesKeysWithDictionary.h"

@interface PNCompaniesTableViewController ()
//{
//    AFHTTPRequestOperationManager *_manager;
//}




@end

@implementation PNCompaniesTableViewController

@synthesize companiesArray, companiesJsonWrapper;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initialize AFHTTPRequestOperationManager with Playnation base URL
   //_manager = [AFHTTPRequestOperationManager manager];
    //Refresh button
    
    [self refreshData];
    
    NSLog(@"View Did Load!");
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) refreshData
{
    
    
    
    //Fetch popular shots from
    
//    NSDictionary *parameters = @{@"tableName": @"companies"};
//    [_manager POST:@"http://playnation.eu/beta/hacks/getItemiOStest.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);        //Success
//        //AFNetworking parses the JSON response, which can now be used like a NSDictionary
    
        
        
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
   
    
    NSURL * url = [NSURL URLWithString:@"http://playnation.eu/beta/hacks/getItemiOStest.php"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString * params =@"tableName=companies";
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           
                                                           NSLog(@"Refresh Data!");

                                                           
                                                            NSLog(@"Response:%@ %@\n", response, error);

                                                           NSError *jsonError = nil;
                                                           
                                                           companiesJsonWrapper = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                                                           
                                                           
                                                           if (!companiesJsonWrapper) {
                                                               NSLog(@"Error parsing JSON: %@", jsonError);
                                                           }

                                                           else {
                                                               NSLog(@"jsonList: %@", companiesJsonWrapper);
    
        id companies = [companiesJsonWrapper objectForKey:@"results"];
        
        NSLog(@"RESPONSE OBJECT: %@", companies);
        
        
        //Loop through shots from API
        for (id company in companies)
        {
            
            
        id lowercaseCompany = [company dictionaryWithLowercaseKeys];
            
//
            
                NSLog(@" LOWER CASE COMPANY: %@", lowercaseCompany);
                
//                if ([Companies respondsToSelector:NSSelectorFromString(keyWithFirstCharLowered)]) {
//                    [Companies setValue:[company valueForKey:key] forKey:keyWithFirstCharLowered];
//                }
            
            
            
            
//            NSDictionary *keyedValues = nil;
//            NSDateFormatter *dateFormatter = nil;
//            
//            id value = [keyedValues objectForKey:lowercaseCompany];
//            if (value == nil) {
//                continue;
//            }
//            NSAttributeType attributeType = [[companies objectForKey:lowercaseCompany] attributeType];
//            if ((attributeType == NSStringAttributeType) && ([value isKindOfClass:[NSNumber class]])) {
//                value = [value stringValue];
//            } else if (((attributeType == NSInteger16AttributeType) || (attributeType == NSInteger32AttributeType) || (attributeType == NSInteger64AttributeType) || (attributeType == NSBooleanAttributeType)) && ([value isKindOfClass:[NSString class]])) {
//                value = [NSNumber numberWithInteger:[value integerValue]];
//            } else if ((attributeType == NSFloatAttributeType) &&  ([value isKindOfClass:[NSString class]])) {
//                value = [NSNumber numberWithDouble:[value doubleValue]];
//            } else if ((attributeType == NSDateAttributeType) && ([value isKindOfClass:[NSString class]]) && (dateFormatter != nil)) {
//                value = [dateFormatter dateFromString:value];
//            }
            
            
            
//            //Take some values we'll need
           NSString *idCompany = [lowercaseCompany objectForKey:@"id_company"];
                NSString *companyName = [lowercaseCompany objectForKey:@"companyname"];
//            NSString *shotName = [company objectForKey:@"title"];
//            NSString *imageUrl = [company objectForKey:@"image_teaser_url"];
//            NSString *playerName = [[company objectForKey:@"player"] objectForKey:@"name"];
            
            //Check if we already saved this shot...
            
            
            //Companies *existingEntity = [Companies MR_findFirstByAttribute:@"id_company" withValue:idCompany];
            
            //...if not, create a new entity
            
//            if (!existingEntity)
//            {
//                
//                Companies *companiesEntity = [Companies MR_createEntity];
//        
//                companiesEntity.companyname = companyName;

                
//                shotEntity.shotId = shotId;
//                shotEntity.name = shotName;
//                shotEntity.playerName = playerName;
//                shotEntity.imageUrl = imageUrl;
           // }
        }
        
        //Persist created entities to storage
        [MagicalRecord saveUsingCurrentThreadContextWithBlock:nil completion:^(BOOL success, NSError *error) {
            
            //Fetch all stored entities &amp; reload tableView
           // companiesArray = [Companies MR_findAll];
            [self.tableView reloadData];
        }];
                                                           
                                                               
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        //Failure
//        NSLog(@"Failed to fetch companies from Playnation!");
//
                                                           }
                                                       
                                         }];
    [dataTask resume];

    
    
   // companiesArray = [Companies MR_findAll];
    
    [self.tableView reloadData];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
