class Fetch_UserData {
  final String userID, firstname, lastname, email;

  Fetch_UserData({
    required this.userID,
    required this.firstname,
    required this.lastname,
    required this.email,
  });

  static Fetch_UserData fromJson(Map<String, dynamic> json) => Fetch_UserData(
        userID: json['id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        email: json['email'],
      );
}
