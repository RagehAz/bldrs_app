import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dumz.dart';
// -----------------------------------------------------------------------------
BzModel geebBzByBzID(String bzID){
  BzModel bz = dbBzz?.singleWhere((u) => u.bzID == bzID, orElse: ()=>null);
  return bz;
}
// -----------------------------------------------------------------------------
AuthorModel geebAuthorByAuthorID(String authorID){
  AuthorModel author = new AuthorModel();
  dbBzz.forEach((bz) {
    bz.bzAuthors.forEach((au) {
      if(au.userID == authorID){
        au = author;
      }
    });
  });
  return author;
}
// -----------------------------------------------------------------------------
List<BzModel> geebAllBzz(){
  return dbBzz;
}
// -----------------------------------------------------------------------------
List<TinyBz> geebAllTinyBzz(){
  List<TinyBz> _tinyBzz = new List();

  dbBzz.forEach((bz) {
    _tinyBzz.add(
      TinyBz(
          bzID: bz.bzID,
          bzLogo: bz.bzLogo,
          bzName: bz.bzName,
          bzType: bz.bzType
      ),
    );
  });

  return _tinyBzz;
}
// -----------------------------------------------------------------------------
List<ContactModel> dummyContacts = <ContactModel>[
  ContactModel(contact: '01065014107', contactType: ContactType.Phone),
  ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
  ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
];
// -----------------------------------------------------------------------------
final List<BzModel> dbBzz =
<BzModel>[

// --- mn1
  BzModel(
    bzID: 'mn1',
    // -------------------------
    bzType: BzType.Manufacturer,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'Sipes paints',
    bzLogo: Dumz.XXsipes_logo,
    bzScope: 'Wall paints' 'Floor paints' 'Ceiling Paints' 'Outdoor paints' 'Paint add-ons' 'Paint chemicals',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'Sipes provides a wide variety of paint, paint chemicals and more\nWe have been leadin the market since 1992 with our technologically chemically advanced paints which withstands moist air vacuum and space',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u07',
        authorName: 'George Zenhom',
        authorPic: Iconz.DumBzPNG,
        authorTitle: 'Manager',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Product ,flyerID: 'f010', authorID: 'u07', slideIndex: 0, slidePic: Dumz.XXorgento),
      TinyFlyer(flyerType: FlyerType.Product ,flyerID: 'f011', authorID: 'u07', slideIndex: 0, slidePic: Dumz.XXsi_1),
    ],
  ),

// --- mn2
  BzModel(
    bzID: 'mn2',
    // -------------------------
    bzType: BzType.Manufacturer,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'Jotun, Egypt',
    bzLogo: Dumz.XXjotun_logo,
    bzScope: 'Wall paints' 'Floor paints' 'Ceiling Paints' 'Outdoor paints' 'Paint add-ons' 'Paint chemicals',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'Jotun Paints, you heard of us, we paint the world with happiness',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u08',
        authorName: 'Micheal Morad',
        authorPic: Iconz.DumBzPNG,
        authorTitle: 'Marketing manager',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Product ,flyerID: 'f012', authorID: 'u08', slideIndex: 0, slidePic: Dumz.XXfenomastic_1),
    ],
  ),

// --- mn3
  BzModel(
    bzID: 'mn3',
    // -------------------------
    bzType: BzType.Manufacturer,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'Ikea, Egypt',
    bzLogo: Dumz.XXikea_logo,
    bzScope: 'Indoor furniture' 'Curtains' 'Outdoor furniture' 'KitchenWare' 'Office furniture' 'Kitchens' 'Kitchen Cabinets' 'Lighting fixtures' 'Wardrobes' 'fabrics' 'artificial plants' 'bathroom accessories' 'kitchen accessories',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'Ikea, Where great Ideas form great lives',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u09',
        authorName: 'John Cena',
        authorPic: Iconz.DumBzPNG,
        authorTitle: 'Marketing executive',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),

    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Product ,flyerID: 'f013', authorID: 'u09', slideIndex: 0, slidePic: Dumz.XXcharger_1),
      TinyFlyer(flyerType: FlyerType.Product ,flyerID: 'f014', authorID: 'u09', slideIndex: 0, slidePic: Dumz.XXrack_1),
      TinyFlyer(flyerType: FlyerType.Product ,flyerID: 'f015', authorID: 'u09', slideIndex: 0, slidePic: Dumz.XXchair_1),
      TinyFlyer(flyerType: FlyerType.Product ,flyerID: 'f016', authorID: 'u09', slideIndex: 0, slidePic: Dumz.XXch_1),
    ],
  ),

// --- mn4
  BzModel(
    bzID: 'mn4',
    // -------------------------
    bzType: BzType.Manufacturer,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'Bticino',
    bzLogo: Dumz.XXbticino_logo,
    bzScope: 'lighting accessories' 'lighting switches' 'environmentally friendly bulbs' 'more',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'bticino, don\'t just control light,, controls life',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u10',
        authorName: 'Alaa btcino',
        authorPic: Iconz.DumBzPNG,
        authorTitle: 'Manager',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Product ,flyerID: 'f017', authorID: 'u10', slideIndex: 0, slidePic: Dumz.XXswitch_1),
    ],
  ),

// --- mn5
  BzModel(
    bzID: 'mn5',
    // -------------------------
    bzType: BzType.Manufacturer,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'CAT',
    bzLogo: Dumz.XXcat_logo,
    bzScope: 'Loaders' 'Excavators' 'Earth levellers' 'Cranes' 'Signage' 'generators' 'safety clothing',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'CAT pioneered the heavy machinery in world war 2, and we have assisted in the elimination of the Nazi regime, then we help the world build',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u11',
        authorName: 'David Watson',
        authorPic: Iconz.DumBzPNG,
        authorTitle: 'Manager',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Equipment ,flyerID: 'f019', authorID: 'u11', slideIndex: 0, slidePic: Dumz.XXcat_1),
      TinyFlyer(flyerType: FlyerType.Equipment ,flyerID: 'f020', authorID: 'u11', slideIndex: 0, slidePic: Dumz.XXmachine_1),
    ],
  ),

// --- dv1
  BzModel(
    bzID: 'pp1',
    // -------------------------
    bzType: BzType.Developer,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'Sodic',
    bzLogo: Dumz.XXsodic_logo,
    bzScope: 'Real Estate Development , Facility Management',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'Soidc East, Sodic West, Sodic North, Sodic South, Sodic Center',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u01',
        authorName: 'Ahmad Gamal',
        authorPic: Iconz.DumBzPNG,
        authorTitle: 'Author',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: false,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Property ,flyerID: 'f001', authorID: 'u01', slideIndex: 0, slidePic: Dumz.XXbuilds_1),
      TinyFlyer(flyerType: FlyerType.Property ,flyerID: 'f002', authorID: 'u01', slideIndex: 0, slidePic: Dumz.XXeast_1),
    ],
  ),

// --- dv2
  BzModel(
    bzID: 'pp2',
    // -------------------------
    bzType: BzType.Developer,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'Sabbour developments',
    bzLogo: Dumz.XXsabbour_logo,
    bzScope: 'Real Estate Development' 'Facility Management',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'Sabbour Is the Greatest Egyptian real estate developer',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u02',
        authorName: 'Ibrahim Mohsen',
        authorPic: Iconz.DumBzPNG,
        authorTitle: 'Author',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: false,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Property ,flyerID: 'f003', authorID: 'u02', slideIndex: 0, slidePic: Dumz.XXamwaj_1),
    ],
  ),

// --- dv3
  BzModel(
    bzID: 'pp3',
    // -------------------------
    bzType: BzType.Developer,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'Emaar',
    bzLogo: Dumz.XXemaar_logo,
    bzScope: 'Interior design' 'Exterior design' 'Design & build' 'Landscape design' 'Furniture design' 'Booth design' 'Pool design' 'Kitchen Design' 'Furniture design' 'home accessories' 'bathroom accessories' 'mirrors' 'furniture' 'light fixtures',
    bzCountry: 'Egypt',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'Emaar is the middle east leading real estate developer',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u03',
        authorName: 'James Wallberg Jr.',
        authorPic: Dumz.XXburj_khalifa_author,
        authorTitle: 'Business development Manager',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Design ,flyerID: 'f004', authorID: 'u03', slideIndex: 0, slidePic: Dumz.XXburj_khalifa_1),
      TinyFlyer(flyerType: FlyerType.Design ,flyerID: 'f005', authorID: 'u03', slideIndex: 0, slidePic: Dumz.XXmivida_1),
    ],
  ),

// --- dr1
  BzModel(
    bzID: 'dr1',
    // -------------------------
    bzType: BzType.Designer,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'MHDH, Mona Hussein Design House',
    bzLogo: Dumz.XXmhdh_logo,
    bzScope: 'Interior design' 'Exterior design' 'Design & build' 'Landscape design' 'Furniture design' 'Booth design' 'Pool design' 'Kitchen Design' 'Furniture design' 'home accessories' 'bathroom accessories' 'mirrors' 'furniture' 'light fixtures',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'Mona Hussein with her eccentric aesthetic design philosophy transcends the meaning of decor into a rank of design persona for spaces which reflects the souls of our beloved customers',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u15',
        authorName: 'Mona Hussein',
        authorPic: Dumz.XXmhdh_author,
        authorTitle: 'Founder & CEO',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Design ,flyerID: 'f024', authorID: 'u15', slideIndex: 0, slidePic: Dumz.XXm_1),
      TinyFlyer(flyerType: FlyerType.Design ,flyerID: 'f025', authorID: 'u15', slideIndex: 0, slidePic: Dumz.XXoffice_1),
      TinyFlyer(flyerType: FlyerType.Design ,flyerID: 'f026', authorID: 'u15', slideIndex: 0, slidePic: Dumz.XXp_1),
    ],
  ),

// --- dr2
  BzModel(
    bzID: 'dr2',
    // -------------------------
    bzType: BzType.Designer,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'HSI . Hany Saad Innovations',
    bzLogo: Dumz.XXhs_logo,
    bzScope: 'Interior design' 'Exterior design' 'Design & build' 'Landscape design' 'Furniture design' 'Booth design' 'Pool design' 'Kitchen Design' 'Furniture design' 'home accessories' 'bathroom accessories' 'mirrors' 'furniture' 'light fixtures',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'Hany Saad Innovations is the award winning design studio of the internation prize of interior innovation & design',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u16',
        authorName: 'Hany Saad',
        authorPic: Dumz.XXhs_author,
        authorTitle: 'Founder & CEO',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 5481243,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Design ,flyerID: 'f027', authorID: 'u16', slideIndex: 0, slidePic: Dumz.XXhsi_1),
      TinyFlyer(flyerType: FlyerType.Design ,flyerID: 'f028', authorID: 'u16', slideIndex: 0, slidePic: Dumz.XXalleg_1),
      TinyFlyer(flyerType: FlyerType.Design ,flyerID: 'f029', authorID: 'u16', slideIndex: 0, slidePic: Dumz.XXrec_1),
    ],
  ),

// --- dr2
  BzModel(
    bzID: 'dr3',
    // -------------------------
    bzType: BzType.Designer,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'Eklego',
    bzLogo: Dumz.XXeklego_logo,
    bzScope: 'Interior design' 'Exterior design' 'Design & build' 'Landscape design' 'Furniture design' 'Booth design' 'Pool design' 'Kitchen Design' 'Furniture design' 'home accessories' 'bathroom accessories' 'mirrors' 'furniture' 'light fixtures',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'Eklego focuses on remoling life with art, and when art meets engineering, a new realm of architecture, interior design & furniture design emerges, Eklego has been in the market since 1901, and has built a countless amount of spaces and built a termendous amount of projects ever since',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u17',
        authorName: 'Hayam Hendi',
        authorPic: Iconz.DumBzPNG,
        authorTitle: 'Office Manager',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Design ,flyerID: 'f030', authorID: 'u17', slideIndex: 0, slidePic: Dumz.XXek_1),
      TinyFlyer(flyerType: FlyerType.Design ,flyerID: 'f031', authorID: 'u17', slideIndex: 0, slidePic: Dumz.XXe_1),
    ],
  ),

// --- cn1
  BzModel(
    bzID: 'cn1',
    // -------------------------
    bzType: BzType.Contractor,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'Zahran Contracting',
    bzLogo: Dumz.XXzahran_logo,
    bzScope: 'Contractor' 'Home Builder' 'Interior Finishing' 'Pool building' 'Construction management' 'Construction planning',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'زهران لجميع بنود المقاولات، مقاولات عامة ، مقاولات خرسانة، و متوفر جديم المعدات و العمالة بأنسب الأسعار',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u05',
        authorName: 'محمد احمد زهران',
        authorPic: Dumz.XXzah_author,
        authorTitle: 'CEO',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Project ,flyerID: 'f008', authorID: 'u05', slideIndex: 0, slidePic: Dumz.XXzah_1),
    ],
  ),

// --- cn2
  BzModel(
    bzID: 'cn2',
    // -------------------------
    bzType: BzType.Contractor,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'مكتب المهندس للمقاولات العامة',
    bzLogo: Dumz.XXeng_logo,
    bzScope: 'Contractor' 'Home Builder' 'Interior Finishing' 'Construction management' 'Construction planning',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'زهران لجميع بنود المقاولات، مقاولات عامة ، مقاولات خرسانة',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u06',
        authorName: 'Eng. Mohamed Attia',
        authorPic: Iconz.DumBzPNG,
        authorTitle: 'Engineer',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Project ,flyerID: 'f009', authorID: 'u06', slideIndex: 0, slidePic: Dumz.XXeng_1),
    ],
  ),

// --- br1
  BzModel(
    bzID: 'br1',
    // -------------------------
    bzType: BzType.Broker,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'Ultimate Real Estate',
    bzLogo: Dumz.XXultimate_logo,
    bzScope: 'Realestate brokerage' 'Realestate consultancy' ,
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'With a big variety of up-to-date inventory of realestate across Egypt, we Make sure all your requirements are properly met and the best decissions are made for best investments in the market',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u20',
        authorName: 'Nazly Noman EL Mohammady',
        authorPic: Dumz.XXnazly_author,
        authorTitle: 'Real Estate Agent',
        authorIsMaster: false,
        authorContacts: dummyContacts,
      ),
      AuthorModel(
        userID: 'u21',
        authorName: 'Rageh El Azzazy',
        authorPic: Dumz.DumAuthorPic,
        authorTitle: 'Founder & CEO',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
      AuthorModel(
        userID: 'u04',
        authorName: 'Mahmoud Abou El Hassan',
        authorPic: Dumz.XXabohassan_author,
        authorTitle: 'Real Estate Consultant',
        authorIsMaster: false,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Property ,flyerID: 'f007', authorID: 'u20', slideIndex: 0, slidePic: Dumz.XXnazly_1),
      TinyFlyer(flyerType: FlyerType.Property ,flyerID: 'f038', authorID: 'u20', slideIndex: 0, slidePic: Iconz.DumUniverse),
      TinyFlyer(flyerType: FlyerType.Property ,flyerID: 'f034', authorID: 'u20', slideIndex: 0, slidePic: Iconz.DumSlide1),
      TinyFlyer(flyerType: FlyerType.Property ,flyerID: 'f035', authorID: 'u21', slideIndex: 0, slidePic: Iconz.DumSlide7),
      TinyFlyer(flyerType: FlyerType.Property ,flyerID: 'f036', authorID: 'u21', slideIndex: 0, slidePic: Iconz.DumSlide4),
      TinyFlyer(flyerType: FlyerType.Property ,flyerID: 'f006', authorID: 'u04', slideIndex: 0, slidePic: Dumz.XXabohassan_1),
      TinyFlyer(flyerType: FlyerType.Property ,flyerID: 'f037', authorID: 'u04', slideIndex: 0, slidePic: Iconz.DumSlide6),
    ],
  ),

// --- sp1
  BzModel(
    bzID: 'sp1',
    // -------------------------
    bzType: BzType.Supplier,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'Mohamed Ali for All Alumital windows & doors',
    bzLogo: Dumz.XXalumital_logo,
    bzScope: 'doors' 'windows' 'skylights',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'visit us, we are always here, we make good windows, and best doors in country 01554555107',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u12',
        authorName: 'Essam Alamonya',
        authorPic: Iconz.DumBzPNG,
        authorTitle: 'Modeer',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Product ,flyerID: 'f018', authorID: 'u12', slideIndex: 0, slidePic: Dumz.XXwindow_1),
    ],
  ),

// --- sp2
  BzModel(
    bzID: 'sp2',
    // -------------------------
    bzType: BzType.Supplier,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'Powerezza for powerfull power tools',
    bzLogo: Dumz.XXpower_logo,
    bzScope: 'power tools' 'hand tools' 'heavy equipment',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'contact us, we deliver anywhere in cairo,  اتصل بنا ، نحن هنا دائما',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u13',
        authorName: 'Sayyed rady',
        authorPic: Iconz.DumBzPNG,
        authorTitle: 'Boss',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Equipment ,flyerID: 'f021', authorID: 'u13', slideIndex: 0, slidePic: Dumz.XXpower_1),
      TinyFlyer(flyerType: FlyerType.Equipment ,flyerID: 'f022', authorID: 'u13', slideIndex: 0, slidePic: Dumz.XXgenerator_1),
    ],
  ),

// --- sp3
  BzModel(
    bzID: 'sp3',
    // -------------------------
    bzType: BzType.Supplier,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'علاء لوادر للوادر',
    bzLogo: Dumz.XXloader_logo,
    bzScope: 'Loader' 'Excavator' 'Crane' 'generators',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: '01554555107  اتصل بنا ، نحن هنا دائما',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u14',
        authorName: 'Shady mohamed',
        authorPic: Iconz.DumBzPNG,
        authorTitle: 'Engineer',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Equipment ,flyerID: 'f023', authorID: 'u14', slideIndex: 0, slidePic: Dumz.XXloader_1),
    ],
  ),

  // --- ar1
  BzModel(
    bzID: 'ar1',
    // -------------------------
    bzType: BzType.Artisan,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'Fixawy',
    bzLogo: Dumz.XXfixawy_logo,
    bzScope: 'Maintenance' 'Electricity maintenance' 'plumbing' 'Carpentering',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'Fixawy for home & office Maintenance',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u18',
        authorName: 'Fixawy team',
        authorPic: Iconz.DumBzPNG,
        authorTitle: 'Media Team',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Craft ,flyerID: 'f032', authorID: 'u18', slideIndex: 0, slidePic: Dumz.XXfixawy_1),
    ],
  ),

// --- ar2
  BzModel(
    bzID: 'ar2',
    // -------------------------
    bzType: BzType.Artisan,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'Ahmad for wood',
    bzLogo: Dumz.XXahmad_logo,
    bzScope: 'Carpentry',
    bzCountry: 'egy',
    bzProvince: 'Cairo',
    bzArea: '12',
    bzAbout: 'اتصلوا بنا 01554555107 لجميع أنواع الأساس الخشب و الكونتا والسراير و دوليب و كله.. نحن دايما في الخدمة',
    bzPosition: GeoPoint(10,10),
    bzContacts: dummyContacts,
    bzAuthors: <AuthorModel>[
      AuthorModel(
        userID: 'u19',
        authorName: 'Ahmad Hamada Ahmad',
        authorPic: Iconz.DumBzPNG,
        authorTitle: 'President',
        authorIsMaster: true,
        authorContacts: dummyContacts,
      ),
    ],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: true,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 1000,
    bzTotalSaves: 1000,
    bzTotalShares: 1000,
    bzTotalSlides: 1000,
    bzTotalViews: 100000,
    bzTotalCalls: 1000,
    // -------------------------
    bzFlyers: <TinyFlyer>[
      TinyFlyer(flyerType: FlyerType.Craft ,flyerID: 'f033', authorID: 'u19', slideIndex: 0, slidePic: Dumz.XXahmad_1),
    ],
  ),

];