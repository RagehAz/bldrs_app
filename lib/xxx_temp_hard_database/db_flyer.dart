import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dumz.dart';
// -----------------------------------------------------------------------------
FlyerModel geebFlyerByFlyerID(String flyerID){
  FlyerModel flyer = dbFlyers?.singleWhere((f) => f.flyerID == flyerID, orElse: ()=>null);
  return flyer;
}
// -----------------------------------------------------------------------------
List<FlyerModel> geebAllFlyers(){
  return dbFlyers;
}
// -----------------------------------------------------------------------------
List<TinyFlyer> geebAllTinyFlyers(){
  List<TinyFlyer> _allTinyFlyers = new List();

  dbFlyers.forEach((flyer) {
    _allTinyFlyers.add(getTinyFlyerFromFlyerModel(flyer));
  });

  return _allTinyFlyers;
}
// -----------------------------------------------------------------------------

final List<FlyerModel> dbFlyers = <FlyerModel>[

  // flyerID: 'f001',
  FlyerModel(
    flyerID: 'f001',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: <String>['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u01',name: 'Ahmad Gamal',pic: Iconz.DumBzPNG,title: 'Author',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'pp1', bzLogo: Dumz.XXsodic_logo, bzName: 'Sodic', bzType: BzType.Developer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXbuilds_1,
        headline: 'For Sale',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXbuilds_2,
        headline: 'Contact us directly',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXbuilds_3,
        headline: 'Variety of potential investments',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f002',
  FlyerModel(
    flyerID: 'f002',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: <String>['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u01',name: 'Ahmad Gamal',pic: Iconz.DumBzPNG,title: 'Author',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'pp1', bzLogo: Dumz.XXsodic_logo, bzName: 'Sodic', bzType: BzType.Developer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXeast_1,
        headline: 'Sodic East',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXeast_2,
        headline: 'Sodic West',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXeast_3,
        headline: 'Sodic North',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 3,
        picture: Dumz.XXeast_4,
        headline: 'Sodic South',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f003',
  FlyerModel(
    flyerID: 'f003',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: <String>['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u02',name: 'Ibrahim Mohsen',pic: Iconz.DumBzPNG,title: 'Author',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'pp2', bzLogo: Dumz.XXsabbour_logo, bzName: 'Sabbour developments', bzType: BzType.Developer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXamwaj_1,
        headline: 'Amwaj',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXamwaj_2,
        headline: 'Sidi',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXamwaj_3,
        headline: 'Abdel Rahman',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f004',
  FlyerModel(
    flyerID: 'f004',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: <String>['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u03',name: 'James Wallberg Jr.',pic: Dumz.XXburj_khalifa_author,title: 'Business development Manager',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'pp3', bzLogo: Dumz.XXemaar_logo, bzName: 'Emaar', bzType: BzType.Developer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXburj_khalifa_1,
        headline: 'Burj Khalifa',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXburj_khalifa_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXburj_khalifa_3,
        headline: 'A little bit more expensive that you can afford, just a little bit',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f005',
  FlyerModel(
    flyerID: 'f005',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: <String>['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u03',name: 'James Wallberg Jr.',pic: Dumz.XXburj_khalifa_author,title: 'Business development Manager',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'pp3', bzLogo: Dumz.XXemaar_logo, bzName: 'Emaar', bzType: BzType.Developer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXmivida_1,
        headline: 'Villa twin house with garden view',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXmivida_2,
        headline: 'Directly accessible from the main gate',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXmivida_3,
        headline: '20 minutes from the nearest water tap',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 3,
        picture: Dumz.XXmivida_4,
        headline: 'call us NOW',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f006',
  FlyerModel(
    flyerID: 'f006',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: <String>['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u04',name: 'Mahmoud Abou El Hassan',pic: Dumz.XXabohassan_author,title: 'Real Estate Consultant',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'br1', bzLogo: Dumz.XXultimate_logo, bzName: 'Ultimate Real Estate', bzType: BzType.Broker),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXabohassan_1,
        headline: 'SwanLake NorthCoast',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXabohassan_2,
        headline: 'Twin Houses on 250 sq.m',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXabohassan_3,
        headline: 'Crystal Lagoon',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f007',
  FlyerModel(
    flyerID: 'f007',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: <String>['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u20',name: 'Nazly Noman EL Mohammady',pic: Dumz.XXnazly_author,title: 'Real Estate Agent',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'br1', bzLogo: Dumz.XXultimate_logo, bzName: 'Ultimate Real Estate', bzType: BzType.Broker),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXnazly_1,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXnazly_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXnazly_3,
        headline: 'Contact us now',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // /// flyerID: 'f008',
  FlyerModel(
    flyerID: 'f008',
    // -------------------------
    flyerType: FlyerType.Project,
    flyerState: FlyerState.Published,
    keyWords: <String>['Construction', 'Office', 'Decoration', 'Interior finishing'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u05',name: 'محمد احمد زهران',pic: Dumz.XXzah_author,title: 'CEO',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'cn1', bzLogo: Dumz.XXzahran_logo, bzName: 'Zahran Contracting', bzType: BzType.Contractor),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXzah_1,
        headline: 'جميع أنواع المقاولات',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXzah_2,
        headline: 'نحن نتميز عن الآخرين',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f009',
  FlyerModel(
    flyerID: 'f009',
    // -------------------------
    flyerType: FlyerType.Project,
    flyerState: FlyerState.Published,
    keyWords: <String>['Construction', 'Office', 'Decoration', 'Interior finishing'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u06',name: 'Eng. Mohamed Attia',pic: Iconz.DumBzPNG,title: 'Engineer',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'cn2', bzLogo: Dumz.XXeng_logo, bzName: 'مكتب المهندس للمقاولات العامة', bzType: BzType.Contractor),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        // flyerID: 'f009',
        // slideID: 's026',
        slideIndex: 0,
        picture: Dumz.XXeng_1,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f010',
  FlyerModel(
    flyerID: 'f010',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: <String>['Wall Paint', 'Ceiling Paint',],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u07',name: 'George Zenhom',pic: Iconz.DumBzPNG,title: 'Manager',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'mn1', bzLogo: Dumz.XXsipes_logo, bzName: 'Sipes paints', bzType: BzType.Manufacturer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXorgento,
        headline: 'Oreganto Paint',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f011',
  FlyerModel(
    flyerID: 'f011',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: <String>['Wall Paint', 'Ceiling Paint',],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u07',name: 'George Zenhom',pic: Iconz.DumBzPNG,title: 'Manager',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'mn1', bzLogo: Dumz.XXsipes_logo, bzName: 'Sipes paints', bzType: BzType.Manufacturer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXsi_1,
        headline: 'Si-Tone 700, for all purposes',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f012',
  FlyerModel(
    flyerID: 'f012',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: <String>['Wall Paint', 'Ceiling Paint',],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u08',name: 'Micheal Morad',pic: Iconz.DumBzPNG,title: 'Marketing manager',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'mn2', bzLogo: Dumz.XXjotun_logo, bzName: 'Jotun, Egypt', bzType: BzType.Manufacturer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXfenomastic_1,
        headline: 'Fentomastic paint',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXfenomastic_2,
        headline: 'Fentomastic paint',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f013',
  FlyerModel(
    flyerID: 'f013',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: <String>['Home Accessories', 'Charger',],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u09',name: 'John Cena',pic: Iconz.DumBzPNG,title: 'Marketing executive',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'mn3', bzLogo: Dumz.XXikea_logo, bzName: 'Ikea, Egypt', bzType: BzType.Manufacturer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXcharger_1,
        headline: 'Ikea Creative Charger',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXcharger_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXcharger_3,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 3,
        picture: Dumz.XXcharger_4,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f014',
  FlyerModel(
    flyerID: 'f014',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: <String>['Home Accessories', 'rack', 'shelf'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u09',name: 'John Cena',pic: Iconz.DumBzPNG,title: 'Marketing executive',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'mn3', bzLogo: Dumz.XXikea_logo, bzName: 'Ikea, Egypt', bzType: BzType.Manufacturer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXrack_1,
        headline: 'Ikea Medium Rack',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXrack_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXrack_3,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 3,
        picture: Dumz.XXrack_4,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 4,
        picture: Dumz.XXrack_5,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f015',
  FlyerModel(
    flyerID: 'f015',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: <String>['Furniture', 'Chair', 'Living room', 'office'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u09',name: 'John Cena',pic: Iconz.DumBzPNG,title: 'Marketing executive',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'mn3', bzLogo: Dumz.XXikea_logo, bzName: 'Ikea, Egypt', bzType: BzType.Manufacturer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXchair_1,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXchair_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXchair_3,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 3,
        picture: Dumz.XXchair_4,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f016',
  FlyerModel(
    flyerID: 'f016',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: <String>['Furniture', 'Chair', 'Living room', 'office'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u09',name: 'John Cena',pic: Iconz.DumBzPNG,title: 'Marketing executive',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'mn3', bzLogo: Dumz.XXikea_logo, bzName: 'Ikea, Egypt', bzType: BzType.Manufacturer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXch_1,
        headline: 'Ikea Chair, 60 x 60 Cm',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXch_2,
        headline: 'Synthetic natural hybrid fabric',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXch_3,
        headline: 'Authentic aesthetic design',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 3,
        picture: Dumz.XXch_4,
        headline: 'Peach Pine Burl Grey Woord',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f017',
  FlyerModel(
    flyerID: 'f017',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: <String>['Electrical accessory', 'electrical switch'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u10',name: 'Alaa btcino',pic: Iconz.DumBzPNG,title: 'Manager',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'mn4', bzLogo: Dumz.XXbticino_logo, bzName: 'Bticino', bzType: BzType.Manufacturer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXswitch_1,
        headline: 'Bticino Original Switch',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXswitch_2,
        headline: 'Many Colors Available',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXswitch_3,
        headline: 'Standard size switches',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f018',
  FlyerModel(
    flyerID: 'f018',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: <String>['Window', 'door'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u12',name: 'Essam Alamonya',pic: Iconz.DumBzPNG,title: 'Modeer',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'sp1', bzLogo: Dumz.XXalumital_logo, bzName: 'Mohamed Ali for All Alumital windows & doors', bzType: BzType.Supplier),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXwindow_1,
        headline: 'Window and door',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXwindow_2,
        headline: 'Window and door',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f019',
  FlyerModel(
    flyerID: 'f019',
    // -------------------------
    flyerType: FlyerType.Equipment,
    flyerState: FlyerState.Published,
    keyWords: <String>['Construction Machinery', 'Tractor'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u11',name: 'David Watson',pic: Iconz.DumBzPNG,title: 'Manager',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'mn5', bzLogo: Dumz.XXcat_logo, bzName: 'CAT', bzType: BzType.Manufacturer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXcat_1,
        headline: 'ِA Loader',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXcat_2,
        headline: 'One of a Kind',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f020',
  FlyerModel(
    flyerID: 'f020',
    // -------------------------
    flyerType: FlyerType.Equipment,
    flyerState: FlyerState.Published,
    keyWords: <String>['Construction Machinery', 'Tractor', 'crane', 'helicopter'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u11',name: 'David Watson',pic: Iconz.DumBzPNG,title: 'Manager',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'mn5', bzLogo: Dumz.XXcat_logo, bzName: 'CAT', bzType: BzType.Manufacturer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXmachine_1,
        headline: 'ِHeavy Construction Machinery',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXmachine_2,
        headline: 'ِHeavy Construction Machinery',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXmachine_3,
        headline: 'ِHeavy Construction Machinery',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f021',
  FlyerModel(
    flyerID: 'f021',
    // -------------------------
    flyerType: FlyerType.Equipment,
    flyerState: FlyerState.Published,
    keyWords: <String>['Power tool', 'power saw'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u13',name: 'Sayyed rady',pic: Iconz.DumBzPNG,title: 'Boss',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'sp2', bzLogo: Dumz.XXpower_logo, bzName: 'Powerezza for powerfull power tools', bzType: BzType.Supplier),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXpower_1,
        headline: 'ِDrill Drill Drill',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXpower_2,
        headline: 'ِDrill Drill Drill',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f022',
  FlyerModel(
    flyerID: 'f022',
    // -------------------------
    flyerType: FlyerType.Equipment,
    flyerState: FlyerState.Published,
    keyWords: <String>['Construction generator', 'power generator',],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u13',name: 'Sayyed rady',pic: Iconz.DumBzPNG,title: 'Boss',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'sp2', bzLogo: Dumz.XXpower_logo, bzName: 'Powerezza for powerfull power tools', bzType: BzType.Supplier),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXgenerator_1,
        headline: 'ِمولد كهرباء للإيجار',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f023',
  FlyerModel(
    flyerID: 'f023',
    // -------------------------
    flyerType: FlyerType.Equipment,
    flyerState: FlyerState.Published,
    keyWords: <String>['Construction Machinery', 'loader',],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u14',name: 'Shady mohamed',pic: Iconz.DumBzPNG,title: 'Engineer',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'sp3', bzLogo: Dumz.XXloader_logo, bzName: 'علاء لوادر للوادر', bzType: BzType.Supplier),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXloader_1,
        headline: 'ِاتصل بنا',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXloader_2,
        headline: 'ِلدينا تشكيلة منكاملة من المعدات و أدوات الموقع',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f024',
  FlyerModel(
    flyerID: 'f024',
    // -------------------------
    flyerType: FlyerType.Design,
    flyerState: FlyerState.Published,
    keyWords: <String>['Interior Design', 'Decor', 'Modern Desing', 'landscape design'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u15',name: 'Mona Hussein',pic: Dumz.XXmhdh_author,title: 'Founder & CEO',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'dr1', bzLogo: Dumz.XXmhdh_logo, bzName: 'MHDH, Mona Hussein Design House', bzType: BzType.Designer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXm_1,
        headline: 'Villa Katamiya',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXm_2,
        headline: 'Design & Build',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f025',
  FlyerModel(
    flyerID: 'f025',
    // -------------------------
    flyerType: FlyerType.Design,
    flyerState: FlyerState.Published,
    keyWords: <String>['Interior Design', 'Decor', 'Modern Desing', 'landscape design'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u15',name: 'Mona Hussein',pic: Dumz.XXmhdh_author,title: 'Founder & CEO',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'dr1', bzLogo: Dumz.XXmhdh_logo, bzName: 'MHDH, Mona Hussein Design House', bzType: BzType.Designer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXoffice_1,
        headline: 'Office Design',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXoffice_2,
        headline: 'Office Design',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXoffice_3,
        headline: 'Office Design',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 3,
        picture: Dumz.XXoffice_4,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f026',
  FlyerModel(
    flyerID: 'f026',
    // -------------------------
    flyerType: FlyerType.Design,
    flyerState: FlyerState.Published,
    keyWords: <String>['Interior Design', 'Decor', 'Modern Design', 'landscape design'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u15',name: 'Mona Hussein',pic: Dumz.XXmhdh_author,title: 'Founder & CEO',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'dr1', bzLogo: Dumz.XXmhdh_logo, bzName: 'MHDH, Mona Hussein Design House', bzType: BzType.Designer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXp_1,
        headline: 'Pool Side life',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXp_2,
        headline: 'Morning Vibe',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXp_3,
        headline: 'Morning Shower Redesigned',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f027',
  FlyerModel(
    flyerID: 'f027',
    // -------------------------
    flyerType: FlyerType.Design,
    flyerState: FlyerState.Published,
    keyWords: <String>['Architecture Design', 'Decor', 'Modern Design', 'landscape design'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u16',name: 'Hany Saad',pic: Dumz.XXhs_author,title: 'Founder & CEO',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'dr2', bzLogo: Dumz.XXhs_logo, bzName: 'HSI . Hany Saad Innovations', bzType: BzType.Designer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXhsi_1,
        headline: 'HSI HQ in NewCairo',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXhsi_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXhsi_3,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f028',
  FlyerModel(
    flyerID: 'f028',
    // -------------------------
    flyerType: FlyerType.Design,
    flyerState: FlyerState.Published,
    keyWords: <String>['Interior Design', 'Decor', 'Modern Design', 'landscape design', 'pool design'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u16',name: 'Hany Saad',pic: Dumz.XXhs_author,title: 'Founder & CEO',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'dr2', bzLogo: Dumz.XXhs_logo, bzName: 'HSI . Hany Saad Innovations', bzType: BzType.Designer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXalleg_1,
        headline: 'Allegria Villa 350 sq.m of Absolute Beauty',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXalleg_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXalleg_3,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f029',
  FlyerModel(
    flyerID: 'f029',
    // -------------------------
    flyerType: FlyerType.Design,
    flyerState: FlyerState.Published,
    keyWords: <String>['Interior Design', 'Decor', 'Classic Design', 'landscape design'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u16',name: 'Hany Saad',pic: Dumz.XXhs_author,title: 'Founder & CEO',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'dr2', bzLogo: Dumz.XXhs_logo, bzName: 'HSI . Hany Saad Innovations', bzType: BzType.Designer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXrec_1,
        headline: 'Reception Design',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXrec_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXrec_3,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f030',
  FlyerModel(
    flyerID: 'f030',
    // -------------------------
    flyerType: FlyerType.Design,
    flyerState: FlyerState.Published,
    keyWords: <String>['Interior Design', 'Decor', 'Bedroom', 'Dining table', 'reception', 'beig'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u17',name: 'Hayam Hendi',pic: Iconz.DumBzPNG,title: 'Office Manager',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'dr3', bzLogo: Dumz.XXeklego_logo, bzName: 'Eklego', bzType: BzType.Designer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXek_1,
        headline: 'Bedroom',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXek_2,
        headline: 'Dining Room',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f031',
  FlyerModel(
    flyerID: 'f031',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: <String>['Furniture design', 'table', 'chair', 'bed', 'home accessories',],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u17',name: 'Hayam Hendi',pic: Iconz.DumBzPNG,title: 'Office Manager',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'dr3', bzLogo: Dumz.XXeklego_logo, bzName: 'Eklego', bzType: BzType.Designer),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXe_1,
        headline: 'Eklego Furniture',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXe_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Dumz.XXe_3,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f032',
  FlyerModel(
    flyerID: 'f032',
    // -------------------------
    flyerType: FlyerType.Craft,
    flyerState: FlyerState.Published,
    keyWords: <String>['Home finishing', 'electricity', 'plumbing', 'Air conditioner', 'home appliance maintenance',],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u18',name: 'Fixawy team',pic: Iconz.DumBzPNG,title: 'Media Team',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'ar1', bzLogo: Dumz.XXfixawy_logo, bzName: 'Fixawy', bzType: BzType.Artisan),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXfixawy_1,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f033',
  FlyerModel(
    flyerID: 'f033',
    // -------------------------
    flyerType: FlyerType.Craft,
    flyerState: FlyerState.Published,
    keyWords: <String>['Craft', 'Carpenter', 'Bed', 'Wardrobe',],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u19',name: 'Ahmad Hamada Ahmad',pic: Iconz.DumBzPNG,title: 'President',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'ar2', bzLogo: Dumz.XXahmad_logo, bzName: 'Ahmad for wood', bzType: BzType.Artisan),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Dumz.XXahmad_1,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Dumz.XXahmad_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f034',
  FlyerModel(
    flyerID: 'f034',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: <String>['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u20',name: 'Nazly Noman EL Mohammady',pic: Dumz.XXnazly_author,title: 'Real Estate Agent',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'br1', bzLogo: Dumz.XXultimate_logo, bzName: 'Ultimate Real Estate', bzType: BzType.Broker),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Iconz.DumSlide1,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Iconz.DumSlide2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 2,
        picture: Iconz.DumSlide3,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f035',
  FlyerModel(
    flyerID: 'f035',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: <String>['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u21',name: 'Rageh El Azzazy',pic: Iconz.DumAuthorPic,title: 'Founder & CEO',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'br1', bzLogo: Dumz.XXultimate_logo, bzName: 'Ultimate Real Estate', bzType: BzType.Broker),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex:0,
        picture: Iconz.DumSlide7,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Iconz.DumUniverse,
        headline: 'KAWAKEB',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f036',
  FlyerModel(
    flyerID: 'f036',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: <String>['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u21',name: 'Rageh El Azzazy',pic: Iconz.DumAuthorPic,title: 'Founder & CEO',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'br1', bzLogo: Dumz.XXultimate_logo, bzName: 'Ultimate Real Estate', bzType: BzType.Broker),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Iconz.DumSlide4,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f037',
  FlyerModel(
    flyerID: 'f037',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: <String>['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u04',name: 'Mahmoud Abou El Hassan',pic: Dumz.XXabohassan_author,title: 'Real Estate Consultant',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'br1', bzLogo: Dumz.XXultimate_logo, bzName: 'Ultimate Real Estate', bzType: BzType.Broker),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Iconz.DumSlide6,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

  // flyerID: 'f038',
  FlyerModel(
    flyerID: 'f038',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: <String>['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    tinyAuthor: TinyUser(userID: 'u20',name: 'Nazly Noman EL Mohammady',pic: Dumz.XXnazly_author,title: 'Real Estate Agent',userStatus: UserStatus.BzAuthor),
    tinyBz: TinyBz(bzID: 'br1', bzLogo: Dumz.XXultimate_logo, bzName: 'Ultimate Real Estate', bzType: BzType.Broker),
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        slideIndex: 0,
        picture: Iconz.DumUniverse,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
      SlideModel(
        slideIndex: 1,
        picture: Iconz.DumSlide5,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
      ),
    ],
  ),

];
