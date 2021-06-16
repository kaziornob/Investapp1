import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PractionarsScreen extends StatelessWidget {
  const PractionarsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              backButton(context),
              Center(
                child: Image.asset(
                  'assets/auro_edu.png',
                  width: MediaQuery.of(context).size.width * 0.60,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.asset(
                                'assets/person_avatar.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sarab Anand',
                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis, sed aliquet pellentesque quis.',
                                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                    return ListTile(
                      isThreeLine: true,
                      title: Text(
                        'Sarab Anand',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
                      ),
                      subtitle: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis, sed aliquet pellentesque quis.',
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.black),
                      ),
                      leading: Container(
                        alignment: Alignment.center,
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.grey,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset(
                            'assets/person_avatar.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget backButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
