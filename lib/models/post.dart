class Post {
  final int id;
  final String described;
  final List images;
  final String video;
  final int like;
  // final int comment;
  final String created;
  final String isLiked;
  // final String isHidden;
  // final String authorId;
  // final String authorName;
  // final String authorAvatar;

  Post(
    this.id,
    this.described,
    this.images,
    this.video,
    this.like,
    // this.comment,
    this.created,
    this.isLiked,
    // this.isHidden,
    // this.authorId,
    // this.authorName,
    // this.authorAvatar,
  );

  Post.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        described = json["described"],
        images = json["images"],
        video = json["video"],
        like = json["like"],
        // comment = json["comment"],
        created = json["created"],
        isLiked = json["is_liked"];
  // isHidden = json["is_hidden"],
  // authorId = json["authorId"],
  // authorName = json["author"]["username"],
  // authorAvatar = json["author"]["avatar"];
}
