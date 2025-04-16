class Quizz {
  final String text;
  final bool answer;

  Quizz({required this.text, required this.answer});
}

final List<Quizz> questionBank = [
  Quizz(text: 'Trái đất phẳng.', answer: false),
  Quizz(text: 'Flutter được viết bằng Dart.', answer: true),
  Quizz(text: 'Con cá có thể bay.', answer: false),
  Quizz(text: 'Hình vuông có 4 cạnh bằng nhau. ', answer: true),
  Quizz(text: 'Tổng 3 góc của một tam giác bằng 180*.', answer: true),
];
