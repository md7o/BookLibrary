int calculateMaxWordsInSlide(double height, double increaseFontSize) {
  int maxWordsInSlide = 0;

  if (increaseFontSize == 16.0) {
    if (height <= 700.0) {
      maxWordsInSlide = 550;
    } else if (height >= 700.0 && height <= 845.0) {
      maxWordsInSlide = 900;
    } else if (height > 845.0 && height < 1000.0) {
      maxWordsInSlide = 1100;
    } else {
      maxWordsInSlide = (height * 2).round();
    }
  } else if (increaseFontSize == 18.0) {
    if (height <= 700.0) {
      maxWordsInSlide = 500;
    } else if (height >= 700.0 && height <= 845.0) {
      maxWordsInSlide = 700;
    } else if (height >= 845.0 && height <= 1000.0) {
      maxWordsInSlide = 900;
    } else {
      maxWordsInSlide = (height * 1.5).round();
    }
  } else if (increaseFontSize == 20.0) {
    if (height <= 700.0) {
      maxWordsInSlide = 400;
    } else if (height >= 700.0 && height <= 845.0) {
      maxWordsInSlide = 600;
    } else if (height >= 845.0 && height <= 1000.0) {
      maxWordsInSlide = 780;
    } else {
      maxWordsInSlide = (height * 1.3).round();
    }
  } else if (increaseFontSize == 22.0) {
    if (height <= 700.0) {
      maxWordsInSlide = 300;
    } else if (height >= 700.0 && height <= 845.0) {
      maxWordsInSlide = 430;
    } else if (height >= 845.0 && height <= 1000.0) {
      maxWordsInSlide = 650;
    } else {
      maxWordsInSlide = (height * 1).round();
    }
  } else if (increaseFontSize == 24.0) {
    if (height <= 700.0) {
      maxWordsInSlide = 250;
    } else if (height >= 700.0 && height <= 845.0) {
      maxWordsInSlide = 450;
    } else if (height >= 845.0 && height <= 1000.0) {
      maxWordsInSlide = 540;
    } else if (height >= 1000.0 && height <= 1300.0) {
      maxWordsInSlide = (height * 0.8).round();
    } else if (height >= 1300.0 && height <= 2000.0) {
      maxWordsInSlide = (height * 1).round();
    }
  }

  return maxWordsInSlide;
}
