import 'package:flutter/foundation.dart';

// dv - pp (property flyer - property source flyer)
// br - pp (property flyer)
// mn - pd (product flyer - product source flyer)
// sp - pd (product flyer)
// dr - ds (design flyer)
// cn - pj (project flyer)
// ar - cr (craft flyer)

class AuthorModel{
  final String userID;
  final String bzId;
  final String authorID;

  AuthorModel({
    @required this.bzId,
    @required this.userID,
    @required this.authorID,
});
}