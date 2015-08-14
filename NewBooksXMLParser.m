


#import "NewBooksXMLParser.h"
#import "NewBook.h"

// NSNotification name for sending earthquake data back to the app delegate
NSString *kAddBooksNotificationName = @"AddBooksNotif";

// NSNotification userInfo key for obtaining the book data
NSString *kBooksResultsKey = @"BooksResultsKey";

// NSNotification name for reporting errors
NSString *kBooksErrorNotificationName = @"BooksErrorNotif";

// NSNotification userInfo key for obtaining the error message
NSString *kBooksMessageErrorKey = @"BooksMsgErrorKey";


@interface NewBooksXMLParser () <NSXMLParserDelegate>

@property (nonatomic) NewBook *currentBookObject;
@property (nonatomic) NSMutableArray *currentParseBatch;
@property (nonatomic) NSMutableString *currentParsedCharacterData;

@end


@implementation NewBooksXMLParser
{
    NSDateFormatter *_dateFormatter;
    
    BOOL _accumulatingParsedCharacterData;
    BOOL _didAbortParsing;
    NSUInteger _parsedNewBooksCounter;
    BOOL ignoreElement;
}


- (id)initWithData:(NSData *)parseData {
    
    self = [super init];
    if (self) {
        _bookData = [parseData copy];
        _currentParseBatch = [[NSMutableArray alloc] init];
        _currentParsedCharacterData = [[NSMutableString alloc] init];
    }
    return self;
}


- (void)addBooksToList:(NSArray *)books {
    
    assert([NSThread isMainThread]);
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddBooksNotificationName object:self userInfo:@{kBooksResultsKey: books}];
}


// The main function for this NSOperation, to start the parsing.
- (void)main {
    
    /*
     It's also possible to have NSXMLParser download the data, by passing it a URL, but this is not desirable because it gives less control over the network, particularly in responding to connection errors.
     */
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.bookData];
    [parser setDelegate:self];
    [parser parse];
    
    /*
     Depending on the total number of earthquakes parsed, the last batch might not have been a "full" batch, and thus not been part of the regular batch transfer. So, we check the count of the array and, if necessary, send it to the main thread.
     */
    if ([self.currentParseBatch count] > 0) {
        [self performSelectorOnMainThread:@selector(addBooksToList:) withObject:self.currentParseBatch waitUntilDone:NO];
    }
     
}


#pragma mark - Parser constants

/*
 Limit the number of parsed earthquakes to 50 (a given day may have more than 50 earthquakes around the world, so we only take the first 50).
 */
static const NSUInteger kMaximumNumberOfBooksToParse = 100;

/*
 When an Earthquake object has been fully constructed, it must be passed to the main thread and the table view in RootViewController must be reloaded to display it. It is not efficient to do this for every Earthquake object - the overhead in communicating between the threads and reloading the table exceed the benefit to the user. Instead, we pass the objects in batches, sized by the constant below. In your application, the optimal batch size will vary depending on the amount of data in the object and other factors, as appropriate.
 */
static NSUInteger const kSizeOfBookBatch = 10;

// Reduce potential parsing errors by using string constants declared in a single place.
static NSString * const kEntryElementName = @"item";
static NSString * const kLinkElementName = @"link";
static NSString * const kTitleElementName = @"title";
static NSString * const kGuideElementName = @"guid";
static NSString * const kDescriptionElementName = @"description";


#pragma mark - NSXMLParser delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    /*
     If the number of parsed earthquakes is greater than kMaximumNumberOfEarthquakesToParse, abort the parse.
     */
    if (_parsedNewBooksCounter >= kMaximumNumberOfBooksToParse) {
        /*
         Use the flag didAbortParsing to distinguish between this deliberate stop and other parser errors.
         */
        _didAbortParsing = YES;
        [parser abortParsing];
    }
    if ([elementName isEqualToString:kEntryElementName]) {
        NewBook *newBook = [[NewBook alloc] init];
        self.currentBookObject = newBook;
    }

    else if ([elementName isEqualToString:kTitleElementName] || [elementName isEqualToString:kDescriptionElementName]) {
        // For the 'title', 'updated', or 'georss:point' element begin accumulating parsed character data.
        // The contents are collected in parser:foundCharacters:.
        _accumulatingParsedCharacterData = YES;
        // The mutable string needs to be reset to empty.
        [self.currentParsedCharacterData setString:@""];
    }
    else if ([elementName isEqualToString:kLinkElementName]) {
        _accumulatingParsedCharacterData = YES;
        // The mutable string needs to be reset to empty.
        [self.currentParsedCharacterData setString:@""];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    
    
    if ([elementName isEqualToString:kEntryElementName]) {
        
        [self.currentParseBatch addObject:self.currentBookObject];
        _parsedNewBooksCounter++;
        if ([self.currentParseBatch count] >= kSizeOfBookBatch) {
            [self performSelectorOnMainThread:@selector(addBooksToList:) withObject:self.currentParseBatch waitUntilDone:NO];
            self.currentParseBatch = [NSMutableArray array];
        }
    }
    else if ([elementName isEqualToString:kTitleElementName]) {
        
        NSScanner *scanner = [NSScanner scannerWithString:self.currentParsedCharacterData];
        
        NSMutableString *title = nil;
        // Scan the remainer of the string.
        if ([scanner scanUpToCharactersFromSet:
             [NSCharacterSet illegalCharacterSet] intoString:&title]) {
            self.currentBookObject.title = title;
        }
        
        
    }
    
    else if ([elementName isEqualToString:kLinkElementName]) {
        
        NSScanner *scanner = [NSScanner scannerWithString:self.currentParsedCharacterData];
        
        NSMutableString *link = nil;
        // Scan the remainer of the string.
        if ([scanner scanUpToCharactersFromSet:
             [NSCharacterSet illegalCharacterSet] intoString:&link]) {
            self.currentBookObject.link = link;
        }
        
        
    }
    
    else if ([elementName isEqualToString:kTitleElementName] || [elementName isEqualToString:kDescriptionElementName]) {
        
        NSScanner *scanner = [NSScanner scannerWithString:self.currentParsedCharacterData];
        
        NSMutableString *description = nil;
        if ([scanner scanUpToCharactersFromSet:
             [NSCharacterSet illegalCharacterSet] intoString:&description]) {
            self.currentBookObject.description = description;
        }
        
    }
    
    else if ([elementName isEqualToString:kGuideElementName]) {
        
        ignoreElement = YES;
        
    }
    
    // Stop accumulating parsed character data. We won't start again until specific elements begin.
    _accumulatingParsedCharacterData = NO;
}

/**
 This method is called by the parser when it find parsed character data ("PCDATA") in an element. The parser is not guaranteed to deliver all of the parsed character data for an element in a single invocation, so it is necessary to accumulate character data until the end of the element is reached.
 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (_accumulatingParsedCharacterData) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        //
        [self.currentParsedCharacterData appendString:string];
    }
}

/**
 An error occurred while parsing the earthquake data: post the error as an NSNotification to our app delegate.
 */
- (void)handleEarthquakesError:(NSError *)parseError {
    
    assert([NSThread isMainThread]);
    [[NSNotificationCenter defaultCenter] postNotificationName:kBooksErrorNotificationName object:self userInfo:@{kBooksMessageErrorKey: parseError}];
}

/**
 An error occurred while parsing the earthquake data, pass the error to the main thread for handling.
 (Note: don't report an error if we aborted the parse due to a max limit of earthquakes.)
 */
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    if ([parseError code] != NSXMLParserDelegateAbortedParseError && !_didAbortParsing) {
        [self performSelectorOnMainThread:@selector(handleEarthquakesError:) withObject:parseError waitUntilDone:NO];
    }
}


@end