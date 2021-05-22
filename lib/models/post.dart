class Post {
  final int id;
  final String described;
  final List images;
  final String video;
  final int like;
  final int comment;
  final String created;
  final bool isLiked;
  // final String isHidden;
  final String authorId;
  final String authorName;
  final String authorAvatar;

  Post(
    this.id,
    this.described,
    this.images,
    this.video,
    this.like,
    this.comment,
    this.created,
    this.isLiked,
    // this.isHidden,
    this.authorId,
    this.authorName,
    this.authorAvatar,
  );

  Post.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        described = json["described"],
        images = json["images"],
        video = json["video"],
        like = json["like"],
        comment = json["comment"],
        created = json["created"],
        isLiked = json["isLiked"],
        // isHidden = json["is_hidden"],
        authorId = json["authorId"],
        authorName = json["author"]["name"],
        authorAvatar = json["author"]["avatar"];
}
