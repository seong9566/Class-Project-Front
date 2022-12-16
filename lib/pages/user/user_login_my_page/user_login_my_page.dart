import 'package:finalproject_front/constants.dart';
import 'package:finalproject_front/controller/user_controller.dart';
import 'package:finalproject_front/domain/user_session.dart';
import 'package:finalproject_front/pages/user/components/service_text.dart';
import 'package:finalproject_front/pages/user/user_login_my_page/model/user_login_my_page_model.dart';
import 'package:finalproject_front/pages/user/user_login_my_page/model/user_login_my_page_view_model.dart';
import 'package:finalproject_front/pages/user/user_update_page/user_update_page.dart';
import 'package:finalproject_front/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../components/bottom_image_box.dart';

class UserLoginMyPage extends ConsumerWidget {
  const UserLoginMyPage({Key? key}) : super(key: key);
  final String defaultProfile = "assets/defaultProfile.jpeg";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserLoginMyPageModel? model = ref.watch(userLoginMyPageViewModel);

    final userCT = ref.read(userController);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context, model, userCT),
    );
  }

  Widget _buildBody(BuildContext context, UserLoginMyPageModel? model, UserController userCT) {
    // 유저 이미지 가져오는데 잠깐 시간이 필요
    if (model == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserProfile(
                  context: context,
                  role: model.myPageRespDto.role,
                  username: model.myPageRespDto.username,
                  changeRole: "전문가",
                  profileImagePath: model.myPageRespDto.profileDto!.profilePhoto!,
                  userCT: userCT,
                  id: model.myPageRespDto.profileDto!.id!,
                  defaultProfile: defaultProfile,
                ),
                SizedBox(height: gap_l),
                Text(
                  "나의 서비스",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: gap_m),
                ServiceText(routePath: "/paymentInstallmentList", serviceText: "결제/취소 내역"),
                SizedBox(height: gap_m),
                ServiceText(routePath: "/userCoupon", serviceText: "쿠폰/프로모션"),
                SizedBox(height: gap_m),
                ServiceText(routePath: "/lessonClientList", serviceText: "수강중인 레슨"),
                SizedBox(height: gap_m),
                ServiceText(routePath: "/customerService", serviceText: "고객센터"),
                SizedBox(height: gap_m),
                ServiceText(routePath: "/lessonInsert", serviceText: "레슨 등록 전문가 "),
                SizedBox(height: gap_m),
                ServiceText(routePath: "/paymentSalesDetail", serviceText: "판매내역 전문가"),
                SizedBox(height: gap_m),
                ServiceText(routePath: "/lessonExpertList", serviceText: "등록한레슨 전문가"),
                SizedBox(height: gap_xxl),
                BottomImageBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1.0,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(
          CupertinoIcons.bell,
          color: Colors.black,
          size: 26,
        ),
      ),
      centerTitle: true,
      title: TextButton(
        onPressed: () {},
        child: Text(
          "로고",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 20),
          child: InkWell(
            onTap: () {
              // Navigator.pushNamed(context, "/userUpdate");

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserUpdatePage(
                            userInfo: UserSession.user,
                          )));
            },
            child: Text(
              "계정 설정",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildUserProfile(
    {required BuildContext context,
    required String role,
    required String username,
    required String changeRole,
    required String profileImagePath,
    required UserController userCT,
    required int id,
    required String defaultProfile}) {
  return Row(
    children: [
      InkWell(
          onTap: () {
            userCT.moveProfileInsertOrDetailPage(
              id: id,
              username: username,
            );
          },
          child: profileImagePath == ''
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Flexible(
                    child: Image.asset(
                      defaultProfile,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Flexible(
                    child: Image.asset(
                      profileImagePath,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
      SizedBox(width: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 15,
            decoration: BoxDecoration(
              color: gClientColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Text(
                role,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            username,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              // 전문가로 전환, 의뢰인으로전환
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: gBorderColor),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.person_2,
                      size: 18,
                      color: gPrimaryColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${changeRole}로 전환",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )
    ],
  );
}
