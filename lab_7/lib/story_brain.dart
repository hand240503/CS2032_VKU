import 'story.dart';

class StoryBrain {
  int _storyNumber = 0;

  final List<Story> _storyData = [
    Story(
      storyTitle:
          'Bạn thấy một chiếc xe bị hỏng bên đường. Bạn dừng lại để giúp đỡ?',
      choice1: 'Dừng lại giúp.',
      choice2: 'Tiếp tục đi.',
    ),
    Story(
      storyTitle: 'Người tài xế cảm ơn bạn và đề nghị chở bạn về.',
      choice1: 'Chấp nhận lời đề nghị.',
      choice2: 'Từ chối và đi bộ.',
    ),
    Story(
      storyTitle: 'Bạn tiếp tục đi và bị lạc trong rừng.',
      choice1: 'Cố gắng tìm đường ra.',
      choice2: 'Chờ người đến cứu.',
    ),
    Story(
      storyTitle: 'Kết thúc: Bạn an toàn về nhà. Chúc mừng!',
      choice1: 'Chơi lại',
      choice2: '',
    ),
    Story(
      storyTitle: 'Kết thúc: Bạn bị lạc mãi mãi...',
      choice1: 'Chơi lại',
      choice2: '',
    ),
    Story(
      storyTitle: 'Kết thúc: Một người lạ tốt bụng đưa bạn về nhà.',
      choice1: 'Chơi lại',
      choice2: '',
    ),
  ];

  String getStory() => _storyData[_storyNumber].storyTitle;

  String getChoice1() => _storyData[_storyNumber].choice1;

  String getChoice2() => _storyData[_storyNumber].choice2;

  void nextStory(int choiceNumber) {
    switch (_storyNumber) {
      case 0:
        _storyNumber = (choiceNumber == 1) ? 1 : 2;
        break;
      case 1:
        _storyNumber = (choiceNumber == 1) ? 5 : 3;
        break;
      case 2:
        _storyNumber = (choiceNumber == 1) ? 4 : 3;
        break;
      default:
        restart();
    }
  }

  void restart() {
    _storyNumber = 0;
  }

  bool buttonShouldBeVisible() {
    return _storyNumber < 3;
  }
}
