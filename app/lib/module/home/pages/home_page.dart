import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:send_zap/components/core/socket/socket_store.dart';
import 'package:send_zap/module/contato/pages/contato_page.dart';
import 'package:send_zap/module/home/pages/home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SocketStore socketStore = Modular.get();

  final viewKey = GlobalKey();

  int index = 0;

  @override
  void initState() {
    socketStore.connectAndListen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      key: viewKey,
      appBar: NavigationAppBar(
        leading: SizedBox(),
        title: Text(
          "Send zap™",
          // style: FluentTheme.of(context).typography.subtitle,
        ),
      ),
      pane: NavigationPane(
        scrollController: ScrollController(),
        selected: index,
        onChanged: (value) {
          setState(() {
            index = value;
          });
        },
        displayMode: PaneDisplayMode.open,
        footerItems: [
          PaneItem(
            tileColor: ButtonState.all(Colors.red),
            icon: Icon(FluentIcons.sign_out),
            title: Text("Cerrar sesión"),
            body: Button(
                onPressed: () {
                  socketStore.logout();
                  Modular.to.pushReplacementNamed("/");
                },
                child: Text("logout")),
          ),
        ],
        items: [
          PaneItem(
            key: ValueKey("home"),
            icon: Icon(FluentIcons.home),
            title: Text("Home"),
            body: HomeView(),
          ),
          PaneItem(
            key: ValueKey("contatos"),
            icon: Icon(FluentIcons.contact_list),
            title: Text("Contactos"),
            body: ContatoPage(),
          ),
          PaneItem(
            key: ValueKey("settings"),
            icon: Icon(FluentIcons.settings),
            title: Text("Configuraciones"),
            body: HomePage(),
          ),
        ],
      ),
    );
  }
}
