import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_journey/features/job_seeker/models/job_seeker_model.dart';

class JobSeekerDbServiec {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // final collgeId = FirebaseAuth.instance.currentUser == null ? '' : FirebaseAuth.instance.currentUser!.uid;

  Future<JobSeekerModel?> addJobSeeker({required JobSeekerModel user}) async {
    try {
      var doc = await _db.collection('JobSeekers').add(user.toJson());

      final addedJob = user.copyWith(id: doc.id);

      return addedJob;
    } catch (e) {
      print('catche errororororo$e');
      return null;
    }
  }

  Future<bool> updateJobSeeker({required JobSeekerModel user}) async {
    try {
      _db.collection('JobSeekers').doc(user.id).update(user.toJson());

      return true;
    } catch (e) {
      print('catche errororororo$e');
      return false;
    }
  }
}
