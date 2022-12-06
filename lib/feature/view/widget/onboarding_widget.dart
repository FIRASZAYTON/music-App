class InboardingModel {
  String? title;
  String? subTitle;
  String? lottieFile;

  InboardingModel({
    this.title,
    this.subTitle,
    this.lottieFile,
  });
  static List<InboardingModel> tab = [
    InboardingModel(
      title: "Welcam To Music app",
      subTitle: "wwwwwwwwwwwewewqqwqw",
      lottieFile: 'images/image1.json',
    ),
    InboardingModel(
      title: "title",
      subTitle: "subTitle",
      lottieFile: 'images/image2.json',
    ),
    InboardingModel(
      title: "title",
      subTitle: "subTitle",
      lottieFile: 'images/image3.json',
    ),
  ];
}
