library real;
// -----------------------------------------------------------------------------
import 'dart:async';
import 'dart:convert';
import 'package:animators/animators.dart';
import 'package:filers/filers.dart';
import 'package:fire/fire.dart' show PaginationController;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';
// -----------------------------------------------------------------------------
part 'src/methods/real_http.dart';
part 'src/methods/real_methods.dart';
part 'src/models/real_query_model.dart';
part 'src/widgets/real_coll_paginator.dart';
part 'src/widgets/real_coll_streamer.dart';
part 'src/widgets/real_doc_streamer.dart';
// -----------------------------------------------------------------------------
