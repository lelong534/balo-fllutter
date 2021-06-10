class User {
  final String id;
  final String name;
  final String phonenumber;
  final String avatar;
  final String coverImage;
  final String birthday;
  final String description;
  final String address;

  User(this.id, this.name, this.phonenumber, this.avatar, this.coverImage,
      this.birthday, this.description, this.address);

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"].toString(),
        name = json["name"],
        phonenumber = json["phone_number"],
        avatar = json["avatar"],
        coverImage = json["cover_image"],
        birthday = json["birthday"],
        description = json["description"],
        address = json["address"];
}
