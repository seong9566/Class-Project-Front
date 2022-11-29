import 'package:finalproject_front/pages/sign/join_division_page/components/division_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class JoinDivisionPage extends StatelessWidget {
  const JoinDivisionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "어떤 서비스를 이용하고 싶으신가요?",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "원하는 회원가입 유형을 선택하세요.\n의뢰인으로 가입 후에도 전문가 등록이 가능합니다.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color(0xff6C6C6C),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 300),
              DivisionButton(title: "의뢰인으로 가입", subtitle: "비즈니스 외주,아웃소싱을 원한다면"),
              SizedBox(height: 20),
              DivisionButton(title: "전문가로 가입", subtitle: "전문성으로 수익창출을 원한다면"),
            ],
          ),
        ),
      ),
    );
  }
}
