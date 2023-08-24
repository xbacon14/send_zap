import 'package:device_frame/device_frame.dart';
import 'package:fluent_ui/fluent_ui.dart';

class WhatsappCloneUi extends StatefulWidget {
  const WhatsappCloneUi({
    Key? key,
    required this.textVisualizacao,
  }) : super(key: key);

  final TextEditingController textVisualizacao;

  @override
  State<WhatsappCloneUi> createState() => _WhatsappCloneUiState();
}

class _WhatsappCloneUiState extends State<WhatsappCloneUi> {
  @override
  Widget build(BuildContext context) {
    return DeviceFrame(
      device: Devices.ios.iPhone13,
      screen: Container(
        color: Colors.white,
        child: Builder(
          builder: (context) => FluentApp(
            // useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
            color: Colors.white,
            home: ScaffoldPage(
              header: ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FluentIcons.chevron_left,
                      size: 24,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                trailing: Row(children: [
                  IconButton(
                    icon: Icon(FluentIcons.video, size: 16),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(FluentIcons.phone, size: 16),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(FluentIcons.more_vertical, size: 16),
                    onPressed: () {},
                  ),
                ]),
                title: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/whatsapp/profile.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "FLEX TECH",
                          style: FluentTheme.of(context)
                              .typography
                              .bodyLarge!
                              .copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Active Now",
                              style: TextStyle(
                                color: Colors.grey.withOpacity(.6),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              content: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/whatsapp/background.png"))),
                    child: ListView(
                      padding: EdgeInsets.all(20),
                      children: List.generate(
                        1,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 240),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE3FED3),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: Text(
                                        widget.textVisualizacao.text,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        color: Colors.white,
                        height: 60,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .6,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: TextBox(
                                        enabled: false,
                                        focusNode: FocusNode(),
                                        cursorColor: Colors.black,
                                        decoration: BoxDecoration(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 12),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Icon(
                                      FluentIcons.microphone,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Container(
                                    padding: EdgeInsets.only(right: 5),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      FluentIcons.camera,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 5),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      FluentIcons.send,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 16,
                      ),
                      Divider(
                        size: 200,
                        direction: Axis.horizontal,
                        style: DividerThemeData(
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.black),
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
