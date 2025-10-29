import 'dart:convert';
import 'dart:math';

class PasswordUtils {
  // Simple password hashing (in production, use proper hashing like bcrypt)
  static String hashPassword(String password) {
    // This is a simple hash for demonstration
    // In production, use proper password hashing like bcrypt
    var bytes = utf8.encode(password);
    var digest = bytes.fold(0, (prev, element) => prev + element);
    return digest.toString();
  }

  // Generate a simple salt (in production, use proper salt generation)
  static String generateSalt() {
    var random = Random();
    var salt = List.generate(16, (index) => random.nextInt(256));
    return base64.encode(salt);
  }

  // Hash password with salt
  static String hashPasswordWithSalt(String password, String salt) {
    var combined = password + salt;
    var bytes = utf8.encode(combined);
    var digest = bytes.fold(0, (prev, element) => prev + element);
    return digest.toString();
  }
}
