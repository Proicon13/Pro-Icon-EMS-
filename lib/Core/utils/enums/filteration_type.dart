enum FilterationType { newest, oldest, alphadesc, alphaasc }

extension FilterationTypeExtension on FilterationType {
  String get name {
    switch (this) {
      case FilterationType.newest:
        return "NEWEST";
      case FilterationType.oldest:
        return "OLDEST";
      case FilterationType.alphaasc:
        return "ALPHA-ASC";
      case FilterationType.alphadesc:
        return "ALPHA-DESC";
    }
  }
}
