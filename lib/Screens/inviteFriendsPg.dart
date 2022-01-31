import 'package:crush/Constants/constants.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class InviteFriendsPg extends StatefulWidget {
  final String? user_id;
  const InviteFriendsPg({Key? key, required this.user_id}) : super(key: key);

  @override
  State<InviteFriendsPg> createState() => _InviteFriendsPgState();
}

class _InviteFriendsPgState extends State<InviteFriendsPg> {
  Future<Uri> createDynamicLink({required String? user_id}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      // This should match firebase but without the username query param
      // This can be whatever you want for the uri, https://yourapp.com/groupinvite?username=$userName
      link: Uri.parse(
          'https://ranaca.page.link/crush?userid=$user_id&isInvite=true'),
      androidParameters: AndroidParameters(
        packageName: 'com.ranaca.crush',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.ranaca.crush',
        minimumVersion: '1',
        appStoreId: '',
      ),
      uriPrefix: 'https://ranaca.page.link',
    );
    final link = await parameters.buildUrl();
    final ShortDynamicLink shortenedLink =
        await DynamicLinkParameters.shortenUrl(
      link,
      DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );
    return shortenedLink.shortUrl;
  }

  onShareWithEmptyOrigin(BuildContext context) async {
    var dlink = await createDynamicLink(user_id: widget.user_id);
    await Share.share(
        "Join the Crush App for better dating experience. ${dlink}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/wallpaper.jpg'),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    height: 80,
                    width: 250,
                    child: Text(
                      'Invite Your Friends and Earn 10 Coins',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    width: 320,
                    height: 50,
                    child: FlatButton(
                        color: appThemeColor,
                        onPressed: () {
                          setState(() {
                            onShareWithEmptyOrigin(context);
                          });
                        },
                        child: Text(
                          'Refer People !',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
