import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/constant/propmts.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/elevated_button_custom.dart';
import 'package:job_journey/core/keys.dart';
import 'package:job_journey/core/utils/shared_pref.dart';
import 'package:job_journey/features/apply_for_job/screens/application_details_widget.dart';
import 'package:job_journey/features/company/models/job_model.dart';
import 'package:job_journey/features/job_seeker/models/job_seeker_model.dart';
import 'package:job_journey/features/job_seeker/providers/job_seeker_provider.dart';
import 'package:provider/provider.dart';

const String _apiKey = GEMINI_KEY;

class GeminiCvMaker extends StatefulWidget {
  final JobModel? job;
  const GeminiCvMaker({super.key, this.job});

  @override
  State<GeminiCvMaker> createState() => _GeminiCvMakerState();
}

class _GeminiCvMakerState extends State<GeminiCvMaker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.generateCv),
      ),
      body: ChatWidget(apiKey: _apiKey, job: widget.job),
    );
  }
}

class ChatWidget extends StatefulWidget {
  final JobModel? job;

  const ChatWidget({required this.apiKey, super.key, this.job});

  final String apiKey;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> with SingleTickerProviderStateMixin {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  final List<({Image? image, String? text, bool fromUser})> _generatedContent =
      <({Image? image, String? text, bool fromUser})>[];
  bool _loading = false;
  bool _isMenuOpen = false;
  late AnimationController controller = AnimationController(vsync: this);
  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: widget.apiKey,
    );

    _chat = _model.startChat();

    String prompt =
        '''Generate a JSON formatted CV based on the provided job description. 
              Adhere strictly to the job description's requirements and use the following CV structure:
                {
                  "name": "",
                  "phone_number": "",
                  "email": "",
                  "profile_picture": "",
                  "location": "",
                  "summary": "",
                  "skills": [],
                  "soft_skills": [],
                  "certificates": [],
                  "languages": []
                }''';
    prompt += '\nThis my information';
    prompt += context.read<JobSeekerProvider>().jobSeekerModel!.getInfo().toString();
    prompt += '\nThis the job details ';
    prompt += '\nnote do not add a json word before the response';
    prompt += '\nnote add arabic and english languages to languages list of String';
    prompt += '\nnote add university certificate to certificates list of String';
    prompt +=
        '\nNote the response should be in should be in ${SharedPreferencesManager().isArabic() ? 'Arabic' : 'English'}';

    prompt += widget.job!.toJson().toString();
    _generatedContent.add((image: null, text: 'انشئ سيرة ذاتية', fromUser: true));
    // Future.delayed(
    //   Duration.zero,
    //   () {
    //   },
    // );
    print(prompt);
    _sendChatMessage(prompt);
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  void _animationTrigger() {
    if (_isMenuOpen) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _apiKey.isNotEmpty
                    ? ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        itemBuilder: (context, idx) {
                          final content = _generatedContent[idx];
                          return MessageWidget(
                            text: content.text,
                            image: content.image,
                            isFromUser: content.fromUser,
                            jobId: widget.job!.id,
                          );
                        },
                        itemCount: _generatedContent.length,
                      )
                    : ListView(
                        children: const [
                          Text(
                            'No API key found. Please provide an API Key using '
                            "'--dart-define' to set the 'API_KEY' declaration.",
                          ),
                        ],
                      ),
              ),
            ],
          ),
          Positioned(
            right: 10,
            bottom: 25,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isMenuOpen)
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    // height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.bottomRight, colors: [
                          darkGray.withOpacity(.3),
                          white.withOpacity(.11),
                          darkGray.withOpacity(.2),
                          white.withOpacity(.3)
                        ])),
                    child: Column(
                      children: [
                        ElevatedButtonCustom(
                          onPressed: () async {
                            _generatedContent.add((image: null, text: context.loc.translateToArabic, fromUser: true));
                            _isMenuOpen = false;
                            _scrollDown();
                            _animationTrigger();
                            setState(() {});
                            await _sendChatMessage(Propmts.translateToArabic);
                            _scrollDown();
                          },
                          text: context.loc.translateToArabic,
                          textColor: white,
                          blueGradientButton: false,
                        ).animate().slideX().fade(),
                        sizedBoxMedium,
                        ElevatedButtonCustom(
                          onPressed: () async {
                            _generatedContent.add((image: null, text: context.loc.translateToEnglish, fromUser: true));
                            _isMenuOpen = false;
                            _scrollDown();
                            _animationTrigger();

                            setState(() {});
                            await _sendChatMessage(Propmts.translateToEnglish);
                            _scrollDown();
                          },
                          text: context.loc.translateToEnglish,
                          textColor: white,
                          blueGradientButton: false,
                        ).animate(delay: const Duration(milliseconds: 100)).slideX().fade(),
                      ],
                    ),
                  ).animate()
                    ..fadeIn(),
                Row(
                  children: [
                    const SizedBox.square(dimension: 15),
                    if (!_loading)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isMenuOpen = !_isMenuOpen;
                          });
                          _animationTrigger();
                        },
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(begin: Alignment.centerLeft, colors: [lightpurple, purple]),
                            ),
                            child: Icon(
                              _isMenuOpen ? Icons.close : Icons.widgets_outlined,
                              color: white,
                              size: 30,
                            ).animate(controller: controller).rotate()),
                      )
                    else
                      const CircularProgressIndicator(),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      // _generatedContent.add((image: null, text: message, fromUser: true));
      final response = await _chat.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      _generatedContent.add((image: null, text: text, fromUser: false));

      if (text == null) {
        _showError('No response from API.');
        return;
      } else {
        setState(() {
          _loading = false;
          // _scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _showError(String message) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    this.image,
    this.text,
    required this.jobId,
    required this.isFromUser,
  });

  final Image? image;
  final String? text;
  final bool isFromUser;
  final String jobId;

  @override
  Widget build(BuildContext context) {
    return isFromUser
        ? Padding(
            padding: const EdgeInsets.only(right: 150, top: 30, bottom: 30),
            child: ElevatedButtonCustom(
              onPressed: null,
              text: text!,
              textColor: white,
              blueGradientButton: false,
            ),
          ).animate().slideX().fade()
        : Row(
            mainAxisAlignment: isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                  child: ApplicationDetailsBottomSheet(
                jobId: jobId,
                application: JobSeekerModel.fromJson(json.decode(text!)),
              ).animate().slideX(begin: 1, end: 0).fade())
            ],
          );
  }
}
