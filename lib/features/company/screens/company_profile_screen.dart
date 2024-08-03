import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/extensions/loc.dart';

class CompanyProfileScreen extends StatefulWidget {
  static const routeName = '/company-profile-screen';
  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            title: Text(
              context.loc.profile,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white, fontWeight: FontWeight.bold),
            ),
            foregroundColor: white,
            elevation: 8,
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1.5,
              centerTitle: true,
              background: SizedBox.expand(
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.vertical(bottom: Radius.circular(25)),
                      gradient: LinearGradient(
                          colors: [lightBlue, blue], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [lightBlue, blue]),
                            shape: BoxShape.circle,
                            border: Border(
                                right: BorderSide(width: 4, color: white),
                                left: BorderSide(width: 4, color: white),
                                bottom: BorderSide(width: 4, color: white))),
                        child: const CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/company-logo-design-template-5746111ce930e4340aa34a9eb626a302_screen.jpg?ts=1671431883",
                          ),
                          radius: 50,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'شركة تكنولوجيا المعلومات',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 18, color: white, fontWeight: FontWeight.bold),
                        // ),
                      ),
                      Text(
                        'تقانة المعلومات',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, color: white),
                      ),
                      sizedBoxSmall,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.location_pin, color: white, size: 19),
                                const SizedBox(width: 2),
                                Text(
                                  'حمص',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 50,
                              child: VerticalDivider(
                                thickness: .7,
                                width: 15,
                                color: white,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.date_range_rounded, color: white, size: 19),
                                const SizedBox(width: 2),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Text(
                                    '12/6/2009',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            centerTitle: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 16, right: 16, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.email_rounded,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          context.loc.email,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                      child: Text(
                        'companyname123@gmail.com',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white, letterSpacing: 1),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      endIndent: 20,
                      indent: 20,
                      thickness: .5,
                      height: 30,
                    ),
                    // SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.phone_iphone_rounded, color: Colors.grey),
                        const SizedBox(width: 5),
                        Text(
                          context.loc.phoneNumber,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                      child: Text(
                        '+963992984380',
                        textDirection: TextDirection.ltr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white, letterSpacing: 1),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      endIndent: 20,
                      indent: 20,
                      thickness: .5,
                    ),
                    sizedBoxSmall,
                    Row(
                      children: [
                        const Icon(Icons.description_rounded, color: Colors.grey),
                        const SizedBox(width: 5),
                        Text(
                          context.loc.description,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                      child: Text(
                        '',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white, letterSpacing: 1),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}
