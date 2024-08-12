class AddUser {
  final String id, firstname, address, lastname, email, password;

  AddUser({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstname': firstname,
        'lastname': lastname,
        'address': address,
        'email': email,
      };
}
