import 'dart:convert';

import 'package:aboutmy_team/main.dart';
import 'package:flutter/cupertino.dart';

class Profile {
  Profile({
    required this.photo,
    required this.name,
    required this.mbti,
    required this.blog,
    required this.mytype,
    required this.content,
    required this.role,
  });
  String photo;
  String name;
  String mbti;
  String blog;
  String mytype;
  String content;
  String role;

  Map toJson() {
    return {
      'photo': photo,
      'name': name,
      'mbti': mbti,
      'blog': blog,
      'mytype': mytype,
      'content': content,
      'role': role
    };
  }

  factory Profile.fromJson(json) {
    return Profile(
      photo: json['photo'],
      name: json['name'],
      mbti: json['mbti'],
      blog: json['blog'],
      mytype: json['mytype'],
      content: json['content'],
      role: json['role'],
    );
  }
}

class ProfileService extends ChangeNotifier {
  ProfileService() {
    loadProfileList();
  }
  List<Profile> profileList = [
    Profile(
        photo:
            'https://teamsparta.notion.site/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F4a0d8a40-2588-41ae-8ffe-5bf3669ac172%2F%25E1%2584%2589%25E1%2585%25A1%25E1%2584%258C%25E1%2585%25B5%25E1%2586%25AB1.jpeg?id=7c16ca4c-b236-475b-81e8-1d420f6a6ecc&table=block&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&width=770&userId=&cache=v2',
        name: '한동연',
        mbti: 'INTP',
        blog: 'https://progressing.tistory.com/',
        mytype: '공부는 마라톤',
        content: '',
        role: '팀장'),
    Profile(
        photo:
            'https://teamsparta.notion.site/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fab88139e-5271-4fea-8351-4e4f5b14ba6f%2FP20220604_104815455_D6916FE2-B4AD-482A-9FB0-265D7382A3DF.jpg?id=a8c97967-9f74-46a0-ba4e-b1059a25bc2f&table=block&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&width=1470&userId=&cache=v2',
        name: '김서진',
        mbti: 'ISFP',
        blog: 'https://zzin2990.tistory.com',
        mytype: '열심히 허자',
        content: '',
        role: '팀원'),
    Profile(
        photo:
            'https://teamsparta.notion.site/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fb9308949-ab1a-4a06-8258-f1b6f60cce90%2FEBE8BF9D-5BD7-4AD4-8FC4-84157068BC52.jpeg?id=26769fd9-5881-44f4-90fb-84c279204552&table=block&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&width=1310&userId=&cache=v2',
        name: '김서온',
        mbti: 'ENTP',
        blog: 'https://ahrzosel.tistory.com/',
        mytype: '나는 끝까지 살아남을꺼야',
        content: '',
        role: '팀원'),
    Profile(
        photo:
            'https://teamsparta.notion.site/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fffb89613-e223-4821-b622-80a54008f8a0%2FIMG_5017.jpeg?id=a4ab7c71-9341-43cc-b074-0232752ea4bd&table=block&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&width=1470&userId=&cache=v2',
        name: '정기현',
        mbti: 'INFP',
        blog: 'https://jkh0013011.tistory.com/',
        mytype: '포기하지 말자',
        content: '',
        role: '팀원'),
    Profile(
        photo:
            'https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fcb494485-040b-4e51-bdd7-6da8b181f7fe%2FIMG_2340.jpg?table=block&id=c38d7a52-480e-4d6f-827b-12c2c54789ac&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&width=2000&userId=d9553ac5-8812-493f-8f95-44a8126a6728&cache=v2',
        name: '차재영',
        mbti: 'ISTP',
        blog: 'https://jblog1229.tistory.com/',
        content: '',
        mytype: '하면된다',
        role: '팀원'),
  ];

  createProfile(
      {required String photo,
      required String name,
      required String mbti,
      required String blog,
      required String mytype,
      required String content,
      required String role}) {
    Profile memo = Profile(
        photo: photo,
        name: name,
        mbti: mbti,
        blog: blog,
        mytype: mytype,
        content: content,
        role: role);
    profileList.add(memo);
    notifyListeners(); // Consumer<MemoService>의 builder 부분을 호출해서 화면 새로고침
    saveProfileList();
  }

  updateProfile({required int index, required String content}) {
    Profile memo = profileList[index];
    memo.content = content;
    notifyListeners(); // Consumer<MemoService>의 builder 부분을 호출해서 화면 새로고침
    saveProfileList();
  }

  deleteProfile({required int index}) {
    profileList.removeAt(index);
    notifyListeners();
    saveProfileList();
  }

  saveProfileList() {
    List profileJsonList = profileList.map((memo) => memo.toJson()).toList();

    String jsonString = jsonEncode(profileJsonList);

    prefs.setString('profileList', jsonString);
  }

  loadProfileList() {
    String? jsonString = prefs.getString('profileList');

    if (jsonString == null) return; // null 이면 로드하지 않음

    List profileJsonList = jsonDecode(jsonString);

    profileList =
        profileJsonList.map((json) => Profile.fromJson(json)).toList();
  }

  int get length => profileList.length;
}
