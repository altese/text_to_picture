class DummyBooks {
  static List<Book> list = [
    Book(
      title: '슬픔이여 안녕',
      author: '프랑수아즈 사강',
      content: '살아 있는 거야? 멀리서 보니 네 모습이 꼭 난파당한 사람 같더라.',
    ),
    Book(
      title: '칠월과 안생',
      author: '칭산',
      content:
          '칠월, 나중에 나 죽고 나면 다시는 너 안 보고 싶을 것 같아. 사는 동안 너를 너무 많이 그리워해서, 이제 더는 그리워하기 싫어. 나 또 떠날 거야. 난 너무 지쳐서 멈출 수가 없어.',
    ),
    Book(
      title: '말은 말에게 가려고',
      author: '이현호',
      content:
          '한 숟갈 추억을 떠먹은 일로 몇 달쯤 슬픔을 곯지 않게 하는 사람이 있다. "나는 너를 좋아진다." 같은 흰소리를 들어주던',
    ),
    Book(
      title: '말은 말에게 가려고',
      author: '이현호',
      content: '씨앗 하나를 안으려고 지구는 중력을 놓지 않는다.',
    ),
  ];
}

class Book {
  String title;
  String author;
  String content;

  Book({
    required this.title,
    required this.author,
    required this.content,
  });
}
