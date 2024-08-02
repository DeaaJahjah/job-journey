import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_journey/features/company/models/company_model.dart';
import 'package:job_journey/features/company/models/job_model.dart';

class CompanyDbServiec {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final collgeId = FirebaseAuth.instance.currentUser == null ? '' : FirebaseAuth.instance.currentUser!.uid;

  Future<List<JobModel>?> getJobs() async {
    try {
      List<JobModel> jobs = [];
      var query =
          await _db.collection('jobs').where('company_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();

      print(query);
      for (var doc in query.docs) {
        jobs.add(JobModel.fromFirestore(doc));
      }
      return jobs;
    } on FirebaseException catch (_) {
      return null;
    }
  }

  Future<JobModel?> getJobDetails({required String jobId}) async {
    try {
      var query = await _db.doc('jobs/$jobId').get();

      print(query);

      final job = JobModel.fromFirestore(query);
      return job;
    } on FirebaseException catch (_) {
      return null;
    }
  }

  Future<JobModel?> addJob({required JobModel job}) async {
    try {
      var doc = await _db.collection('jobs').add(job.toJson());

      final addedJob = job.copyWith(id: doc.id);

      return addedJob;
    } catch (e) {
      print('catche errororororo$e');
      return null;
    }
  }

  Future<CompanyModel?> createCompany({required CompanyModel company}) async {
    try {
      var doc = await _db.collection('companies').add(company.toJson());

      final cc = company.copyWith(id: doc.id);

      return cc;
    } catch (e) {
      print('catche errororororo$e');
      return null;
    }
  }

  Future<bool> updateCompany({required CompanyModel company}) async {
    try {
      _db.collection('companies').doc(company.id).update(company.toJson());

      return true;
    } catch (e) {
      print('catche errororororo$e');
      return false;
    }
  }
}
