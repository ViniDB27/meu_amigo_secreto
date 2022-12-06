import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../../core/shared/routes/app_routes.dart';
import '../../../core/shared/widgets/app_drawer_widget.dart';
import '../../../core/shared/widgets/notification_button_widget.dart';
import '../controller/home_controller.dart';
import '../widgets/group_card_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.fullBanner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  @override
  void initState() {
    super.initState();

    myBanner.load();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeController>(context, listen: false).getMyGroups(context);
    });
  }

  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Meu amigo secreto'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: const [
          NotificationButton(),
        ],
      ),
      drawer: const AppDrawer(),
      body: SizedBox(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 60,
              width: mediaQuery.size.width,
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Center(
                child: AdWidget(
                  ad: myBanner,
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => controller.getMyGroups(context),
                child: controller.loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.groups.length,
                        itemBuilder: (_, i) =>
                            GroupCard(group: controller.groups[i]),
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Modular.to.pushNamed(AppRoutes.createGroup),
        tooltip: 'Criar grupo',
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }
}
