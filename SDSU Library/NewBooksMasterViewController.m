//
//  CallNumbersMasterViewController.m
//  SDSU Library
//
//  Created by Tyler Rogers on 5/5/13.
//
//

#import "NewBooksMasterViewController.h"

@interface NewBooksMasterViewController ()
@property (nonatomic, retain) NSArray *titleArray;
@end

@implementation NewBooksMasterViewController

@synthesize subLevel, titleArray;

// this is called when its tab is first tapped by the user
// table row constants for assigning cell titles
enum {
	kA = 0,
	kB,
    kC,
    kD,
    kE,
    kF,
    kG,
    kH,
    kI,
    kJ,
    kK,
    kL,
    kM,
    kN,
    kO,
    kP,
    kQ,
    kR,
    kS,
    kT,
    kU,
    kV,
    kW,
    kX,
    kY,
    kZ,
    kAA,
	kBB,
    kCC,
    kDD,
    kEE,
    kFF,
    kGG,
    kHH,
    kII,
    kJJ,
    kKK,
    kLL,
    kMM,
    kNN,
    kOO,
    kPP,
    kQQ,
    kRR,
    kSS,
    kTT,
    kUU,
    kVV,
    kWW,
    kXX,
    
};


- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.titleArray = [NSArray arrayWithObjects:@"Agriculture", @"Anthropology", @"Art", @"Asian & Pacific Studies", @"Astronomy", @"Biology", @"Business", @"Chemistry", @"Child & Family",@"Chinese, Japanese, Korean", @"Communication",@"Computer Science", @"Dance",@"Education", @"Engineering",@"French", @"Geography", @"Geology",@"German",@"Gov. Pubs. - California",@"Gov. Pubs. - USA",@"Health Sciences",@"History",@"Italian, Spanish, Portugese",@"Journalism",@"Juvenile",@"Library Science",@"Linguistics",@"Literature",@"Math",@"Middle Eastern Languages",@"Military Science",@"Music",@"Music Scores",@"Nutrition",@"P.E. & Recreation",@"Philosophy",@"Physics",@"Political Science",@"Psychology",@"Reference",@"Religion",@"Russian",@"Social Work",@"Sociology",@"Special Collections",@"T.V. & Film",@"Women",@"CDs",@"DVDs", nil];
    
    agriculture = [[Agriculture alloc] init];
    anthropology = [[Anthropology alloc] init];
    art = [[Art alloc] init];
    asiapacstud = [[AsiaPacStud alloc] init];
    astronomy = [[Astronomy alloc] init];
    biology = [[Biology alloc] init];
    business = [[Business alloc] init];
    chemistry = [[Chemistry alloc] init];
    childfamily = [[ChildFamily alloc] init];
    chijapkor = [[ChiJapKor alloc] init];
    comm = [[Comm alloc] init];
    compsci = [[CompSci alloc] init];
    dance = [[Dance alloc] init];
    education = [[Education alloc] init];
    engineering = [[Engineering alloc] init];
    french = [[French alloc] init];
    geography = [[Geography alloc] init];
    geology = [[Geology alloc] init];
    german = [[German alloc] init];
    govpubca = [[GovPubCA alloc] init];
    govpubusa = [[GovPubUSA alloc] init];
    healthsci = [[HealthSci alloc] init];
    history = [[History alloc] init];
    italspanport = [[ItalSpanPort alloc] init];
    journalism = [[Journalism alloc] init];
    juvenile = [[Juvenile alloc] init];
    libsci = [[LibSci alloc] init];
    linguistics = [[Linguistics alloc] init];
    literature = [[Literature alloc] init];
    math = [[Math alloc] init];
    mideastlang = [[MidEastLang alloc] init];
    milsci = [[MilSci alloc] init];
    music = [[Music alloc] init];
    musscores = [[MusScores alloc] init];
    nutrition = [[Nutrition alloc] init];
    physedrec = [[PhysEdRec alloc] init];
    philosophy = [[Philosophy alloc] init];
    physics = [[Physics alloc] init];
    polisci = [[PoliSci alloc] init];
    psychology = [[Psychology alloc] init];
    reference = [[Reference alloc] init];
    religion = [[Religion alloc] init];
    russian = [[Russian alloc] init];
    socialwork = [[SocialWork alloc] init];
    sociology = [[Sociology alloc] init];
    specialcoll = [[SpecialColl alloc] init];
    tvfilm = [[TvFilm alloc] init];
    women = [[Women alloc] init];
    cds = [[CDs alloc] init];
    dvds = [[DVDs alloc] init];

    
}

- (void)viewDidUnload
{
	[super viewDidUnload];
    
	self.titleArray = nil;
    
}



#pragma mark - AppDelegate methods

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	// this UIViewController is about to re-appear, make sure we remove the current selection in our table view
	NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
	[self.tableView deselectRowAtIndexPath:tableSelection animated:YES];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.titleArray count];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row]) {
        case kA:
            [self.navigationController pushViewController:agriculture animated:YES];
            break;
        case kB:
            [self.navigationController pushViewController:anthropology animated:YES];
            break;
        case kC:
            [self.navigationController pushViewController:art animated:YES];
            break;
        case kD:
            [self.navigationController pushViewController:asiapacstud animated:YES];
            break;
        case kE:
            [self.navigationController pushViewController:astronomy animated:YES];
            break;
        case kF:
            [self.navigationController pushViewController:biology animated:YES];
            break;
        case kG:
            [self.navigationController pushViewController:business animated:YES];
            break;
        case kH:
            [self.navigationController pushViewController:chemistry animated:YES];
            break;
        case kI:
            [self.navigationController pushViewController:childfamily animated:YES];
            break;
        case kJ:
            [self.navigationController pushViewController:chijapkor animated:YES];
            break;
        case kK:
            [self.navigationController pushViewController:comm animated:YES];
            break;
        case kL:
            [self.navigationController pushViewController:compsci animated:YES];
            break;
        case kM:
            [self.navigationController pushViewController:dance animated:YES];
            break;
        case kN:
            [self.navigationController pushViewController:education animated:YES];
            break;
        case kO:
            [self.navigationController pushViewController:engineering animated:YES];
            break;
        case kP:
            [self.navigationController pushViewController:french animated:YES];
            break;
        case kQ:
            [self.navigationController pushViewController:geography animated:YES];
            break;
        case kR:
            [self.navigationController pushViewController:geology animated:YES];
            break;
        case kS:
            [self.navigationController pushViewController:german animated:YES];
            break;
        case kT:
            [self.navigationController pushViewController:govpubca animated:YES];
            break;
        case kU:
            [self.navigationController pushViewController:govpubusa animated:YES];
            break;
        case kV:
            [self.navigationController pushViewController:healthsci animated:YES];
            break;
        case kW:
            [self.navigationController pushViewController:history animated:YES];
            break;
        case kX:
            [self.navigationController pushViewController:italspanport animated:YES];
            break;
        case kY:
            [self.navigationController pushViewController:journalism animated:YES];
            break;
        case kZ:
            [self.navigationController pushViewController:juvenile animated:YES];
            break;
        case kAA:
            [self.navigationController pushViewController:libsci animated:YES];
            break;
        case kBB:
            [self.navigationController pushViewController:linguistics animated:YES];
            break;
        case kCC:
            [self.navigationController pushViewController:literature animated:YES];
            break;
        case kDD:
            [self.navigationController pushViewController:math animated:YES];
            break;
        case kEE:
            [self.navigationController pushViewController:mideastlang animated:YES];
            break;
        case kFF:
            [self.navigationController pushViewController:milsci animated:YES];
            break;
        case kGG:
            [self.navigationController pushViewController:music animated:YES];
            break;
        case kHH:
            [self.navigationController pushViewController:musscores animated:YES];
            break;
        case kII:
            [self.navigationController pushViewController:nutrition animated:YES];
            break;
        case kJJ:
            [self.navigationController pushViewController:physedrec animated:YES];
            break;
        case kKK:
            [self.navigationController pushViewController:philosophy animated:YES];
            break;
        case kLL:
            [self.navigationController pushViewController:physics animated:YES];
            break;
        case kMM:
            [self.navigationController pushViewController:polisci animated:YES];
            break;
        case kNN:
            [self.navigationController pushViewController:psychology animated:YES];
            break;
        case kOO:
            [self.navigationController pushViewController:reference animated:YES];
            break;
        case kPP:
            [self.navigationController pushViewController:religion animated:YES];
            break;
        case kQQ:
            [self.navigationController pushViewController:russian animated:YES];
            break;
        case kRR:
            [self.navigationController pushViewController:socialwork animated:YES];
            break;
        case kSS:
            [self.navigationController pushViewController:sociology animated:YES];
            break;
        case kTT:
            [self.navigationController pushViewController:specialcoll animated:YES];
            break;
        case kUU:
            [self.navigationController pushViewController:tvfilm animated:YES];
            break;
        case kVV:
            [self.navigationController pushViewController:women animated:YES];
            break;
        case kWW:
            [self.navigationController pushViewController:cds animated:YES];
            break;
        case kXX:
            [self.navigationController pushViewController:dvds animated:YES];
            break;


    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"NewBooksView"]) {
        
        // Get reference to the destination view controller
        //  WeekView *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        // [vc setMyObjectHere:object];
        [segue.destinationViewController setTitle:@"New Books"];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kCellID = @"SubjectCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	}
    
	cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    
    
	return cell;
}





#pragma mark -
#pragma mark UIViewControllerRotation



@end