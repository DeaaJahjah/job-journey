class ProfileAnalysisResualt {
  Rating? summaryRating;
  Rating? skillsRating;
  Rating? softSkillsRating;
  Rating? certificatesRating;
  Rating? languagesRating;
  List<String>? sections;
  int? generalRating;

  ProfileAnalysisResualt({
    required this.summaryRating,
    required this.skillsRating,
    required this.softSkillsRating,
    required this.certificatesRating,
    required this.languagesRating,
    required this.sections,
    required this.generalRating,
  });

  factory ProfileAnalysisResualt.fromJson(Map<String, dynamic> json) {
    return ProfileAnalysisResualt(
      summaryRating: Rating.fromJson(json['summary_rating']),
      skillsRating: Rating.fromJson(json['skills_rating']),
      softSkillsRating: Rating.fromJson(json['soft_skills_rating']),
      certificatesRating: Rating.fromJson(json['certificates_rating']),
      languagesRating: Rating.fromJson(json['languages_rating']),
      sections: List<String>.from(json['sections'] ?? []),
      generalRating: json['generalRating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary_rating': summaryRating?.toJson(),
      'skills_rating': skillsRating?.toJson(),
      'soft_skills_rating': softSkillsRating?.toJson(),
      'certificates_rating': certificatesRating?.toJson(),
      'languages_rating': languagesRating?.toJson(),
      'sections': sections,
      'generalRating': generalRating,
    };
  }
}

class Rating {
  int rating;
  List<String>? improvements;
  List<String>? suggestions;

  Rating({required this.rating, required this.improvements, required this.suggestions});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rating: json['rating'],
      improvements: List<String>.from(json['improvements']),
      suggestions: List<String>.from(json['suggestions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'rating': rating, 'improvements': improvements, 'suggestions': suggestions};
  }
}
