import 'package:flutter/foundation.dart';

class User {
  @required
  final String firstName;
  @required
  final String lastName;
  @required
  final String academicStatus;
  @required
  final String institution;

  User({this.firstName, this.lastName, this.academicStatus, this.institution});
}
