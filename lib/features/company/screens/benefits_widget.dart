import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/text_field_custome.dart';
import 'package:job_journey/features/company/providers/benfits_provider.dart';
import 'package:provider/provider.dart';
import 'package:show_up_animation/show_up_animation.dart';

class BenefitsWidget extends StatelessWidget {
  const BenefitsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BenefitsProvider>(builder: (context, provider, _) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: provider.benefits.length,
        separatorBuilder: (context, index) => sizedBoxSmall,
        itemBuilder: (context, index) {
          return Column(
            key: UniqueKey(),
            children: [
              ShowUpAnimation(
                  animationDuration: const Duration(milliseconds: 250),
                  direction: Direction.horizontal,
                  delayStart: Duration.zero,
                  child: TextFieldCustom(
                    controller: provider.controllers[index],
                    key: UniqueKey(),
                    text: '${context.loc.benefit} ${index + 1}',
                    icon: provider.benefits.length == 1 ? null : Icons.delete,
                    iconColor: Colors.red,
                    onIconTap: () {
                      provider.removeBenefit(index);
                    },
                    onChanged: (value) {
                      provider.updateBenefit(id: index, text: value);
                    },
                  )),
              const SizedBox(height: 2),
              if (index == provider.benefits.length - 1)
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      provider.addBenefit();
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
