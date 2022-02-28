class DateToStringConverter {
  static String convert(DateTime date) {
    var splittedDate = date.toString().split(' ');

    return splittedDate.first;
  }
}