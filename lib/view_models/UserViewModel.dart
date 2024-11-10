class UserViewModel {
  final String id;
  final String email;
  final String username;
  final List<String> roles;
  final Map<String, dynamic> geo;

  UserViewModel({
    required this.id,
    required this.email,
    required this.username,
    required this.roles,
    required this.geo,
  });

  // Factory constructor to create an instance from JSON
  factory UserViewModel.fromJson(Map<String, dynamic> json) {
    return UserViewModel(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      roles: List<String>.from(json['roles'] as List),
      geo: json['geo'] as Map<String, dynamic>,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'roles': roles,
      'geo': geo,
    };
  }
}
