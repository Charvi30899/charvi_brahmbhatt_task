mixin ValidatorMixin {
  bool adultAgeValidator(String? age) {
    if (age != null && age.isNotEmpty) {
      var adult = int.parse(age);
      if (adult < 18 || adult == 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  bool childAgeValidator(String? age) {
    if (age != null && age.isNotEmpty) {
      var child = int.parse(age);
      if (child > 18 || child == 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  bool requiredInput(String? person) {
    if (person == null || person.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
