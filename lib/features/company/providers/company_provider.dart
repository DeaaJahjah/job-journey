import 'package:flutter/material.dart';
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/features/company/models/company_model.dart';
import 'package:job_journey/features/company/models/job_model.dart';
import 'package:job_journey/features/company/services/company_db_service.dart';

class CompanyProvider with ChangeNotifier {
  DataState dataState = DataState.notSet;
  List<JobModel> myJobs = [];
  List<JobModel> searchList = [];
  bool isSearching = false;
  CompanyModel? profile;
  JobModel? jobDetails;
  final search = TextEditingController();
  String? selectedType;
  String? selectedCity;

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

  Future<void> updateJob(JobModel job) async {
    dataState = DataState.loading;
    notifyListeners();
    final updatedJob = await CompanyDbServiec().updateJob(job: job);
    if (updatedJob == null) {
      dataState = DataState.failure;
    } else {
      for (int index = 0; index < myJobs.length; index++) {
        if (myJobs[index].id == updatedJob.id) {
          myJobs[index] = updatedJob;
          break;
        }
      }
      jobDetails = updatedJob;
      dataState = DataState.done;
    }
    notifyListeners();
  }

  Future<void> deleteJob(jobId) async {
    dataState = DataState.loading;
    notifyListeners();
    final errorMessage = await CompanyDbServiec().deleteJob(jobId: jobId);
    if (errorMessage != null) {
      dataState = DataState.failure;
    } else {
      myJobs.removeWhere((job) => job.id == jobId);
      dataState = DataState.done;
    }
    notifyListeners();
  }

  Future<void> getCompanyProfile({required String userId}) async {
    dataState = DataState.loading;
    notifyListeners();
    final result = await CompanyDbServiec().getCompanyProfile(userId: userId);
    if (result == null) {
      dataState = DataState.failure;
      notifyListeners();
    } else {
      profile = result;
      print('company ${profile!.toJson()}');
      dataState = DataState.done;
      notifyListeners();
    }
  }

  void searchAndFilter({String? city, String? jobType, String? search}) {
    searchList.clear();
    if (city != null) {
      for (var job in myJobs) {
        if (job.location == city && (!searchList.contains(job))) {
          if (jobType != null) {
            if (job.jobType == jobType) searchList.add(job);
          } else {
            searchList.add(job);
          }
        }
      }
    }
    if (jobType != null) {
      for (var job in myJobs) {
        if (job.jobType == jobType && (!searchList.contains(job))) {
          if (city != null) {
            if (city == job.location) searchList.add(job);
          } else {
            searchList.add(job);
          }
        }
      }
    }

    if (search != null && search.isNotEmpty) {
      if (city == null && jobType == null) {
        for (var job in myJobs) {
          if (job.title == search ||
              job.title.startsWith(search) ||
              job.title.contains(search) && (!searchList.contains(job))) {
            searchList.add(job);
          }
        }
      } else {
        if (searchList.isNotEmpty) {
          searchList.removeWhere(
              (job) => (job.title != search && !job.title.startsWith(search) && !job.title.contains(search)));
        }
      }
    }
    notifyListeners();
  }

  void changeSearch(bool state) {
    isSearching = state;
    notifyListeners();
  }

  void clearSearch() {
    searchList.clear();
    search.clear();
    selectedType = null;
    selectedCity = null;
  }
}
