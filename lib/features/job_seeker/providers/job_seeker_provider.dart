import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/features/company/models/category.dart';
import 'package:job_journey/features/job_seeker/models/job_seeker_model.dart';
import 'package:job_journey/features/job_seeker/services/job_seeker_db_serviec.dart';

class JobSeekerProvider with ChangeNotifier {
  DataState dataState = DataState.notSet;

  JobSeekerModel? jobSeekerModel;
  Future<void> addJobSeeker({required JobSeekerModel user}) async {
    dataState = DataState.loading;
    notifyListeners();
    await JobSeekerDbServiec().addJobSeeker(user: user);
    dataState = DataState.done;
    notifyListeners();
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

  Future<void> getJobSeeker({required String userId}) async {
    dataState = DataState.loading;
    notifyListeners();
    final result = await JobSeekerDbServiec().getJobSeeker(userId: userId);
    if (result == null) {
      dataState = DataState.failure;
      notifyListeners();
    } else {
      jobSeekerModel = result;
      print('jobSeekerModel ${jobSeekerModel!.toJson()}');
      dataState = DataState.done;
      notifyListeners();
    }
  }

  Future<void> updateTopicsSubscription({required String seekerId, required List<Category> topicsSubscription}) async {
    dataState = DataState.loading;
    notifyListeners();
    final result = await JobSeekerDbServiec().updateTopicsSubscription(
      seekerId: jobSeekerModel!.id!,
      topicsSubscription: topicsSubscription,
    );
    if (result == null) {
      jobSeekerModel = jobSeekerModel?.copyWith(topicsSubscription: topicsSubscription);
      dataState = DataState.done;
    } else {
      dataState = DataState.failure;
    }
    notifyListeners();
  }
}
