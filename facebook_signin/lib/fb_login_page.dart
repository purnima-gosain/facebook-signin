import 'package:facebook_signin/facebook_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FacebookLoginPage extends StatefulWidget {
  const FacebookLoginPage({Key? key}) : super(key: key);

  @override
  State<FacebookLoginPage> createState() => _FacebookLoginPageState();
}

class _FacebookLoginPageState extends State<FacebookLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Facebook Login"),
      ),
      body: loginUI(),
    );
  }

  loginUI() {
    return Consumer<FacebookSignInController>(builder: (context, model, child) {
      if (model.userData != null) {
        return Center(child: loggedinUI(model, context));
      } else {
        return loginControls(context);
      }
    });
  }
}

loginControls(BuildContext context) {
  return Center(
    child: GestureDetector(
        onTap: () {
          Provider.of<FacebookSignInController>(context, listen: false).login();
        },
        child: Image.asset(
          "assets/images/fb.png",
          width: 250,
        )),
  );
}

loggedinUI(FacebookSignInController model, BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage:
            NetworkImage(model.userData!['picture']["data"]["url"] ?? ''),
        radius: 50,
      ),
      Text(model.userData!["name"] ?? ''),
      Text(model.userData!["email"]),
      ActionChip(
          avatar: const Icon(Icons.logout),
          label: const Text("Logout"),
          onPressed: () {
            Provider.of<FacebookSignInController>(context, listen: false)
                .logOut();
          })
    ],
  );
}
