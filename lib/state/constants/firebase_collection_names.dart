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
  static const landlord = 'LandLord';
  static const passco = 'pass_codes';
  static const seens = 'seenby';
  static const agentAct = 'agentsActivity';
  static const agentrefi = "agentRefId";
  static const spaces = 'space_renter';

  static const cart = 'carts';
  const FirebaseCollectionName._();
}
