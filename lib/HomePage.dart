import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'FactoryData.dart';
import 'User.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Refresh Indicator"),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: FactoryData.users.length,
        itemBuilder: (BuildContext context, int index) =>
            item(FactoryData.users[index]),
      ),
    );
  }

  Widget item(User user) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: user.photo,
        imageBuilder: (context, imageProvider) => Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      onTap: () {},
    );
  }
}
