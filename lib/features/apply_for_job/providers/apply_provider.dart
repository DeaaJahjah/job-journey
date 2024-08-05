import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/features/apply_for_job/services/applications_db_service.dart';
import 'package:job_journey/features/job_seeker/models/job_seeker_model.dart';

class ApplayProvider with ChangeNotifier {
  DataState dataState = DataState.notSet;

  Future<void> sendApplication({required JobSeekerModel applicationInfo, required String jobId}) async {
    dataState = DataState.loading;
    notifyListeners();
    final result = await ApplicationsDbService().sendApplication(applicationInfo: applicationInfo, jobId: jobId);
    if (!result) {
      dataState = DataState.failure;
      notifyListeners();
    } else {
      dataState = DataState.done;
      notifyListeners();
    }
  }
}
