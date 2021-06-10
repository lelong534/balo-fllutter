class Search {
  final String username;
  final String avatar;

  Search(
      this.username,
      this.avatar,
      );

  Search.fromJson(Map<String, dynamic> json)
      :username = json["username"],
        avatar = json["avatar"];
}
