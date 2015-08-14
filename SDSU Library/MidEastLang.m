//
//  MidEastLang.m
//  SDSU Library
//
//  Created by Tyler Rogers on 9/18/13.
//  Copyright (c) 2013 San Diego State University. All rights reserved.
//

#import "MidEastLang.h"
#import "NewBooksXMLParser.h"
#import "SVModalWebViewController.h"
#import "NewBook.h"
#import "NewBookCell.h"

// This framework is imported so we can use the kCFURLErrorNotConnectedToInternet error code.
#import <CFNetwork/CFNetwork.h>

@interface MidEastLang ()

@property (nonatomic) NSMutableArray *bookList;
@property (nonatomic) NSURLConnection *bookFeedConnection;
@property (nonatomic) NSMutableData *bookData; // The data returned from the NSURLConnection.
@property (nonatomic) NSOperationQueue *parseQueue; // The queue that manages our NSOperation for parsing earthquake data.

@end


@implementation MidEastLang


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.bookList = [NSMutableArray array];
    self.title = @"Middle Eastern Languages";
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    /*
     Use NSURLConnection to asynchronously download the data. This means the main thread will not be blocked - the application will remain responsive to the user.
     
     IMPORTANT! The main thread of the application should never be blocked!
     Also, avoid synchronous network access on any thread.
     */
    static NSString *feedURLString = @"http://libpac.sdsu.edu/feeds/MElang.xml";
    NSURLRequest *bookURLRequest =
    [NSURLRequest requestWithURL:[NSURL URLWithString:feedURLString]];
    self.bookFeedConnection = [[NSURLConnection alloc] initWithRequest:bookURLRequest delegate:self];
    /*
     Test the validity of the connection object. The most likely reason for the connection object to be nil is a malformed URL, which is a programmatic error easily detected during development. If the URL is more dynamic, then you should implement a more flexible validation technique, and be able to both recover from errors and communicate problems to the user in an unobtrusive manner.
     */
    NSAssert(self.bookFeedConnection != nil, @"Failure to create URL connection.");
    
    /*
     Start the status bar network activity indicator. We'll turn it off when the connection finishes or experiences an error.
     */
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    self.parseQueue = [NSOperationQueue new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addEarthquakes:) name:kAddBooksNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(earthquakesError:) name:kBooksErrorNotificationName object:nil];
}


#pragma mark - NSURLConnection delegate methods

/*
 The following are delegate methods for NSURLConnection. Similar to callback functions, this is how the connection object, which is working in the background, can asynchronously communicate back to its delegate on the thread from which it was started - in this case, the main thread.
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    /*
     Check for HTTP status code for proxy authentication failures anything in the 200 to 299 range is considered successful, also make sure the MIMEType is correct.
     */
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ((([httpResponse statusCode]/100) == 2) && [[response MIMEType] isEqual:@"application/rss+xml"]) {
        self.bookData = [NSMutableData data];
    }
    else {
        NSString * errorString = NSLocalizedString(@"Test Change", @"Error message displayed when receving a connection error.");
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorString};
        NSError *error = [NSError errorWithDomain:@"HTTP" code:[httpResponse statusCode] userInfo:userInfo];
        [self handleError:error];
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [self.bookData appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if ([error code] == kCFURLErrorNotConnectedToInternet) {
        // If we can identify the error, we present a suitable message to the user.
        NSString * errorString = NSLocalizedString(@"No Connection Error", @"Error message displayed when not connected to the Internet.");
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorString};
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain code:kCFURLErrorNotConnectedToInternet userInfo:userInfo];
        [self handleError:noConnectionError];
    }
    else {
        // Otherwise handle the error generically.
        [self handleError:error];
    }
    
    self.bookFeedConnection = nil;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    self.bookFeedConnection = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    /*
     Spawn an NSOperation to parse the earthquake data so that the UI is not blocked while the application parses the XML data.
     IMPORTANT! - Don't access or affect UIKit objects on secondary threads.
     */
    NewBooksXMLParser *parseOperation = [[NewBooksXMLParser alloc] initWithData:self.bookData];
    [self.parseQueue addOperation:parseOperation];
    
    /*
     The NSOperation object  maintains a strong reference to the earthquakeData until it has finished executing, so we no longer need a reference to earthquakeData in the main thread.
     */
    self.bookData = nil;
}


/**
 Handle errors in the download by showing an alert to the user. This is a very simple way of handling the error, partly because this application does not have any offline functionality for the user. Most real applications should handle the error in a less obtrusive way and provide offline functionality to the user.
 */
- (void)handleError:(NSError *)error {
    
    NSString *errorMessage = [error localizedDescription];
    NSString *alertTitle = NSLocalizedString(@"Failed to parse XML Data", @"Title for alert displayed when download or parse error occurs.");
    NSString *okTitle = NSLocalizedString(@"OK ", @"OK Title for alert displayed when download or parse error occurs.");
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle message:errorMessage delegate:nil cancelButtonTitle:okTitle otherButtonTitles:nil];
    [alertView show];
}


/**
 Our NSNotification callback from the running NSOperation to add the earthquakes
 */
- (void)addEarthquakes:(NSNotification *)notif {
    
    assert([NSThread isMainThread]);
    [self addBooksToList:[[notif userInfo] valueForKey:kBooksResultsKey]];
}


/**
 Our NSNotification callback from the running NSOperation when a parsing error has occurred
 */
- (void)earthquakesError:(NSNotification *)notif {
    
    assert([NSThread isMainThread]);
    [self handleError:[[notif userInfo] valueForKey:kBooksMessageErrorKey]];
}


/**
 The NSOperation "ParseOperation" calls addEarthquakes: via NSNotification, on the main thread which in turn calls this method, with batches of parsed objects. The batch size is set via the kSizeOfEarthquakeBatch constant.
 */
- (void)addBooksToList:(NSArray *)books {
    
    NSInteger startingRow = 0;
    NSInteger newBookCount = [books count];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:newBookCount];
    
    for (NSInteger row = startingRow; row < (startingRow + newBookCount); row++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [indexPaths addObject:indexPath];
    }
    
    [self.bookList addObjectsFromArray:books];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - UITableView delegate methods

// The number of rows is equal to the number of earthquakes in the array.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.bookList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get the specific book for this row.
    static NSString *CellIdentifier = @"NewBookCell";
    NewBook *newBook = (self.bookList)[indexPath.row];
    NewBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[ NewBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.textLabel.text = [newBook title];
    return cell;
    cell = nil;
}


/**
 * When the user taps a row in the table, display the USGS web page that displays details of the earthquake they selected.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewBook *newBook = (self.bookList)[indexPath.row];
    
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress: [newBook link]];
    [self presentViewController:webViewController animated:YES completion:NULL];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"NewBookDetailView"]) {
        
        // Get reference to the destination view controller
        //  WeekView *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        // [vc setMyObjectHere:object];
        [segue.destinationViewController setTitle:@"New Books"];
    }
}




#pragma mark -

- (void)viewDidUnLoad {
    
    _bookList = nil;
    
}


- (void)dealloc {
    
    [_bookFeedConnection cancel];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAddBooksNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kBooksErrorNotificationName object:nil];
}


@end