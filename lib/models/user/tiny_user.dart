import 'package:bldrs/controllers/theme/dumz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/user/user_model.dart';
// -----------------------------------------------------------------------------
class TinyUser {
  final String userID;
  final String name;
  final String title;
  final dynamic pic;
  final UserStatus userStatus;
  final String email;
  final String phone;

  TinyUser({
    this.userID,
    this.name,
    this.title,
    this.pic,
    this.userStatus,
    this.email,
    this.phone,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'userID' : userID,
      'name' : name,
      'title' : title,
      'pic' : pic,
      'userStatus' : UserModel.cipherUserStatus(userStatus),
      'email' : email,
      'phone' : phone,
    };
  }
// -----------------------------------------------------------------------------
  TinyUser clone(){
    return TinyUser(
      userID: userID,
      name: name,
      title: title,
      pic: pic,
      userStatus: userStatus,
      email: email,
      phone: phone,
    );
  }
// -----------------------------------------------------------------------------
  static TinyUser decipherTinyUserMap(Map<String, dynamic> map){
    TinyUser _tinyUser;

    if(map != null){
      _tinyUser = TinyUser(
        userID: map['userID'],
        name: map['name'],
        title: map['title'],
        pic: map['pic'],
        userStatus: UserModel.decipherUserStatus(map['userStatus']),
        email: map['email'],
        phone: map['phone'],
      );
    }

    return _tinyUser;
  }
// -----------------------------------------------------------------------------
  static TinyUser getTinyUserFromUserModel(UserModel userModel){
    return TinyUser(
        userID: userModel.userID,
        name: userModel.name,
        title: userModel.title,
        pic: userModel.pic,
        userStatus: userModel.userStatus,
        email: ContactModel.getAContactValueFromContacts(userModel.contacts, ContactType.Email),
        phone: ContactModel.getAContactValueFromContacts(userModel.contacts, ContactType.Phone),
    );
  }
// -----------------------------------------------------------------------------
  static TinyUser getTinyAuthorFromAuthorModel(AuthorModel author){
    return TinyUser(
      userID: author.userID,
      name: author.authorName,
      title: author.authorTitle,
      pic: author.authorPic,
      userStatus: UserStatus.BzAuthor,
      email: ContactModel.getAContactValueFromContacts(author.authorContacts, ContactType.Email),
      phone: ContactModel.getAContactValueFromContacts(author.authorContacts, ContactType.Phone),
    );
  }
// -----------------------------------------------------------------------------
  static TinyUser getTinyAuthorFromBzModel({BzModel bzModel, String authorID}){
    AuthorModel _author = bzModel.bzAuthors.singleWhere((au) => au.userID == authorID, orElse: ()=> null);
    TinyUser _tinyAuthor = getTinyAuthorFromAuthorModel(_author);
    return _tinyAuthor;
  }
// -----------------------------------------------------------------------------
  static bool tinyUsersAreTheSame({UserModel finalUserModel, UserModel originalUserModel}){
    bool _tinyUsersAreTheSame;

    if (originalUserModel.name == finalUserModel.name
        &&
        originalUserModel.title == finalUserModel.title
        &&
        originalUserModel.pic == finalUserModel.pic
        &&
        originalUserModel.userStatus == finalUserModel.userStatus
    ){

      _tinyUsersAreTheSame = true;

    } else {

      _tinyUsersAreTheSame = false;

    }

    return _tinyUsersAreTheSame;
  }
// -----------------------------------------------------------------------------
  static TinyUser dummyTinyUser(){
    return
      TinyUser(
        userID: 'a77a',
        name: 'User fucking name',
        title: 'super fucking user title',
        pic: Iconz.DumAuthorPic,
        email: 'fuckyou@hotmail.com',
        phone: '1234567',
        userStatus: UserStatus.Building,
      );
  }
// -----------------------------------------------------------------------------
  static List<TinyUser> dummyTinyUsers(){

    final List<TinyUser> _users = <TinyUser>[
      TinyUser(
        name: 'Ahmad Ali',
        pic: Iconz.DumAuthorPic,
        userID: '1',
        title: '',
      ),
      TinyUser(
        name: 'Morgan Darwish',
        pic: Dumz.XXabohassan_author,
        userID: '2',
        title: '',
      ),
      TinyUser(
        name: 'Zahi Fayez',
        pic: Dumz.XXzah_author,
        userID: '3',
        title: '',
      ),
      TinyUser(
        name: 'Hani Wani',
        pic: Dumz.XXhs_author,
        userID: '4',
        title: '',
      ),
      TinyUser(
        name: 'Nada Mohsen',
        pic: Dumz.XXmhdh_author,
        userID: '5',
        title: '',
      ),

    ];


    return _users;
  }
// -----------------------------------------------------------------------------
}
