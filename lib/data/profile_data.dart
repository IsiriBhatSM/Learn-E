/// A singleton class to store and manage user profile data globally.
class Profile {
  static String? username;
  static String? email;
  static String? dob;

  /// Updates the profile data with new values.
  static void updateProfile({String? username, String? email, String? dob}) {
    Profile.username = username;
    Profile.email = email;
    Profile.dob = dob;
  }
}