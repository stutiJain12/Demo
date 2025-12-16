import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  String phone;

  @HiveField(3)
  DateTime timestamp;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.timestamp,
  });

  // Convert to JSON (Optional)
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'timestamp': timestamp.toIso8601String(),
      };

  // Convert from JSON
  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}
