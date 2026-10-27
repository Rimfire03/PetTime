import 'package:flutter_test/flutter_test.dart';
import 'package:pettime/backup.dart';
import 'package:pettime/photos.dart';

void main() {
  test('restore rejects files that are not PetTime backups', () {
    expect(restoreBackup({'format': 'other', 'version': 1}), throwsFormatException);
    expect(restoreBackup({}), throwsFormatException);
  });

  test('restore rejects a newer format version', () {
    expect(restoreBackup({'format': 'pettime-backup', 'version': 99}), throwsFormatException);
  });

  test('photo names from a backup cannot escape the photo folder', () {
    expect(isValidPhotoName('1700000000000000.jpg'), isTrue);
    expect(isValidPhotoName('../evil.jpg'), isFalse);
    expect(isValidPhotoName('a/b.jpg'), isFalse);
    expect(isValidPhotoName('x.exe'), isFalse);
  });
}
