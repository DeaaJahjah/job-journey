import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/features/company/models/company_model.dart';
import 'package:job_journey/features/company/models/job_model.dart';
import 'package:job_journey/features/company/services/company_db_serviec.dart';

class CompanyProvider with ChangeNotifier {
  DataState dataState = DataState.notSet;
  List<JobModel> myJobs = [];
  JobModel? jobDetails;
  CompanyModel? profile;

  Future<void> getJobs() async {
    dataState = DataState.loading;
    notifyListeners();
    final jobs = await CompanyDbServiec().getJobs();
    if (jobs == null) {
      dataState = DataState.failure;
      notifyListeners();
    } else {
      myJobs = jobs;
      dataState = DataState.done;
      notifyListeners();
    }
  }

  Future<void> getJobDetails({required String jobId}) async {
    dataState = DataState.loading;
    notifyListeners();
    final job = await CompanyDbServiec().getJobDetails(jobId: jobId);
    if (job == null) {
      dataState = DataState.failure;
      notifyListeners();
    } else {
      jobDetails = job;
      dataState = DataState.done;
      notifyListeners();
    }
  }

  Future<void> addJob(JobModel job) async {
    dataState = DataState.loading;
    notifyListeners();
    final newJob = await CompanyDbServiec().addJob(job: job);
    if (newJob == null) {
      dataState = DataState.failure;
    } else {
      if (myJobs.isNotEmpty) {
        myJobs.insert(0, newJob);
      } else {
        myJobs.add(newJob);
      }
      dataState = DataState.done;
    }
    notifyListeners();
  }
}
