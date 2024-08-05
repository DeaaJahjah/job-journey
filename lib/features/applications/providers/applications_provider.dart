import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/features/job_seeker/models/job_seeker_model.dart';

class ApplicationsProvider with ChangeNotifier {
  List<JobSeekerModel> applications = [];
  DataState dataState = DataState.notSet;

  void listenToApplications({required String jobId}) {
    FirebaseFirestore.instance.collection('/jobs/$jobId/applications').orderBy('created_at').snapshots().listen(
        onError: (e) {
          dataState = DataState.failure;
          notifyListeners();
        },
        onDone: () {},
        (event) {
          final applications = event.docs.map((snapshot) => JobSeekerModel.fromFirestore(snapshot)).toList();
          this.applications = applications;
          dataState = DataState.done;
          notifyListeners();
        });
  }
}
