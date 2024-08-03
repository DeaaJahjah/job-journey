import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/features/job_seeker/models/job_seeker_model.dart';
import 'package:job_journey/features/job_seeker/services/job_seeker_db_serviec.dart';

class JobSeekerProvider with ChangeNotifier {
  DataState dataState = DataState.notSet;

  Future<void> addJobSeeker({required JobSeekerModel user}) async {
    dataState = DataState.loading;
    notifyListeners();
    final jobs = await JobSeekerDbServiec().addJobSeeker(user: user);
    if (jobs == null) {
      dataState = DataState.failure;
      notifyListeners();
    } else {
      dataState = DataState.done;
      notifyListeners();
    }
  }

  Future<void> updateJobSeeker({required JobSeekerModel user}) async {
    dataState = DataState.loading;
    notifyListeners();
    final result = await JobSeekerDbServiec().updateJobSeeker(user: user);
    if (!result) {
      dataState = DataState.failure;
      notifyListeners();
    } else {
      dataState = DataState.done;
      notifyListeners();
    }
  }
}
