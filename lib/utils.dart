class Utils {
  int oldness() {
    DateTime now = DateTime.now();
    DateTime birthday = DateTime(1997, 5, 30);
    int oldness = now.year - birthday.year - 1;
    if (now.month > birthday.month) {
      oldness += 1;
    } else if ((now.month == birthday.month) && (now.day >= birthday.day)) {
      oldness += 1;
    }
    return oldness;
  }
}
