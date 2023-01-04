class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'LEARN',
      image: 'assets/a.svg',
      discription:
          "Up-to-date information on climatic and atmospheric trends and their impacts "
          "while offering tips, guidance and helping us learn, to make a difference that "
          "matters."),
  UnbordingContent(
      title: 'GROW',
      image: 'assets/a.svg',
      discription:
          "A comprehensive suite of resources with an easy-to-navigate interface, and "
          "cradle of horticulture opportunities that allow self growth and help keep our "
          "planet clean and green."),
  UnbordingContent(
      title: 'EARN',
      image: 'assets/a.svg',
      discription:
          "Best time to start learning and being activated about climate change. With the"
          "app, you can earn vouchers and coupons to demonstrate your progress and "
          "understanding of climate change."),
];
