import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bubble/bubble.dart';
import 'package:intl/intl.dart';

// 메세지 상태
class ChatMessageState extends StateNotifier<List<ChattingMessage>> {
  ChatMessageState() : super([]);

  // 메세지 리스트 추가
  void addMessage(ChattingMessage message) {
    state = [...state, message];
  }

  // 메세지 리스트 초기화
  void clearMessage() {
    state = [];
  }

  // 메세지 list 개수 반환
  int getLength() {
    return state.length;
  }

  // 메세지 리스트 반환
  ChattingMessage getList(int index) {
    return state[index];
  }
}

class ChattingMessage extends StatelessWidget {
  final String? userImage;
  final String? name;
  final String content;
  final bool isSentByMe;
  final DateTime time;

  const ChattingMessage({
    super.key,
    required this.userImage,
    required this.name,
    required this.content,
    required this.isSentByMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: isSentByMe == true
            // 내가 보낸 채팅인 경우
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      formatTime(DateTime.now()),
                      style: const TextStyle(
                        color: Color(0xFF6F6262),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * (3/5),
                    ),
                    child: Bubble(
                      padding: const BubbleEdges.all(10),
                      elevation: 0,
                      stick: true,
                      nip: BubbleNip.rightTop,
                      color: Colors.yellow,
                      child: Text(
                        content,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                          letterSpacing: -0.5,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                // 다른 사람이 보낸 채팅인 경우
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // profileImage
                      ClipOval(
                        child: Image.network(
                          userImage!,
                          height: 26,
                          width: 26,
                        ),
                      ),
                      const SizedBox(width: 10),

                      // name
                      Text(
                        name!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.5),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 36),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * (3/5),
                        ),
                        child: Bubble(
                          padding: const BubbleEdges.symmetric(horizontal: 10),
                          elevation: 0,
                          stick: true,
                          nip: BubbleNip.leftTop,
                          color: Colors.white,
                          child: Text(
                            content,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                              letterSpacing: -0.5,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          formatTime(time),
                          style: const TextStyle(
                            color: Color(0xFF6F6262),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ));
  }

  String formatTime(DateTime commentTime) {
    final formattedTime = DateFormat('aa h:mm').format(commentTime);
    //final timeSuffix = now.hour >= 12 ? '오후' : '오전';
    final replacedTime =
        formattedTime.replaceAll('AM', '오전').replaceAll('PM', '오후');
    return replacedTime;
  } //시간 형식 지정
}
