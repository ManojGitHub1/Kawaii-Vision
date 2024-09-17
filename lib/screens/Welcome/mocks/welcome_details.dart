
// ignore_for_file: prefer_const_constructors

import 'package:camera/camera.dart';
import 'package:kawaii_vision/project_screens/Quizzler/quizzler.dart';
import 'package:kawaii_vision/project_screens/image_picker_display.dart';
import 'package:kawaii_vision/project_screens/live_camera_feed.dart';

import '../models/welcome_details_fetch.dart';


class WelcomeDetails extends Location {

  WelcomeDetails({required super.name, required super.url, required super.urlDocs, required super.Myname,
    required super.Mydesc, required super.projectPath, required super.facts,});

  static final List<Location> items = [
    Location(
        name: 'Quizzler',
        url: 'https://www.asisbiz.com/Japan/Kinkaku-ji/images/0-Postcards-Kinkaku-ji-Winter.jpg',
        urlDocs: 'https://en.wikipedia.org/wiki/Quiz',
        Myname: 'By Manoj Jivanagi',
        Mydesc: '8th Oct 23',
        projectPath: Quizzler(),
        facts: <LocationFact>[
          LocationFact(
              title: 'A Qame app',
              text: 'Test your Knowledge skill\'s by taking a Quiz.'),
          LocationFact(
              title: 'How to Play',
              text: 'It\'s very Simple. Just Press True if you think that\'s the Answer else False.')
        ]),
    Location(
        name: 'Arashiyama Bamboo Grove',
        url: 'https://cdn-images-1.medium.com/max/2000/1*vdJuSUKWl_SA9Lp-32ebnA.jpeg',
        urlDocs: 'https://en.wikipedia.org/wiki/Quiz',
        Myname: 'By Manoj Jivanagi',
        Mydesc: '15th Sept 24',
        projectPath: ImagePickerDisplay(),
        facts: <LocationFact>[
          LocationFact(
              title: 'Summary',
              text: 'While we could go on about the ethereal glow and seemingly endless heights of this bamboo grove on the outskirts of Kyoto, the sight\'s pleasures extend beyond the visual realm'),
          LocationFact(
              title: 'How to Get There',
              text: 'Kyoto airport, with several terminals, is located 16 kilometres south of the city and is also known as Kyoto. Kyoto airport, with several terminals, is located 16 kilometres south of the city and is also known as Kyoto. Kyoto can also be reached by transport links from other regional airports.')
        ]),
    Location(
        name: 'Mount Fuji',
        url: 'https://img3.goodfon.ru/original/1920x1080/a/a5/fuji-peizazh-iaponiia-gora-tsvety-nebo.jpg',
        urlDocs: 'https://en.wikipedia.org/wiki/Quiz',
        Myname: 'By Manoj Jivanagi',
        Mydesc: '15th Sept 24',
        projectPath: LiveCameraFeed(),
        facts: <LocationFact>[
          LocationFact(
              title: 'Summary',
              text: 'While we could go on about the ethereal glow and seemingly endless heights of this bamboo grove on the outskirts of Kyoto, the sight\'s pleasures extend beyond the visual realm'),
          LocationFact(
              title: 'How to Get There',
              text: 'Kyoto airport, with several terminals, is located 16 kilometres south of the city and is also known as Kyoto. Kyoto can also be reached by transport links from other regional airports.')
        ]),
    Location(
        name: 'Kiyomizu-dera',
        url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Kiyomizu-dera_in_Kyoto-r.jpg/800px-Kiyomizu-dera_in_Kyoto-r.jpg',
        urlDocs: 'https://en.wikipedia.org/wiki/Quiz',
        Myname: 'By Manoj Jivanagi',
        Mydesc: '15th Sept 24',
        projectPath: Quizzler(),
        facts: <LocationFact>[
          LocationFact(
              title: 'Summary',
              text: 'While we could go on about the ethereal glow and seemingly endless heights of this bamboo grove on the outskirts of Kyoto, the sight\'s pleasures extend beyond the visual realm'),
          LocationFact(
              title: 'How to Get There',
              text: 'Kyoto airport, with several terminals, is located 16 kilometres south of the city and is also known as Kyoto. Kyoto can also be reached by transport links from other regional airports.')
        ]),
    Location(
        name: 'Kinkaku-ji',
        url: 'https://www.asisbiz.com/Japan/Kinkaku-ji/images/0-Postcards-Kinkaku-ji-Winter.jpg',
        urlDocs: 'https://en.wikipedia.org/wiki/Quiz',
        Myname: 'By Manoj Jivanagi',
        Mydesc: '15th Sept 24',
        projectPath: Quizzler(),
        facts: <LocationFact>[
          LocationFact(
              title: 'Summary',
              text: 'While we could go on about the ethereal glow and seemingly endless heights of this bamboo grove on the outskirts of Kyoto, the sight\'s pleasures extend beyond the visual realm'),
          LocationFact(
              title: 'How to Get There',
              text: 'Kyoto airport, with several terminals, is located 16 kilometres south of the city and is also known as Kyoto. Kyoto can also be reached by transport links from other regional airports.')
        ]),
    Location(
        name: 'Odaiba',
        url: 'https://www.yhunter.ru/wp-content/uploads/2015/06/DSC1876.jpg',
        urlDocs: 'https://en.wikipedia.org/wiki/Quiz',
        Myname: 'By Manoj Jivanagi',
        Mydesc: '15th Sept 24',
        projectPath: Quizzler(),
        facts: <LocationFact>[
          LocationFact(
              title: 'Summary',
              text: 'While we could go on about the ethereal glow and seemingly endless heights of this bamboo grove on the outskirts of Kyoto, the sight\'s pleasures extend beyond the visual realm'),
          LocationFact(
              title: 'How to Get There',
              text: 'Kyoto airport, with several terminals, is located 16 kilometres south of the city and is also known as Kyoto. Kyoto can also be reached by transport links from other regional airports.')
        ]),
  ];

  static Location fetchAny() {
    return WelcomeDetails.items[0];
  }

  static List<Location> fetchAll() {
    return WelcomeDetails.items;
  }


  // In ws_screen we are passing a entire object assuming that object has all the details and its working
  // But in real world we pass something lighter like id. as a web_serves. and testing is done on that
  // Used in ws
  static Location fetch(int index) {
    return WelcomeDetails.items[index];
  }

}
