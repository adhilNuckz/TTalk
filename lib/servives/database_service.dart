import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ttalk/models/user_profile.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference? _usersCollectionReference;

  DatabaseService() {
    _setupCollectionReference();
  }

  void _setupCollectionReference() {
    _usersCollectionReference = _firebaseFirestore
        .collection('users')
        .withConverter<UserProfile>(
            fromFirestore: (snapshots, _) => UserProfile.fromJson(snapshots.data()!),
            toFirestore: (UserProfile, _) => UserProfile.toJson());
  }


  Future<void> createUserProfile(UserProfile userProfile) async {
    try {
      await _usersCollectionReference?.doc(userProfile.uid).set(userProfile);
    } catch (e) {
      print("Error creating user profile: $e");
    }
  }



  
 }
