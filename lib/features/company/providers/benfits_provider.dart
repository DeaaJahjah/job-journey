import 'package:flutter/material.dart';
import 'package:job_journey/features/company/providers/required_documents_provider.dart';

class BenefitsProvider with ChangeNotifier {
  List<TextEditingController> controllers = [TextEditingController(), TextEditingController()];

  List<Helper> benefits = [const Helper(id: 0, text: ''), const Helper(id: 1, text: '')];

  setBenefits(List<String> benefits) {
    for (int i = 0; i < benefits.length; i++) {
      this.benefits.clear();
      controllers.clear();
      this.benefits.add(Helper(id: i, text: benefits[i]));
      controllers.add(TextEditingController(text: benefits[i]));
    }
    notifyListeners();
  }

  removeBenefit(int id) {
    benefits.removeAt(id);
    controllers.removeAt(id);

    notifyListeners();
  }

  updateBenefit({required int id, required String text}) {
    for (int i = 0; i < benefits.length; i++) {
      if (id == benefits[i].id) {
        benefits[i] = Helper(id: id, text: text);
        // notifyListeners();
        break;
      }
    }
  }

  addBenefit() {
    benefits.add(Helper(id: benefits.last.id + 1, text: ''));
    controllers.add(TextEditingController());

    notifyListeners();
  }

  clearBenefits() {
    benefits = [const Helper(id: 0, text: ''), const Helper(id: 1, text: '')];
    controllers = [TextEditingController(), TextEditingController()];
  }
}
