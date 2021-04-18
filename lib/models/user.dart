class User {
  final String id;
  final String username;
  final String phonenumber;
  final String avatar;
  final String address;
  final String email;
  final String description;

  User(
    this.id,
    this.username,
    this.phonenumber,
    this.avatar,
    this.address,
    this.email,
    this.description,
  );

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        username = json["username"],
        phonenumber = json["phonenumber"],
        avatar = json["avatar"],
        address = json["address"],
        email = json["email"],
        description = json["descriprion"];
}
