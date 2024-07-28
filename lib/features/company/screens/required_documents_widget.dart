import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/text_field_custome.dart';
import 'package:job_journey/features/company/providers/required_documents_provider.dart';
import 'package:provider/provider.dart';
import 'package:show_up_animation/show_up_animation.dart';

class RequiredDocumentsWidget extends StatelessWidget {
  const RequiredDocumentsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RequiredDocumentsProvider>(builder: (context, provider, _) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: provider.documents.length,
        separatorBuilder: (context, index) => sizedBoxSmall,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ShowUpAnimation(
                  animationDuration: const Duration(milliseconds: 250),
                  direction: Direction.horizontal,
                  delayStart: Duration.zero,
                  child: TextFieldCustom(
                    controller: provider.controllers[index],
                    key: UniqueKey(),
                    text: '${context.loc.document} ${index + 1}',
                    icon: provider.documents.length == 1 ? null : Icons.delete,
                    iconColor: Colors.red,
                    onIconTap: () {
                      provider.removeDocument(index);
                    },
                    onChanged: (value) {
                      provider.updateDocument(id: index, text: value);
                    },
                  )),
              const SizedBox(height: 2),
              if (index == provider.documents.length - 1)
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      provider.addDocument();
                    },
                    child: Container(
                      width: 40,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: darkGray, borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.add, size: 16),
                    ),
                  ),
                )
            ],
          );
        },
      );
    });
  }
}
