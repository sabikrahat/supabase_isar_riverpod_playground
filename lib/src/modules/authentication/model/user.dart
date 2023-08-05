import 'dart:convert';

part 'user.ext.dart';

class PktbsUser {
  String name;
  bool verified;
  String? avatar;
  final String id;
  DateTime? updated;
  final String email;
  bool emailVisibility;
  final String username;
  final DateTime created;
  final String collectionId;
  final String collectionName;

  PktbsUser({
    this.avatar,
    this.updated,
    required this.id,
    required this.name,
    required this.email,
    required this.created,
    required this.verified,
    required this.username,
    required this.collectionId,
    required this.collectionName,
    required this.emailVisibility,
  });

  factory PktbsUser.fromJson(Map<String, dynamic> json) {
    return PktbsUser(
      id: json[_Json.id],
      name: json[_Json.name],
      email: json[_Json.email],
      avatar: json[_Json.avatar],
      verified: json[_Json.verified],
      username: json[_Json.username],
      collectionId: json[_Json.collectionId],
      updated: json[_Json.updated] == null
          ? null
          : DateTime.parse(json[_Json.updated]),
      collectionName: json[_Json.collectionName],
      emailVisibility: json[_Json.emailVisibility],
      created: DateTime.parse(json[_Json.created]),
    );
  }

  factory PktbsUser.fromRawJson(String str) =>
      PktbsUser.fromJson(json.decode(str));

  @override
  String toString() =>
      'PktbsUser(id: $id, name: $name, email: $email, avatar: $avatar, created: $created, updated: $updated, verified: $verified, username: $username, collectionId: $collectionId, collectionName: $collectionName, emailVisibility: $emailVisibility)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PktbsUser && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _Json {
  static const id = 'id';
  static const name = 'name';
  static const email = 'email';
  static const avatar = 'avatar';
  static const created = 'created';
  static const updated = 'updated';
  static const username = 'username';
  static const verified = 'verified';
  static const collectionId = 'collectionId';
  static const collectionName = 'collectionName';
  static const emailVisibility = 'emailVisibility';
}
