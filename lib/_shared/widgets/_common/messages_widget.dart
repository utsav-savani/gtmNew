import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:equatable/equatable.dart';

class MessagesWidget extends StatefulWidget {
  const MessagesWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MessagesWidget> createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {
  // TODO: retrieve messages, trip, and company name
  String selectedTripNumber = "";
  //TODO: Company name should be dynamic
  String currentCompanyName = "ABC Aviation";
  List<Message> messageList = [];

  var doSearch = false;
  var message1 = Message(
    message:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
    isMine: true,
    sender: "jimmy",
    received: DateTime.now(),
  );
  var message2 = Message(
    message:
        " It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ",
    isMine: false,
    sender: "jimmy",
    received: DateTime.now(),
  );
  var message3 = Message(
    message:
        " It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    isMine: true,
    sender: "jimmy",
    received: DateTime.now(),
  );
  var message4 = Message(
    message:
        "Contrary to popular belief, Lorem Ipsum is not simply random text.",
    isMine: false,
    sender: "jimmy",
    received: DateTime.now(),
  );
  var message5 = Message(
    message:
        "It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
    isMine: false,
    sender: "jimmy",
    received: DateTime.now(),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    messageList.add(message1);
    messageList.add(message2);
    messageList.add(message3);
    messageList.add(message4);
    messageList.add(message5);
    messageList.add(message1);
    messageList.add(message2);
    messageList.add(message3);
    messageList.add(message4);
    messageList.add(message5);
    messageList.add(message1);
    messageList.add(message2);
    messageList.add(message3);
    messageList.add(message4);
    messageList.add(message5);
  }

  @override
  Widget build(BuildContext context) {
    final double pageWidth = MediaQuery.of(context).size.width;
    final double pageHeight = MediaQuery.of(context).size.height;
    final bool _isWeb = MediaQuery.of(context).size.width >= web;

    return Scaffold(
      appBar: _isWeb
          ? null
          : AppBar(
              title: appText(
                'Messages',
                color: AppColors.whiteColor,
                fontSize: 16,
              ),
            ),
      body: Stack(
        children: [
          // Messages window
          Container(
            height: pageHeight,
            width: pageWidth,
            color: AppColors.paleGrey1,
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 90),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: messageList.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = messageList[index];
                  return messageWidget(item);
                },
              ),
            ),
          ),

          // Header
          Positioned(
            top: 0,
            child: Stack(
              children: [
                Container(
                  height: 120,
                  width: pageWidth,
                  alignment: Alignment.topLeft,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.burple,
                        AppColors.purpleyPink,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: appText(
                      'Company: ' +
                          currentCompanyName +
                          " " +
                          selectedTripNumber,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 80,
                    width: pageWidth,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: AppColors.paleGrey1,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(formItemCorner),
                        topRight: Radius.circular(formItemCorner),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Stack(
                        children: [
                          // User
                          Padding(
                            padding: paddingMedium,
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: spacing32,
                                    height: spacing32,
                                    child: svgToIcon(
                                        appImagesName: AppImages.userIcon),
                                  ),
                                  FutureBuilder(
                                    future: getUserData(),
                                    builder: (context, builder) {
                                      final userName = builder.data.toString();
                                      return Text(
                                        userName,
                                        style: const TextStyle(
                                          color: AppColors.blackColor,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // MARK Search
                          // _buildSearchWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Footer/Actions
          Positioned(
            bottom: 0,
            height: 90,
            width: pageWidth,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.paleGrey1,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(formItemCorner),
                  topRight: Radius.circular(formItemCorner),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Type a message",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget messageWidget(Message item) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                item.isMine
                    ? Container()
                    : SizedBox(
                        width: 20,
                        height: 20,
                        child: svgToIcon(
                          appImagesName: AppImages.gtmLogoIconSvg,
                        ),
                      ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    alignment: item.isMine
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    decoration: BoxDecoration(
                      gradient: item.isMine
                          ? const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                AppColors.burple,
                                AppColors.purpleyPink,
                              ],
                            )
                          : null,
                      borderRadius: BorderRadius.circular(formItemCorner),
                      color: item.isMine ? null : AppColors.paleGrey2,
                    ),
                    child: appText(
                      item.message,
                      color: item.isMine
                          ? AppColors.whiteColor
                          : AppColors.charcoalGrey,
                    ),
                  ),
                ),
                item.isMine
                    ? svgToIcon(
                        appImagesName: AppImages.userIcon,
                      )
                    : Container(),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
              alignment:
                  item.isMine ? Alignment.centerRight : Alignment.centerLeft,
              child: appText(
                item.received,
                color: AppColors.blackColor,
                fontSize: 8,
              ),
            ),
          ],
        ));
  }

  _buildSearchWidget() {
    final double pageWidth = MediaQuery.of(context).size.width;
    return Positioned(
      right: 0,
      child: Container(
        alignment: Alignment.centerLeft,
        width: doSearch ? pageWidth * 0.8 : 72,
        decoration: const BoxDecoration(
          color: AppColors.cloudyBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            bottomLeft: Radius.circular(22),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
              child: InkWell(
                onTap: () {
                  doSearch = !doSearch;
                  setState(() {});
                },
                child: const Icon(
                  Icons.search,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            doSearch
                ? const Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontSize: 12.0,
                        color: AppColors.whiteColor,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        hintText: "Search message",
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class Message extends Equatable {
  final String message;
  final bool isMine;
  final String sender;
  final DateTime received;
  const Message({
    required this.message,
    required this.isMine,
    required this.sender,
    required this.received,
  });
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
