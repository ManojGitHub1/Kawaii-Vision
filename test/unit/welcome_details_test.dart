// Unit Testing

// Unit tests focus on verifying the smallest piece ot testable software. such as a
// function, method. or class. Your test suites should have more unit tests than other kinds
// tests.

import 'package:flutter_test/flutter_test.dart';
import 'package:kawaii_vision/screens/Welcome/mocks/welcome_details.dart';

void main() {

  test('test fetchAny', () {
    final welcomeDetails = WelcomeDetails.fetchAny();
    expect(welcomeDetails, isNotNull);
    expect(welcomeDetails.name, isNotEmpty);
  });

  test('test fetchAll', () {
    final welcomeDetails = WelcomeDetails.fetchAll();
    expect(welcomeDetails.length, greaterThan(0));
    expect(welcomeDetails[0].name, isNotEmpty);
  });

  test('test fetch', () {
    final welcomeDetails = WelcomeDetails.fetch(0);
    expect(welcomeDetails, isNotNull);
    expect(welcomeDetails.name, isNotEmpty);
  });

}


