import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'FactoryData.dart';
import 'MyLoading.dart';
import 'User.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RefreshController refreshController = RefreshController(initialRefresh: true);

  List<User> users = [];

  getUsers() async {
    setState(() {
      users.clear();
    });
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      users.addAll(FactoryData.users);
    });
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Refresh Indicator"),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body: SmartRefresher(
        controller: refreshController,
        header: WaterDropHeader(
          waterDropColor: Colors.green.shade700,
          refresh: MyLoading(),
          complete: Container(),
          completeDuration: Duration.zero,
        ),
        onRefresh: () => getUsers(),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) =>
              item(users[index]),
        ),
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
        placeholder: (context, url) => SizedBox(
          height: 40,
          width: 40,
          child: MyLoading(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      onTap: () {},
    );
  }
}
