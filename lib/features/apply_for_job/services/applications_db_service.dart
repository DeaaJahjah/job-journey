import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_journey/features/job_seeker/models/job_seeker_model.dart';

class ApplicationsDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> sendApplication({required JobSeekerModel applicationInfo, required String jobId}) async {
    try {
      await _db.collection('jobs').doc(jobId).collection('applications').add(applicationInfo.toJson());

      return true;
    } catch (e) {
      print('catche errororororo$e');
      return false;
    }
  }
}
