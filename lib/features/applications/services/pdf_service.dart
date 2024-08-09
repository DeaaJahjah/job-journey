import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:job_journey/features/job_seeker/models/job_seeker_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<Uint8List> networkImageToMemory(String imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));
  return response.bodyBytes;
}

Future<void> generatePdf(JobSeekerModel jobSeeker) async {
  // final pdf = pw.Document();
  pw.ImageProvider? profileImageProvider;

  if (jobSeeker.profilePicture != null && jobSeeker.profilePicture!.isNotEmpty) {
    final imageBytes = await networkImageToMemory(jobSeeker.profilePicture!);
    profileImageProvider = pw.MemoryImage(imageBytes);
  }

  // final fontData = await rootBundle.load('assets/fonts/arial.ttf');
  // final fontData = await PdfGoogleFonts.amiriRegular();
  final font = pw.Font.ttf(await rootBundle.load("assets/fonts/HacenTunisia.ttf"));

  final pdf = pw.Document(
    title: 'Resume',
    author: '',
    creator: 'Job Journey',
    producer: 'Job Journey',
    subject: 'Job application',
    theme: pw.ThemeData.withFont(
      base: font,
      bold: font,
      // icons: iconFont,
    ),
  );

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Profile Picture
            if (profileImageProvider != null)
              pw.Center(
                child: pw.Image(
                  profileImageProvider,
                  height: 100,
                  width: 100,
                ),
              ),
            pw.SizedBox(height: 20),
            // Name and Contact Information
            pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Text(jobSeeker.name,
                  style: pw.TextStyle(fontSize: 24, font: font, fontWeight: pw.FontWeight.bold)),
            ),
            pw.Text(jobSeeker.phoneNumber, style: pw.TextStyle(font: font)),
            pw.Text(jobSeeker.email, style: pw.TextStyle(font: font)),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Text(jobSeeker.location, style: pw.TextStyle(font: font))),
            pw.SizedBox(height: 20),
            // Summary
            if (jobSeeker.summary.isNotEmpty)
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Summary',
                    style: pw.TextStyle(fontSize: 18, font: font, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Directionality(
                      textDirection: pw.TextDirection.rtl,
                      child: pw.Text(jobSeeker.summary, style: pw.TextStyle(font: font))),
                  pw.SizedBox(height: 20),
                ],
              ),
            // Skills
            if (jobSeeker.skills != null && jobSeeker.skills!.isNotEmpty)
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Skills',
                    style: pw.TextStyle(fontSize: 18, font: font, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 5),
                  ...jobSeeker.skills!.map((skill) => pw.Directionality(
                      textDirection: pw.TextDirection.rtl,
                      child: pw.Text('• $skill', style: pw.TextStyle(font: font)))),
                  pw.SizedBox(height: 20),
                ],
              ),
            // Soft Skills
            if (jobSeeker.softSkills != null && jobSeeker.softSkills!.isNotEmpty)
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Soft Skills',
                    style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, font: font),
                  ),
                  pw.SizedBox(height: 5),
                  ...jobSeeker.softSkills!.map((softSkill) => pw.Directionality(
                      textDirection: pw.TextDirection.rtl,
                      child: pw.Text('• $softSkill', style: pw.TextStyle(font: font)))),
                  pw.SizedBox(height: 20),
                ],
              ),
            // Certificates
            if (jobSeeker.certificates != null && jobSeeker.certificates!.isNotEmpty)
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Certificates',
                    style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, font: font),
                  ),
                  pw.SizedBox(height: 5),
                  ...jobSeeker.certificates!.map((certificate) => pw.Directionality(
                      textDirection: pw.TextDirection.rtl,
                      child: pw.Text('• $certificate', style: pw.TextStyle(font: font)))),
                  pw.SizedBox(height: 20),
                ],
              ),
            // Languages
            if (jobSeeker.languages != null && jobSeeker.languages!.isNotEmpty)
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Languages',
                    style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, font: font),
                  ),
                  pw.SizedBox(height: 5),
                  ...jobSeeker.languages!.map((language) => pw.Directionality(
                      textDirection: pw.TextDirection.rtl,
                      child: pw.Text('• $language', style: pw.TextStyle(font: font)))),
                  pw.SizedBox(height: 20),
                ],
              ),
          ],
        );
      },
    ),
  );

  // Save the PDF to a file or print it directly
  final output = await getTemporaryDirectory();
  final file = File("${output.path}/user_cv.pdf");
  await file.writeAsBytes(await pdf.save());

  // Optionally, you can use the printing package to print the PDF
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
