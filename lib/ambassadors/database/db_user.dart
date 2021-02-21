import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dumz.dart';

UserModel geebUserByUserID(String userID){
  UserModel user = dbUsers?.singleWhere((u) => u.userID == userID, orElse: ()=>null);
  return user;
}

final List<UserModel> dbUsers = [

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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
  ),

  /// userID: 'u08',
  UserModel(
    userID: 'u08',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Micheal Morad',
    pic: Iconz.DumBzPNG,
    title: 'Marketting manager',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
  ),

  /// userID: 'u09',
  UserModel(
    userID: 'u09',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Micheal Morad',
    pic: Iconz.DumBzPNG,
    title: 'Marketing executive',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
  ),

  /// userID: 'u11',
  UserModel(
    userID: 'u11',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'DavuserID Watson',
    // joinedAt: ,
    pic: Iconz.DumBzPNG,
    gender: Gender.male,
    province: 'London',
    area: '12n',
    title: 'Manager',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
    country: 'UK',
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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
  ),

  /// userID: 'u19',
  UserModel(
    userID: 'u19',
    // joinedAt: ,
    userStatus: UserStatus.Normal,
    // -------------------------
    name: 'Ahmad Hamada Ahmad',
    pic: Iconz.DumBzPNG,
    title: 'PresuserIDent',
    gender: Gender.male,
    country: 'Egypt',
    province: 'Cairo',
    area: '12',
    language: 'English',
    position: GeoPoint(10,10),
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
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
    contacts: [
      ContactModel(contact: '01065014107', contactType: ContactType.Phone),
      ContactModel(contact: 'www.tiktok.com', contactType: ContactType.Facebook),
      ContactModel(contact: 'rageh.az@gmail.com', contactType: ContactType.Email),
    ],
    // -------------------------
    savedFlyersIDs: ['f001', 'f002'],
    followedBzzIDs: ['pp1', 'pp2', 'br1'],
  ),

];