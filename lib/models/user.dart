class User {
  final String id;
  final String name;
  final String phonenumber;
  final String avatar;
  final String birthday;
  final String description;

  User(
    this.id,
    this.name,
    this.phonenumber,
    this.avatar,
    this.birthday,
    this.description,
  );

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"].toString(),
        name = json["name"],
        phonenumber = json["phone_number"],
        avatar = json["avatar"],
        birthday = json["birthday"],
        description = json["descriprion"];
}
