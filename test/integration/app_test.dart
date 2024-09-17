// import 'package:flutter_test/flutter_test.dart';
// import 'package:network_image_mock/network_image_mock.dart';
// import 'package:kawaii_vision/app.dart';
// import 'package:kawaii_vision/screens/Welcome/mocks/welcome_details.dart';
//
// void main() {
//   testWidgets('test app startup', (WidgetTester tester) async {
//     mockNetworkImagesFor(() async {
//       // pumpWidget means iteration of time
//       // inject the widget
//       await tester.pumpWidget(MyApp());
//
//       final welcomeDetails = WelcomeDetails.fetchAny();
//       expect(find.text(welcomeDetails.name), findsOneWidget);
//       expect(find.text('${welcomeDetails.name}blah'), findsNothing);
//
//     });
//   });
// }