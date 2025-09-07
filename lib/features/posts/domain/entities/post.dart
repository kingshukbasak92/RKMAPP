class Post {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime createdAt;
  final String? author;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
    this.author,
  });

  factory Post.fromMap(Map<String, dynamic> map, String id) {
    return Post(
      id: id,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      createdAt: map['createdAt']?.toDate() ?? DateTime.now(),
      author: map['author'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      if (author != null) 'author': author,
    };
  }
}
