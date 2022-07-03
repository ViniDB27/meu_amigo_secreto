class MemberEntity {
  final String name;
  final String email;
  final String? imageUrl;

  MemberEntity({
    required this.name,
    required this.email,
    this.imageUrl,
  });
}
