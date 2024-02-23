import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseCollectionName {
  static const thumbnails = 'thumbnails';
  static const feedback = 'feedback';
  static const views = 'views'; //changed from likes
  static const posts = 'posts';
  static const users = 'users';
  static const payments = 'payments';
  static const agentsform = 'agentsform';
  static const reciepts = 'reciepts';
  static const verified = 'Verified_Agents';
  static const verifyad = 'Verified_admin';
  static const tenantReg = 'Tenants';
  static const landLordReg = 'LandLords';

  static const passco = 'pass_codes';

  static const cart = 'carts';
  const FirebaseCollectionName._();
}
