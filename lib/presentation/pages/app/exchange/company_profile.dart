import 'package:auroim/presentation/common/auro_text.dart';
import 'package:auroim/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CompanyProfile extends StatelessWidget {
  CompanyProfile({Key key}) : super(key: key);

  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'Z2MyXuHstIs',
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  final Color goldColor = Color(0xffD8AF4F);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/c/cd/Facebook_logo_%28square%29.png",
                    height: 50,
                  ),
                  AuroText(
                    'User Review',
                    textType: TextType.headLine4,
                    color: Color(0xffD8AF4F),
                  ),
                ],
              ),
            ),
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AuroText(
                        'Testla Future of EV',
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        textType: TextType.headLine6,
                      ),
                      AuroText(
                        "18Apr'21",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        // textType: TextType.headLine5,
                      ),
                      AuroText(
                        'Short TP: 250',
                        color: Color(0xffD8AF4F),
                        textType: TextType.headLine6,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        AssetImage(Assets.rakeshJhunjhunwala),
                                    fit: BoxFit.cover)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AuroText(
                                'Username | Profession',
                                color: Colors.black,
                                textType: TextType.body2,
                              ),
                              AuroText(
                                'Conpany | Last University',
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                textType: TextType.body2,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    child: AuroText(
                                      '13k',
                                      color: goldColor,
                                      // fontWeight: FontWeight.w300,
                                      textType: TextType.body3,
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: goldColor, width: 2)),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(Assets.billGross),
                                            fit: BoxFit.cover)),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.privacy_tip_outlined,
                                      color: goldColor,
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: goldColor, width: 2)),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_upward_rounded,
                            color: Colors.blue,
                          ),
                          AuroText(
                            '4',
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            textType: TextType.body2,
                          ),
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.black,
                          )
                        ],
                      ),
                      Center(
                        child: AuroText(
                          '25% Downside\nleft',
                          color: Color(0xffD8AF4F),
                          // textType: TextType.headLine6,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AuroText(
                        'Testla Future of EV',
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        textType: TextType.headLine6,
                      ),
                      AuroText(
                        "18Apr'21",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        // textType: TextType.headLine5,
                      ),
                      AuroText(
                        'Short TP: 250',
                        color: Color(0xffD8AF4F),
                        textType: TextType.headLine6,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        AssetImage(Assets.rakeshJhunjhunwala),
                                    fit: BoxFit.cover)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AuroText(
                                'Username | Profession',
                                color: Colors.black,
                                textType: TextType.body2,
                              ),
                              AuroText(
                                'Conpany | Last University',
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                textType: TextType.body2,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    child: AuroText(
                                      '13k',
                                      color: goldColor,
                                      // fontWeight: FontWeight.w300,
                                      textType: TextType.body3,
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: goldColor, width: 2)),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(Assets.billGross),
                                            fit: BoxFit.cover)),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.privacy_tip_outlined,
                                      color: goldColor,
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: goldColor, width: 2)),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_upward_rounded,
                            color: Colors.blue,
                          ),
                          AuroText(
                            '4',
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            textType: TextType.body2,
                          ),
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.black,
                          )
                        ],
                      ),
                      Center(
                        child: AuroText(
                          '25% Downside\nleft',
                          color: Color(0xffD8AF4F),
                          // textType: TextType.headLine6,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      // child: null,
    );
  }
}
