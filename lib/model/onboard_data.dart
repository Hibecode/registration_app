class OnBoarding {
  final String title;
  final String subTitle;
  final String image;

  OnBoarding({
    required this.title,
    required this.subTitle,
    required this.image
  });
}


List<OnBoarding> onboardingContents = [
  OnBoarding(
      title: 'Track your\n spending',
      subTitle: 'By linking all your accounts, you can effectively monitor\n your cash flow to plan better for future expenditure.',
      image:  'assets/images/onboarding_image_1.png'),

  OnBoarding(
      title: 'Build your social\n finance network',
      subTitle: 'Saving is now fun, join millions to save and get rewards\n for saving',
      image: 'assets/images/onboarding_image_2.png'),

  OnBoarding(
      title: 'Get access to\n quick loans',
      subTitle: 'You can not be stranded, all you need is request for a\n quick loan.',
      image: 'assets/images/onboarding_image_3.png'),

  OnBoarding(
      title: 'Steadily grow\n your savings',
      subTitle: 'Do not save what is left after spending but spend what is\n left after saving.',
      image: 'assets/images/onboarding_image_4.png'),

  OnBoarding(
      title: 'Invest wisely in\n beneficial projects',
      subTitle: 'Cease depending on a single source and make\n investments to create multiple sources.',
      image: 'assets/images/onboarding_image_3.png'),
];