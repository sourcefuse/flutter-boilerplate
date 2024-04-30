class NoteEntity {
  const NoteEntity(
    this.id,
    this.uid,
    this.title,
    this.description,
    this.priority,
    this.date,
    this.isDeleted,
  );

  final int? id;
  final String? uid;
  final String? title;
  final String? description;
  final int? priority;
  final DateTime? date;
  final bool? isDeleted;
}
