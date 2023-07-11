//import 'dart:async';

import 'package:aboutmy_team/detailpage.dart';
import 'package:aboutmy_team/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E1I4에 대하여'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          // Align 이랑 ListView를 나란히 놓기 위해 부모 위젯으로 감쌌습니당~!
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    const url =
                        'https://marble-teacher-477.notion.site/11-S-A-c968936e1ac745b6a2a1d1dc59d9fcf6?pvs=4';
                    launchURL(url);
                  },
                  child: Text(
                    'E1I4가 궁금하시다면?',
                    style: TextStyle(fontSize: 24, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // 필요에 따라 공간 추가
            Expanded(
              child: ListView.separated(
                // 리스트로 넣는거 실패해서 itemCount 총 5개로 작업
                itemCount: 5,
                itemBuilder: (context, index) {
                  // GestureDetector는 사용자 동작을 감시하는 코드임(대충 클릭하면 어떻게 하겠다 조건을 지정하는 코드)
                  return GestureDetector(
                    onTap: () {
                      // Feed를 눌렀을 때 DetailPage로 이동하는 코드
                      // !!!!! 상세페이지 작업 시 ListView의 index 값에 따라 다른 값을 보여줘야 함 !!!!!
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage()));
                    },
                    child: Feed(
                      // 각 arguments의 값을 지정하여, index 위치에 맞게 대입(? 맞으면 값, : 아니면 값)
                      imageUrl: index == 2
                          ? 'https://teamsparta.notion.site/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fb9308949-ab1a-4a06-8258-f1b6f60cce90%2FEBE8BF9D-5BD7-4AD4-8FC4-84157068BC52.jpeg?id=26769fd9-5881-44f4-90fb-84c279204552&table=block&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&width=1310&userId=&cache=v2'
                          : 'https://geojecci.korcham.net/images/no-image01.gif',
                      name: index == 0
                          ? '한동연'
                          : index == 1
                              ? '김서진'
                              : index == 2
                                  ? '김서온'
                                  : index == 3
                                      ? '정기현'
                                      : '차재영',
                      mbti: index == 0
                          ? 'INTP'
                          : index == 1
                              ? 'ISFP'
                              : index == 2
                                  ? 'ENTP'
                                  : index == 3
                                      ? 'INFP'
                                      : 'ISTP',
                      ambition: index == 0
                          ? '공부는 마라톤'
                          : index == 1
                              ? '열심히 허자'
                              : index == 2
                                  ? '나는 끝까지 살아남을꺼야'
                                  : index == 3
                                      ? '포기하지 말자'
                                      : '하면된다',
                      role: index == 0 ? '팀장' : '팀원',
                    ),
                  );
                },
                // 각 Feed 들을 구분하기 위해서 Divider 추가
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// Feed 클래스 지정(상기 body에 넣기에는 코드가 길어져서 class로 뺌)

class Feed extends StatelessWidget {
  const Feed({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.mbti,
    required this.ambition,
    required this.role,
  }) : super(key: key);

  final String imageUrl;
  final String name;
  final String mbti;
  final String ambition;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10), // 사진 테두리 둥글게
          child: Image.network(
            imageUrl,
            width: 130,
            height: 130,
            fit: BoxFit.cover, // 위에 가로세로(Box)에 맞춤, 나머지 자르기
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                mbti,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                ambition,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Spacer(),
                  Text(
                    role,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
