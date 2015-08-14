//
//  NewBooksMasterViewController.h
//  SDSU Library
//
//  Created by Tyler Rogers on 5/20/13.
//  San Diego State University Library 
//
#import <UIKit/UIKit.h>
#import "Agriculture.h"
#import "Anthropology.h"
#import "Art.h"
#import "AsiaPacStud.h"
#import "Astronomy.h"
#import "Biology.h"
#import "Business.h"
#import "Chemistry.h"
#import "ChildFamily.h"
#import "ChiJapKor.h"
#import "Comm.h"
#import "CompSci.h"
#import "Dance.h"
#import "Education.h"
#import "Engineering.h"
#import "French.h"
#import "Geography.h"
#import "Geology.h"
#import "German.h"
#import "GovPubCA.h"
#import "GovPubUSA.h"
#import "HealthSci.h"
#import "History.h"
#import "ItalSpanPort.h"
#import "Journalism.h"
#import "Juvenile.h"
#import "LibSci.h"
#import "Linguistics.h"
#import "Literature.h"
#import "Math.h"
#import "MidEastLang.h"
#import "MilSci.h"
#import "Music.h"
#import "MusScores.h"
#import "Nutrition.h"
#import "PhysEdRec.h"
#import "Philosophy.h"
#import "Physics.h"
#import "PoliSci.h"
#import "Psychology.h"
#import "Reference.h"
#import "Religion.h"
#import "Russian.h"
#import "SocialWork.h"
#import "Sociology.h"
#import "SpecialColl.h"
#import "TvFilm.h"
#import "Women.h"
#import "CDs.h"
#import "DVDs.h"


@class NewBooksMasterViewController;


@interface NewBooksMasterViewController : UITableViewController
{
    Agriculture *agriculture;
    Anthropology *anthropology;
    Art *art;
    AsiaPacStud *asiapacstud;
    Astronomy *astronomy;
    Biology *biology;
    Business *business;
    Chemistry *chemistry;
    ChildFamily *childfamily;
    ChiJapKor *chijapkor;
    Comm *comm;
    CompSci *compsci;
    Dance *dance;
    Education *education;
    Engineering *engineering;
    French *french;
    Geography *geography;
    Geology *geology;
    German *german;
    GovPubCA *govpubca;
    GovPubUSA *govpubusa;
    HealthSci *healthsci;
    History *history;
    ItalSpanPort *italspanport;
    Journalism *journalism;
    Juvenile *juvenile;
    LibSci *libsci;
    Linguistics *linguistics;
    Literature *literature;
    Math *math;
    MidEastLang *mideastlang;
    MilSci *milsci;
    Music *music;
    MusScores *musscores;
    Nutrition *nutrition;
    PhysEdRec *physedrec;
    Philosophy *philosophy;
    Physics *physics;
    Psychology *psychology;
    PoliSci *polisci;
    Reference *reference;
    Religion *religion;
    Russian *russian;
    SocialWork *socialwork;
    Sociology *sociology;
    SpecialColl *specialcoll;
    TvFilm *tvfilm;
    Women *women;
    CDs *cds;
    DVDs *dvds;
    

    
    
}

@property (nonatomic, retain) IBOutlet NewBooksMasterViewController *subLevel;

@end
