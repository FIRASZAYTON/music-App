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
      title: "M U S I C A N O",
      subTitle: "Welcam To our app",
      lottieFile: 'images/image5.json',
    ),
    InboardingModel(
      title: "M U S I C A N O",
      subTitle: "Enjoy listening to music",
      lottieFile: 'images/image2.json',
    ),
    InboardingModel(
      title: "M U S I C A N O",
      subTitle: "Take comfort with us",
      lottieFile: 'images/image3.json',
    ),
  ];
}
