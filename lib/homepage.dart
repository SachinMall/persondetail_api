import 'package:flutter/material.dart';
import 'package:persondetail_api/person_detail_api.dart';

import 'const.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var PersonDetailList = [];
  bool isloading = false;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    getList();
  }

  getList() async {
    setState(() {
      isloading = true;
    });
    PersonDetailAPI().getList().then((value) {
      if (value != null) {
        setState(() {
          PersonDetailList = value;
          isloading = false;
        });
      } else {
        setState(() {
          PersonDetailList = [];
          isloading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          title: Text("BioData"),
          centerTitle: true,
        ),
        body: isloading
            ? Center(child: CircularProgressIndicator(),) 
            : PersonDetailList.isEmpty
                ? Text("No Data")
                : ListView.builder(
                    itemCount: PersonDetailList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(10),
                        height: 255,
                        color: Colors.grey.withOpacity(0.1),
                        child: Row(
                          children: [
                            Image.network(
                              PersonDetailList[index].image.toString(),
                              fit: BoxFit.contain,
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Name: ${PersonDetailList[index].name.toString()}"),
                                  height5,
                                  Text(
                                      "Username: ${PersonDetailList[index].username.toString()}"),
                                  height5,
                                  Text(
                                      "Contact: ${PersonDetailList[index].phone}"),
                                  height5,
                                  Text(
                                      "Email: ${PersonDetailList[index].email.toString()}"),
                                  height5,
                                  Text(
                                    "Address: ${PersonDetailList[index].address?.street}, ${PersonDetailList[index].address?.suite}, ${PersonDetailList[index].address?.city}, ${PersonDetailList[index].address?.zipcode}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  height5,
                                  Text(
                                      "GeoLocation:- Latitude : ${PersonDetailList[index].address?.geo?.lat} , Lontitude : ${PersonDetailList[index].address?.geo?.lng}"),
                                  height5,
                                  Text(
                                      "website: ${PersonDetailList[index].website}"),
                                  height5,
                                  Text(
                                      "Organisation Details:- Org. Name: ${PersonDetailList[index].company?.name.toString()} , catchPhrase: ${PersonDetailList[index].company?.catchPhrase.toString()} , Bs: ${PersonDetailList[index].company?.bs}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ));
  }
}
