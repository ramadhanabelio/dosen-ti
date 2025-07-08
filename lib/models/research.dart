class Research {
  final int id;
  final String title;
  final String? abstract;
  final String? field;
  final String? year;
  final String? document;

  Research({
    required this.id,
    required this.title,
    this.abstract,
    this.field,
    this.year,
    this.document,
  });

  factory Research.fromJson(Map<String, dynamic> json) {
    return Research(
      id: json['id'],
      title: json['title'],
      abstract: json['abstract'],
      field: json['field'],
      year: json['year']?.toString(),
      document: json['document'],
    );
  }
}
