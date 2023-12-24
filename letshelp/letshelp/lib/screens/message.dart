import 'package:flutter/material.dart';
import 'package:letshelp/screens/privatmessag.dart';
import '../theme/colors.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  get id => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kTeal400,
            title: Text(
              "الرسائل ",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            Dismissible(
                key: ValueKey(id),
                background: Container(
                  color: Theme.of(context).errorColor,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 40,
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  margin: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 4,
                  ),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {},
                child: Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 4,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .13,
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: FittedBox(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    "assets/images/images-2.jpg",
                                    height: 200,
                                    width: 200,
                                  )),
                            ),
                          ),
                        ),
                        title: Text(
                          'أنس التدمري',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: TextButton(
                            onPressed: () {
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PrivatMessage()));
                              }
                              ;
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .03,
                                ),
                                Text(
                                  'مرحبا   ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            )),
                        trailing: Text(
                          '2/2/2022',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ));
  }
}
