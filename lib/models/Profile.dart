class Profile {
  final String name;
  final DateTime birthdate;
  final int age;

  Profile({required this.name, required this.birthdate, required this.age});

  factory Profile.fromBirthdate(String name, DateTime birthdate) {
    final now = DateTime.now();
    int age = now.year - birthdate.year;
    if (now.month < birthdate.month || (now.month == birthdate.month && now.day < birthdate.day)) {
      age--;
    }
    return Profile(name: name, birthdate: birthdate, age: age);
  }
}
