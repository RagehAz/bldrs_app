import 'package:bldrs/ambassadors/database/db_bzz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dumz.dart';

FlyerModel geebFlyerByFlyerID(String flyerID){
  FlyerModel flyer = dbFlyers?.singleWhere((f) => f.flyerID == flyerID, orElse: ()=>null);
  return flyer;
}

List<FlyerModel> geebAllFlyers(){
  return dbFlyers;
}

final List<FlyerModel> dbFlyers = [

  /// flyerID: 'f001',
  FlyerModel(
    flyerID: 'f001',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: ['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u01',
    bzID: 'pp1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f001',
        slideID: 's001',
        slideIndex: 0,
        picture: Dumz.XXbuilds_1,
        headline: 'For Sale',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f001',
        slideID: 's002',
        slideIndex: 1,
        picture: Dumz.XXbuilds_2,
        headline: 'Contact us directly',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f001',
        slideID: 's003',
        slideIndex: 2,
        picture: Dumz.XXbuilds_3,
        headline: 'Variety of potential investments',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f002',
  FlyerModel(
    flyerID: 'f002',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: ['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u01',
    bzID: 'pp1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f002',
        slideID: 's004',
        slideIndex: 0,
        picture: Dumz.XXeast_1,
        headline: 'Sodic East',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f002',
        slideID: 's005',
        slideIndex: 1,
        picture: Dumz.XXeast_2,
        headline: 'Sodic West',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f002',
        slideID: 's006',
        slideIndex: 2,
        picture: Dumz.XXeast_3,
        headline: 'Sodic North',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f002',
        slideID: 's007',
        slideIndex: 3,
        picture: Dumz.XXeast_4,
        headline: 'Sodic South',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f003',
  FlyerModel(
    flyerID: 'f003',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: ['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u02',
    bzID: 'pp2',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f003',
        slideID: 's008',
        slideIndex: 0,
        picture: Dumz.XXamwaj_1,
        headline: 'Amwaj',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f003',
        slideID: 's009',
        slideIndex: 1,
        picture: Dumz.XXamwaj_2,
        headline: 'Sidi',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f003',
        slideID: 's010',
        slideIndex: 2,
        picture: Dumz.XXamwaj_3,
        headline: 'Abdel Rahman',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f004',
  FlyerModel(
    flyerID: 'f004',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: ['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u03',
    bzID: 'pp3',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f004',
        slideID: 's011',
        slideIndex: 0,
        picture: Dumz.XXburj_khalifa_1,
        headline: 'Burj Khalifa',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f004',
        slideID: 's012',
        slideIndex: 1,
        picture: Dumz.XXburj_khalifa_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f004',
        slideID: 's013',
        slideIndex: 2,
        picture: Dumz.XXburj_khalifa_3,
        headline: 'A little bit more expensive that you can afford, just a little bit',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f005',
  FlyerModel(
    flyerID: 'f005',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: ['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u03',
    bzID: 'pp3',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f005',
        slideID: 's014',
        slideIndex: 0,
        picture: Dumz.XXmivida_1,
        headline: 'Villa twin house with garden view',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f005',
        slideID: 's015',
        slideIndex: 1,
        picture: Dumz.XXmivida_2,
        headline: 'Directly accessible from the main gate',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f005',
        slideID: 's016',
        slideIndex: 2,
        picture: Dumz.XXmivida_3,
        headline: '20 minutes from the nearest water tap',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f005',
        slideID: 's017',
        slideIndex: 3,
        picture: Dumz.XXmivida_4,
        headline: 'call us NOW',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f006',
  FlyerModel(
    flyerID: 'f006',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: ['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u04',
    bzID: 'br1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f006',
        slideID: 's018',
        slideIndex: 0,
        picture: Dumz.XXabohassan_1,
        headline: 'SwanLake NorthCoast',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f006',
        slideID: 's019',
        slideIndex: 1,
        picture: Dumz.XXabohassan_2,
        headline: 'Twin Houses on 250 sq.m',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f006',
        slideID: 's020',
        slideIndex: 2,
        picture: Dumz.XXabohassan_3,
        headline: 'Crystal Lagoon',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f007',
  FlyerModel(
    flyerID: 'f007',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: ['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u20',
    bzID: 'br1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f007',
        slideID: 's021',
        slideIndex: 0,
        picture: Dumz.XXnazly_1,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f007',
        slideID: 's022',
        slideIndex: 1,
        picture: Dumz.XXnazly_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f007',
        slideID: 's023',
        slideIndex: 2,
        picture: Dumz.XXnazly_3,
        headline: 'Contact us now',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f008',
  FlyerModel(
    flyerID: 'f008',
    // -------------------------
    flyerType: FlyerType.Project,
    flyerState: FlyerState.Published,
    keyWords: ['Construction', 'Office', 'Decoration', 'Interior finishing'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u05',
    bzID: 'cn1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f008',
        slideID: 's024',
        slideIndex: 0,
        picture: Dumz.XXzah_1,
        headline: 'جميع أنواع المقاولات',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f008',
        slideID: 's025',
        slideIndex: 1,
        picture: Dumz.XXzah_2,
        headline: 'نحن نتميز عن الآخرين',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f009',
  FlyerModel(
    flyerID: 'f009',
    // -------------------------
    flyerType: FlyerType.Project,
    flyerState: FlyerState.Published,
    keyWords: ['Construction', 'Office', 'Decoration', 'Interior finishing'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u06',
    bzID: 'cn2',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f009',
        slideID: 's026',
        slideIndex: 0,
        picture: Dumz.XXeng_1,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f010',
  FlyerModel(
    flyerID: 'f010',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: ['Wall Paint', 'Ceiling Paint',],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u07',
    bzID: 'mn1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f010',
        slideID: 's027',
        slideIndex: 0,
        picture: Dumz.XXorgento,
        headline: 'Oreganto Paint',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f011',
  FlyerModel(
    flyerID: 'f011',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: ['Wall Paint', 'Ceiling Paint',],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u07',
    bzID: 'mn1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f011',
        slideID: 's028',
        slideIndex: 0,
        picture: Dumz.XXorgento,
        headline: 'Si-Tone 700, for all purposes',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f012',
  FlyerModel(
    flyerID: 'f012',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: ['Wall Paint', 'Ceiling Paint',],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u08',
    bzID: 'mn2',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f012',
        slideID: 's029',
        slideIndex: 0,
        picture: Dumz.XXfenomastic_1,
        headline: 'Fentomastic paint',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f012',
        slideID: 's030',
        slideIndex: 1,
        picture: Dumz.XXfenomastic_2,
        headline: 'Fentomastic paint',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f013',
  FlyerModel(
    flyerID: 'f013',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: ['Home Accessories', 'Charger',],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u09',
    bzID: 'mn3',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f013',
        slideID: 's031',
        slideIndex: 0,
        picture: Dumz.XXcharger_1,
        headline: 'Ikea Creative Charger',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f013',
        slideID: 's032',
        slideIndex: 1,
        picture: Dumz.XXcharger_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f013',
        slideID: 's033',
        slideIndex: 2,
        picture: Dumz.XXcharger_3,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f013',
        slideID: 's034',
        slideIndex: 3,
        picture: Dumz.XXcharger_4,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f014',
  FlyerModel(
    flyerID: 'f014',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: ['Home Accessories', 'rack', 'shelf'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u09',
    bzID: 'mn3',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f014',
        slideID: 's035',
        slideIndex: 0,
        picture: Dumz.XXrack_1,
        headline: 'Ikea Medium Rack',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f014',
        slideID: 's036',
        slideIndex: 1,
        picture: Dumz.XXrack_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f014',
        slideID: 's037',
        slideIndex: 2,
        picture: Dumz.XXrack_3,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f014',
        slideID: 's038',
        slideIndex: 3,
        picture: Dumz.XXrack_4,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f014',
        slideID: 's039',
        slideIndex: 4,
        picture: Dumz.XXrack_5,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f015',
  FlyerModel(
    flyerID: 'f015',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: ['Furniture', 'Chair', 'Living room', 'office'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u09',
    bzID: 'mn3',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f015',
        slideID: 's040',
        slideIndex: 0,
        picture: Dumz.XXchair_1,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f015',
        slideID: 's041',
        slideIndex: 1,
        picture: Dumz.XXchair_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f015',
        slideID: 's042',
        slideIndex: 2,
        picture: Dumz.XXchair_3,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f015',
        slideID: 's043',
        slideIndex: 3,
        picture: Dumz.XXchair_4,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f016',
  FlyerModel(
    flyerID: 'f016',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: ['Furniture', 'Chair', 'Living room', 'office'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u09',
    bzID: 'mn3',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f016',
        slideID: 's044',
        slideIndex: 0,
        picture: Dumz.XXch_1,
        headline: 'Ikea Chair, 60 x 60 Cm',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f016',
        slideID: 's045',
        slideIndex: 1,
        picture: Dumz.XXch_2,
        headline: 'Synthetic natural hybrid fabric',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f016',
        slideID: 's046',
        slideIndex: 2,
        picture: Dumz.XXch_3,
        headline: 'Authentic aesthetic design',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f016',
        slideID: 's047',
        slideIndex: 3,
        picture: Dumz.XXch_4,
        headline: 'Peach Pine Burl Grey Woord',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f017',
  FlyerModel(
    flyerID: 'f017',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: ['Electrical accessory', 'electrical switch'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u10',
    bzID: 'mn4',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f017',
        slideID: 's048',
        slideIndex: 0,
        picture: Dumz.XXswitch_1,
        headline: 'Bticino Original Switch',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f017',
        slideID: 's049',
        slideIndex: 1,
        picture: Dumz.XXswitch_2,
        headline: 'Many Colors Available',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f017',
        slideID: 's050',
        slideIndex: 2,
        picture: Dumz.XXswitch_3,
        headline: 'Standard size switches',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f018',
  FlyerModel(
    flyerID: 'f018',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: ['Window', 'door'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u12',
    bzID: 'sp1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f018',
        slideID: 's051',
        slideIndex: 0,
        picture: Dumz.XXwindow_1,
        headline: 'Window and door',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f018',
        slideID: 's052',
        slideIndex: 1,
        picture: Dumz.XXwindow_2,
        headline: 'Window and door',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f019',
  FlyerModel(
    flyerID: 'f019',
    // -------------------------
    flyerType: FlyerType.Equipment,
    flyerState: FlyerState.Published,
    keyWords: ['Construction Machinery', 'Tractor'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u11',
    bzID: 'mn5',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f019',
        slideID: 's053',
        slideIndex: 0,
        picture: Dumz.XXcat_1,
        headline: 'ِA Loader',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f019',
        slideID: 's054',
        slideIndex: 1,
        picture: Dumz.XXcat_2,
        headline: 'One of a Kind',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f020',
  FlyerModel(
    flyerID: 'f020',
    // -------------------------
    flyerType: FlyerType.Equipment,
    flyerState: FlyerState.Published,
    keyWords: ['Construction Machinery', 'Tractor', 'crane', 'helicopter'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u11',
    bzID: 'mn5',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f020',
        slideID: 's055',
        slideIndex: 0,
        picture: Dumz.XXmachine_1,
        headline: 'ِHeavy Construction Machinery',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f020',
        slideID: 's056',
        slideIndex: 1,
        picture: Dumz.XXmachine_2,
        headline: 'ِHeavy Construction Machinery',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f020',
        slideID: 's057',
        slideIndex: 2,
        picture: Dumz.XXmachine_3,
        headline: 'ِHeavy Construction Machinery',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f021',
  FlyerModel(
    flyerID: 'f021',
    // -------------------------
    flyerType: FlyerType.Equipment,
    flyerState: FlyerState.Published,
    keyWords: ['Power tool', 'power saw'],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u13',
    bzID: 'sp2',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f021',
        slideID: 's058',
        slideIndex: 0,
        picture: Dumz.XXpower_1,
        headline: 'ِDrill Drill Drill',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f021',
        slideID: 's059',
        slideIndex: 1,
        picture: Dumz.XXpower_2,
        headline: 'ِDrill Drill Drill',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f022',
  FlyerModel(
    flyerID: 'f022',
    // -------------------------
    flyerType: FlyerType.Equipment,
    flyerState: FlyerState.Published,
    keyWords: ['Construction generator', 'power generator',],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u13',
    bzID: 'sp2',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f022',
        slideID: 's060',
        slideIndex: 0,
        picture: Dumz.XXgenerator_1,
        headline: 'ِمولد كهرباء للإيجار',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f023',
  FlyerModel(
    flyerID: 'f023',
    // -------------------------
    flyerType: FlyerType.Equipment,
    flyerState: FlyerState.Published,
    keyWords: ['Construction Machinery', 'loader',],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u14',
    bzID: 'sp3',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f023',
        slideID: 's061',
        slideIndex: 0,
        picture: Dumz.XXloader_1,
        headline: 'ِاتصل بنا',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f023',
        slideID: 's062',
        slideIndex: 1,
        picture: Dumz.XXloader_2,
        headline: 'ِلدينا تشكيلة منكاملة من المعدات و أدوات الموقع',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f024',
  FlyerModel(
    flyerID: 'f024',
    // -------------------------
    flyerType: FlyerType.Design,
    flyerState: FlyerState.Published,
    keyWords: ['Interior Design', 'Decor', 'Modern Desing', 'landscape design'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u15',
    bzID: 'dr1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f024',
        slideID: 's063',
        slideIndex: 0,
        picture: Dumz.XXm_1,
        headline: 'Villa Katamiya',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f024',
        slideID: 's064',
        slideIndex: 1,
        picture: Dumz.XXm_2,
        headline: 'Design & Build',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f025',
  FlyerModel(
    flyerID: 'f025',
    // -------------------------
    flyerType: FlyerType.Design,
    flyerState: FlyerState.Published,
    keyWords: ['Interior Design', 'Decor', 'Modern Desing', 'landscape design'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u15',
    bzID: 'dr1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f025',
        slideID: 's065',
        slideIndex: 0,
        picture: Dumz.XXoffice_1,
        headline: 'Office Design',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f025',
        slideID: 's066',
        slideIndex: 1,
        picture: Dumz.XXoffice_2,
        headline: 'Office Design',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f025',
        slideID: 's067',
        slideIndex: 2,
        picture: Dumz.XXoffice_3,
        headline: 'Office Design',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f025',
        slideID: 's068',
        slideIndex: 3,
        picture: Dumz.XXoffice_4,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f026',
  FlyerModel(
    flyerID: 'f026',
    // -------------------------
    flyerType: FlyerType.Design,
    flyerState: FlyerState.Published,
    keyWords: ['Interior Design', 'Decor', 'Modern Design', 'landscape design'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u15',
    bzID: 'dr1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f026',
        slideID: 's069',
        slideIndex: 0,
        picture: Dumz.XXp_1,
        headline: 'Pool Side life',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f026',
        slideID: 's070',
        slideIndex: 1,
        picture: Dumz.XXp_2,
        headline: 'Morning Vibe',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f026',
        slideID: 's071',
        slideIndex: 2,
        picture: Dumz.XXp_3,
        headline: 'Morning Shower Redesigned',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f027',
  FlyerModel(
    flyerID: 'f027',
    // -------------------------
    flyerType: FlyerType.Design,
    flyerState: FlyerState.Published,
    keyWords: ['Architecture Design', 'Decor', 'Modern Design', 'landscape design'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u16',
    bzID: 'dr2',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f027',
        slideID: 's072',
        slideIndex: 0,
        picture: Dumz.XXhsi_1,
        headline: 'HSI HQ in NewCairo',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f027',
        slideID: 's073',
        slideIndex: 1,
        picture: Dumz.XXhsi_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f027',
        slideID: 's074',
        slideIndex: 2,
        picture: Dumz.XXhsi_3,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f028',
  FlyerModel(
    flyerID: 'f028',
    // -------------------------
    flyerType: FlyerType.Design,
    flyerState: FlyerState.Published,
    keyWords: ['Interior Design', 'Decor', 'Modern Design', 'landscape design', 'pool design'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u16',
    bzID: 'dr2',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f028',
        slideID: 's075',
        slideIndex: 0,
        picture: Dumz.XXalleg_1,
        headline: 'Allegria Villa 350 sq.m of Absolute Beauty',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f028',
        slideID: 's076',
        slideIndex: 1,
        picture: Dumz.XXalleg_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f028',
        slideID: 's077',
        slideIndex: 2,
        picture: Dumz.XXalleg_3,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f029',
  FlyerModel(
    flyerID: 'f029',
    // -------------------------
    flyerType: FlyerType.Design,
    flyerState: FlyerState.Published,
    keyWords: ['Interior Design', 'Decor', 'Classic Design', 'landscape design'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u16',
    bzID: 'dr2',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f029',
        slideID: 's078',
        slideIndex: 0,
        picture: Dumz.XXrec_1,
        headline: 'Reception Design',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f029',
        slideID: 's079',
        slideIndex: 1,
        picture: Dumz.XXrec_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f029',
        slideID: 's080',
        slideIndex: 2,
        picture: Dumz.XXrec_3,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f030',
  FlyerModel(
    flyerID: 'f030',
    // -------------------------
    flyerType: FlyerType.Design,
    flyerState: FlyerState.Published,
    keyWords: ['Interior Design', 'Decor', 'Bedroom', 'Dining table', 'reception', 'beig'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u17',
    bzID: 'dr3',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f030',
        slideID: 's081',
        slideIndex: 0,
        picture: Dumz.XXek_1,
        headline: 'Bedroom',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f030',
        slideID: 's082',
        slideIndex: 1,
        picture: Dumz.XXek_2,
        headline: 'Dining Room',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f031',
  FlyerModel(
    flyerID: 'f031',
    // -------------------------
    flyerType: FlyerType.Product,
    flyerState: FlyerState.Published,
    keyWords: ['Furniture design', 'table', 'chair', 'bed', 'home accessories',],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u17',
    bzID: 'dr3',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f031',
        slideID: 's083',
        slideIndex: 0,
        picture: Dumz.XXe_1,
        headline: 'Eklego Furniture',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f031',
        slideID: 's084',
        slideIndex: 1,
        picture: Dumz.XXe_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f031',
        slideID: 's085',
        slideIndex: 2,
        picture: Dumz.XXe_3,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f032',
  FlyerModel(
    flyerID: 'f032',
    // -------------------------
    flyerType: FlyerType.Craft,
    flyerState: FlyerState.Published,
    keyWords: ['Home finishing', 'electricity', 'plumbing', 'Air conditioner', 'home appliance maintenance',],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u18',
    bzID: 'ar1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f032',
        slideID: 's086',
        slideIndex: 0,
        picture: Dumz.XXfixawy_1,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f033',
  FlyerModel(
    flyerID: 'f033',
    // -------------------------
    flyerType: FlyerType.Craft,
    flyerState: FlyerState.Published,
    keyWords: ['Craft', 'Carpenter', 'Bed', 'Wardrobe',],
    flyerShowsAuthor: false,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u19',
    bzID: 'ar2',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f033',
        slideID: 's087',
        slideIndex: 0,
        picture: Dumz.XXahmad_1,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f033',
        slideID: 's088',
        slideIndex: 1,
        picture: Dumz.XXahmad_2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f034',
  FlyerModel(
    flyerID: 'f034',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: ['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u20',
    bzID: 'br1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f034',
        slideID: 's089',
        slideIndex: 0,
        picture: Iconz.DumSlide1,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f034',
        slideID: 's090',
        slideIndex: 1,
        picture: Iconz.DumSlide2,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f034',
        slideID: 's091',
        slideIndex: 2,
        picture: Iconz.DumSlide3,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f035',
  FlyerModel(
    flyerID: 'f035',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: ['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u21',
    bzID: 'br1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f035',
        slideID: 's092',
        slideIndex:0,
        picture: Iconz.DumSlide7,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f035',
        slideID: 's097',
        slideIndex: 1,
        picture: Iconz.DumUniverse,
        headline: 'KAWAKEB',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f036',
  FlyerModel(
    flyerID: 'f036',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: ['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u21',
    bzID: 'br1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f036',
        slideID: 's093',
        slideIndex: 0,
        picture: Iconz.DumSlide4,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f037',
  FlyerModel(
    flyerID: 'f037',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: ['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u04',
    bzID: 'br1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f037',
        slideID: 's094',
        slideIndex: 0,
        picture: Iconz.DumSlide6,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

  /// flyerID: 'f038',
  FlyerModel(
    flyerID: 'f038',
    // -------------------------
    flyerType: FlyerType.Property,
    flyerState: FlyerState.Published,
    keyWords: ['Property', 'for Sale', 'Compound', 'New Cairo'],
    flyerShowsAuthor: true,
    flyerURL: 'www.bldrs.net',
    // -------------------------
    authorID: 'u20',
    bzID: 'br1',
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: GeoPoint(0,0),
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: <SlideModel>[
      SlideModel(
        flyerID: 'f038',
        slideID: 's095',
        slideIndex: 0,
        picture: Iconz.DumUniverse,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
      SlideModel(
        flyerID: 'f038',
        slideID: 's096',
        slideIndex: 1,
        picture: Iconz.DumSlide5,
        headline: '',
        description: '',
        sharesCount: 100,
        viewsCount: 1000,
        savesCount: 10000,
        callsCount: 1000000,
      ),
    ],
  ),

];
