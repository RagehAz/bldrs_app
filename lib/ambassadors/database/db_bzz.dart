import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dumz.dart';

final List<BzModel> dbBzz =
[
// --- mn1
  BzModel(
    bzId: 'mn1',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'Sipes provides a wide variety of paint, paint chemicals and more\nWe have been leadin the market since 1992 with our technologically chemically advanced paints which withstands moist air vacuum and space',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u07', publishedFlyersIDs: ['f010', 'f011'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'sp2',],
    followIsOn: false,
  ),


// --- mn2
  BzModel(
    bzId: 'mn2',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'Jotun Paints, you heard of us, we paint the world with happiness',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u08', publishedFlyersIDs: ['f012'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'sp2',],
    followIsOn: false,
  ),


// --- mn3
  BzModel(
    bzId: 'mn3',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'Ikea, Where great Ideas form great lives',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u09', publishedFlyersIDs: ['f013','f014','f015','f016'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'sp2',],
    followIsOn: false,
  ),


// --- mn4
  BzModel(
    bzId: 'mn4',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'bticino, don\'t just control light,, controls life',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u10', publishedFlyersIDs: ['f017'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'sp2',],
    followIsOn: false,
  ),


// --- mn5
  BzModel(
    bzId: 'mn5',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'CAT pioneered the heavy machinery in world war 2, and we have assisted in the elimination of the Nazi regime, then we help the world build',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u11', publishedFlyersIDs: ['f019', 'f020'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'sp2',],
    followIsOn: false,
  ),


// --- dv1
  BzModel(
    bzId: 'pp1',
    // -------------------------
    bzType: BzType.Developer,
    bzForm: BzForm.Company,
    bldrBirth: DateTime.now(),
    accountType: BzAccountType.Default,
    bzURL: 'www.google.com',
    // -------------------------
    bzName: 'Sodic',
    bzLogo: Dumz.XXsodic_logo,
    bzScope: 'Real Estate Development' 'Facility Management',
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'Soidc East, Sodic West, Sodic North, Sodic South, Sodic Center',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u01', publishedFlyersIDs: ['f001', 'f002'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'sp2',],
    followIsOn: false,
  ),


// --- dv2
  BzModel(
    bzId: 'pp2',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'Sabbour Is the Greatest Egyptian real estate developer',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u02', publishedFlyersIDs: ['f003'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'sp2',],
    followIsOn: false,
  ),


// --- dv3
  BzModel(
    bzId: 'pp3',
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
    bzCountry: 'UAE',
    bzCity: 'Dubai',
    bzAbout: 'Emaar is the middle east leading real estate developer',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u03', publishedFlyersIDs: ['f004', 'f005'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'sp2',],
    followIsOn: false,
  ),


// --- dr1
  BzModel(
    bzId: 'dr1',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'Mona Hussein with her eccentric aesthetic design philosophy transcends the meaning of decor into a rank of design persona for spaces which reflects the souls of our beloved customers',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u15', publishedFlyersIDs: ['f024', 'f025','f026'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'sp2',],
    followIsOn: false,
  ),


// --- dr2
  BzModel(
    bzId: 'dr2',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'Hany Saad Innovations is the award winning design studio of the internation prize of interior innovation & design',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u16', publishedFlyersIDs: ['f027', 'f028', 'f029'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'sp2',],
    followIsOn: false,
  ),


// --- dr2
  BzModel(
    bzId: 'dr3',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'Eklego focuses on remoling life with art, and when art meets engineering, a new realm of architecture, interior design & furniture design emerges, Eklego has been in the market since 1901, and has built a countless amount of spaces and built a termendous amount of projects ever since',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u17', publishedFlyersIDs: ['f030', 'f031'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'sp2',],
    followIsOn: false,
  ),


// --- cn1
  BzModel(
    bzId: 'cn1',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'زهران لجميع بنود المقاولات، مقاولات عامة ، مقاولات خرسانة، و متوفر جديم المعدات و العمالة بأنسب الأسعار',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
      ContactModel(contactType: ContactType.Phone, contact: '0123456789'),
    ],
    authors: [
      AuthorModel(userID: 'u05', publishedFlyersIDs: ['f008'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'sp2',],
    followIsOn: false,
  ),


// --- cn2
  BzModel(
    bzId: 'cn2',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'زهران لجميع بنود المقاولات، مقاولات عامة ، مقاولات خرسانة',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u06', publishedFlyersIDs: ['f009'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'sp2',],
    followIsOn: false,
  ),


// --- br1
  BzModel(
    bzId: 'br1',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'With a big variety of up-to-date inventory of realestate across Egypt, we Make sure all your requirements are properly met and the best decissions are made for best investments in the market',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u20', publishedFlyersIDs: ['f007', 'f038', 'f034'],),
      AuthorModel(userID: 'u21', publishedFlyersIDs: ['f035', 'f036'],),
      AuthorModel(userID: 'u04', publishedFlyersIDs: ['f006', 'f037'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['pp1', 'sp1', 'sp2',],
    followIsOn: false,
  ),


// --- sp1
  BzModel(
    bzId: 'sp1',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'visit us, we are always here, we make good windows, and best doors in country 01554555107',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u12', publishedFlyersIDs: ['f018'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'pp1', 'sp2',],
    followIsOn: false,
  ),


// --- sp2
  BzModel(
    bzId: 'sp2',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'contact us, we deliver anywhere in cairo,  اتصل بنا ، نحن هنا دائما',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u13', publishedFlyersIDs: ['f021', 'f022'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'pp1',],
    followIsOn: false,
  ),


// --- sp3
  BzModel(
    bzId: 'sp3',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: '01554555107  اتصل بنا ، نحن هنا دائما',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u14', publishedFlyersIDs: ['f023'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'sp2',],
    followIsOn: false,
  ),


  // --- ar1
  BzModel(
    bzId: 'ar1',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'Fixawy for home & office Maintenance',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u18', publishedFlyersIDs: ['f032'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'sp2',],
    followIsOn: false,
  ),


// --- ar2
  BzModel(
    bzId: 'ar2',
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
    bzCountry: 'Egypt',
    bzCity: 'Cairo',
    bzAbout: 'اتصلوا بنا 01554555107 لجميع أنواع الأساس الخشب و الكونتا والسراير و دوليب و كله.. نحن دايما في الخدمة',
    bzPosition: GeoPoint(10,10),
    bzContacts: [
      ContactModel(contact: '01554555107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.facebook.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh-@hotmail.com', contactType: ContactType.Email),
    ],
    authors: [
      AuthorModel(userID: 'u19', publishedFlyersIDs: ['f033'],),
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
    bzTotalConnects: 1000,
    // -------------------------
    jointsBzzIDs: ['br1', 'sp1', 'sp2',],
    followIsOn: false,
  ),

];