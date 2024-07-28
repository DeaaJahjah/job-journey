import 'package:flutter/material.dart';
import 'package:job_journey/features/company/providers/required_documents_provider.dart';

class RequirementsProvider with ChangeNotifier {
  List<TextEditingController> controllers = [TextEditingController(), TextEditingController()];
  List<Helper> requirements = [
    const Helper(id: 0, text: ''),
    const Helper(id: 1, text: ''),
  ];

  setRequirements(List<String> requirements) {
    for (int i = 0; i < requirements.length; i++) {
      this.requirements.clear();
      controllers.clear();
      this.requirements.add(Helper(id: i, text: requirements[i]));
      controllers.add(TextEditingController(text: requirements[i]));
    }
    notifyListeners();
  }

  removeRequirement(int id) {
    requirements.removeAt(id);
    controllers.removeAt(id);
    notifyListeners();
  }

  updateRequirement({required int id, required String text}) {
    for (int i = 0; i < requirements.length; i++) {
      if (id == requirements[i].id) {
        requirements[i] = Helper(id: id, text: text);
        // notifyListeners();
        break;
      }
    }
  }

  addRequirement() {
    requirements.add(Helper(id: requirements.last.id + 1, text: ''));
    controllers.add(TextEditingController());
    notifyListeners();
  }

  clearRequirements() {
    requirements = [const Helper(id: 0, text: ''), const Helper(id: 1, text: '')];
    controllers = [TextEditingController(), TextEditingController()];
  }
}
