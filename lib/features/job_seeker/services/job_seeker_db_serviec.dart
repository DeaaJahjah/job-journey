import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_journey/features/job_seeker/models/job_seeker_model.dart';

class JobSeekerDbServiec {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // final collgeId = FirebaseAuth.instance.currentUser == null ? '' : FirebaseAuth.instance.currentUser!.uid;

  Future<bool> addJobSeeker({required JobSeekerModel user}) async {
    try {
      await _db.collection('JobSeekers').doc(user.id).set(user.toJson());

      return true;
    } catch (e) {
      print('catche errororororo$e');
      return false;
    }
  }

  Future<bool> updateJobSeeker({required JobSeekerModel user}) async {
    try {
      await _db.collection('JobSeekers').doc(user.id).update(user.toJson());

      return true;
    } catch (e) {
      print('catche errororororo$e');
      return false;
    }
  }

  Future<JobSeekerModel?> getJobSeeker({required userId}) async {
    print('userId: $userId');
    // try {
    var doc = await _db.collection('JobSeekers').doc(userId).get();

    return JobSeekerModel.fromFirestore(doc);
    // } catch (e) {
    //   print('catche errororororo$e');
    //   return null;
    // }
  }
}
