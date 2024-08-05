// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:job_journey/features/job_seeker/models/job_seeker_model.dart';

// class ApplicationsDbService {
//   Stream<List<JobSeekerModel>?> getApplications({required String jobId}) async* {
//     List<JobSeekerModel> applications = [];
//     try {
//       FirebaseFirestore.instance.collection('/jobs/$jobId/applications').snapshots().listen(onError: (e) {
//         print("errorrrr $e");
//       }, onDone: () {
//         print('ddddddddddddddddone ');
//       }, (event) async* {
//         applications = event.docs.map((snapshot) => JobSeekerModel.fromFirestore(snapshot)).toList();
//         print('apps  $applications');
//       });
//       yield applications;
//     } catch (e) {
//       print("connection error $e");
//       yield null;
//     }
//   }
// }
