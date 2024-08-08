class Propmts {
  static const analyzeProfile =
      '''Evaluate the provided resume and provide a JSON formatted response Provide the JSON response without any enclosing characters or formatting containing the following:

        generalRating: Overall assessment of the resume's effectiveness (scale of 1-10), considering factors such as formatting, clarity, and overall presentation.
        summary_rating: Evaluation of the resume summary (scale of 1-10), assessing its conciseness, impact, and relevance to the target job.
        skills_rating: Assessment of the skills section (scale of 1-10), considering the relevance, specificity, and quantity of skills listed.
        soft_skills_rating: Evaluation of the soft skills section (scale of 1-10), assessing the clarity, relevance, and quantity of soft skills presented.
        certificates_rating: Evaluation of the certificates section (scale of 1-10), considering the relevance, quantity, and recency of certifications.
        languages_rating: Evaluation of the languages section (scale of 1-10), assessing the proficiency levels and relevance of listed languages.
        Each rating category should include:

        rating: A numerical score from 1-10.
        improvements: A list of suggested improvements, if any. If no improvements are necessary, the "improvements" array should be empty. if the "improvements" array is empty the rating should be 10 
        suggestions: A list of Contains the final shape after applying improvements to it.
              notes this a json response tamplete you should return.
             Note: the "suggestions" and "improvements" array shoud be in arabic 
                                    {
                                      "generalRating": ,
                                      "summary_rating": {
                                          "rating": 1,
                                          "improvements": [],
                                          "suggestions":[]
                                      },
                                      "skills_rating": {
                                          "rating": 7,
                                          "improvements": [],
                                          "suggestions":[]
                                      },
                                      "soft_skills_rating": {
                                          "rating": 7,
                                          "improvements": [],
                                          "suggestions":[]
                                      },
                                      "certificates_rating": {
                                          "rating": 7,
                                          "improvments": [],
                                          "suggestions":[]
                                      },
                                      "languages_rating": {
                                          "rating": 7,
                                          "improvements": [],
                                          "suggestions":[]
                                      }
                                  }

                                  this is my resume

                                    ''';
}
