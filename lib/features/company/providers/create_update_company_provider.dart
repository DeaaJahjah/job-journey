import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/features/company/models/company_model.dart';
import 'package:job_journey/features/company/services/company_db_service.dart';

class CreateUpdateCompanyProvider with ChangeNotifier {
  DataState dataState = DataState.notSet;

  Future<void> createCompany({required CompanyModel company}) async {
    dataState = DataState.loading;
    notifyListeners();
    final jobs = await CompanyDbServiec().createCompany(company: company);
    dataState = DataState.done;
    notifyListeners();
  }

  Future<void> updateCompany({required CompanyModel company}) async {
    dataState = DataState.loading;
    notifyListeners();
    final result = await CompanyDbServiec().updateCompany(company: company);
    if (!result) {
      dataState = DataState.failure;
      notifyListeners();
    } else {
      dataState = DataState.done;
      notifyListeners();
    }
  }
}
