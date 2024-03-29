class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      image: 'assets/learn.png',
      title: 'LEARN',
      discription:
          "Up-to-date information on climatic and atmospheric trends and their impacts "
          "while offering tips, guidance & helping us learn, to make a difference that "
          "matters."),
  UnbordingContent(
      image: 'assets/grow.png',
      title: 'GROW',
      discription:
          "A comprehensive suite of resources with an easy-to-navigate interface, and "
          "cradle of horticulture opportunities that allow self growth and help keep our "
          "planet clean and green."),
  UnbordingContent(
      image: 'assets/earn.png',
      title: 'EARN',
      discription:
          "Best time to start learning and being activated about climate change. With the"
          " app, you can earn vouchers and coupons to demonstrate your progress and "
          "understanding of climate change."),
];
