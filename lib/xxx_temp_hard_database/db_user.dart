import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'db_bzz.dart';
import 'dumz.dart';
// -----------------------------------------------------------------------------
UserModel geebUserByUserID(String userID){
  UserModel user = dbUsers?.singleWhere((u) => u.userID == userID, orElse: ()=>null);
  return user;
}
// -----------------------------------------------------------------------------
TinyUser geebTinyUserByUserID(String userID){
  UserModel _userModel = geebUserByUserID(userID);
  TinyUser _tinyUser = TinyUser(
      userID: _userModel.userID,
      name: _userModel.name,
      title: _userModel.title,
      pic: _userModel.pic,
      userStatus: _userModel.userStatus,
      contact: getAContactValueFromContacts(_userModel.contacts, ContactType.Phone),
  );
  return _tinyUser;
}
// -----------------------------------------------------------------------------
final List<UserModel> dbUsers = <UserModel>[

  /// userID: 'u01',
  UserModel(
    userID: 'u01',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Ahmad Gamal',
    pic: Iconz.DumBzPNG,
    title: 'Author',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['pp1'],
  ),

  /// userID: 'u02',
  UserModel(
    userID: 'u02',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Ibrahim Mohsen',
    pic: Iconz.DumBzPNG,
    title: 'Author',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['pp2'],
  ),

  /// userID: 'u03',
  UserModel(
    userID: 'u03',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'James Wallberg Jr.',
    pic: Dumz.XXburj_khalifa_author,
    title: 'Business development Manager',
    gender: Gender.male,
    country: 'UAE',
    province: 'Dubai',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['pp3'],
  ),

  /// userID: 'u04',
  UserModel(
    userID: 'u04',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Mahmoud Abou El Hassan',
    pic: Dumz.XXabohassan_author,
    title: 'Real Estate Consultant',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['br1'],
  ),

  /// userID: 'u05',
  UserModel(
    userID: 'u05',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'محمد احمد زهران',
    pic: Dumz.XXzah_author,
    title: 'CEO',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['cn1'],
  ),

  /// userID: 'u06',
  UserModel(
    userID: 'u06',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Eng. Mohamed Attia',
    pic: Iconz.DumBzPNG,
    title: 'Engineer',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['cn2'],
  ),

  /// userID: 'u07',
  UserModel(
    userID: 'u07',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'George Zenhom',
    pic: Iconz.DumBzPNG,
    title: 'Manager',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['mn1'],
  ),

  /// userID: 'u08',
  UserModel(
    userID: 'u08',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Micheal Morad',
    pic: Iconz.DumBzPNG,
    title: 'Marketing manager',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['mn2'],
  ),

  /// userID: 'u09',
  UserModel(
    userID: 'u09',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'John Cena',
    pic: Iconz.DumBzPNG,
    title: 'Marketing executive',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['mn3'],
  ),

  /// userID: 'u10',
  UserModel(
    userID: 'u10',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Alaa btcino',
    pic: Iconz.DumBzPNG,
    title: 'Manager',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['mn4'],
  ),

  /// userID: 'u11',
  UserModel(
    userID: 'u11',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'David Watson',
    // joinedAt: ,
    pic: Iconz.DumBzPNG,
    gender: Gender.male,
    country: 'UK',
    province: 'London',
    area: '12n',
    title: 'Manager',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['mn5'],
  ),

  /// userID: 'u12',
  UserModel(
    userID: 'u12',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Essam Alamonya',
    pic: Iconz.DumBzPNG,
    title: 'Modeer',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['sp1'],
  ),

  /// userID: 'u13',
  UserModel(
    userID: 'u13',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Sayyed rady',
    pic: Iconz.DumBzPNG,
    title: 'Boss',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['sp2'],
  ),

  /// userID: 'u14',
  UserModel(
    userID: 'u14',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Shady mohamed',
    pic: Iconz.DumBzPNG,
    title: 'Engineer',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['sp3'],
  ),

  /// userID: 'u15',
  UserModel(
    userID: 'u15',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Mona Hussein',
    pic: Dumz.XXmhdh_author,
    title: 'Founder & CEO',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['dr1'],
  ),

  /// userID: 'u16',
  UserModel(
    userID: 'u16',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Hany Saad',
    pic: Dumz.XXhs_author,
    title: 'Founder & CEO',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['dr2'],
  ),

  /// userID: 'u17',
  UserModel(
    userID: 'u17',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Hayam Hendi',
    pic: Iconz.DumBzPNG,
    title: 'Office Manager',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['dr3'],
  ),

  /// userID: 'u18',
  UserModel(
    userID: 'u18',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Fixawy team',
    pic: Iconz.DumBzPNG,
    title: 'Media Team',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['ar1'],
  ),

  /// userID: 'u19',
  UserModel(
    userID: 'u19',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Ahmad Hamada Ahmad',
    pic: Iconz.DumBzPNG,
    title: 'President',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['ar2'],
  ),

  /// userID: 'u20',
  UserModel(
    userID: 'u20',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Nazly Noman EL Mohammady',
    pic: Dumz.XXnazly_author,
    title: 'Real Estate Agent',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['br1'],
  ),

  /// userID: 'u21',
  UserModel(
    userID: 'u21',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Rageh El Azzazy',
    pic: Iconz.DumAuthorPic,
    title: 'Founder & CEO',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: dummyContacts,
    // -------------------------
    myBzzIDs: <String>['br1'],
  ),

];