import 'package:dsa_algorithm/logic/remote_data_source.dart';
import 'package:dsa_algorithm/models/keys_model.dart';
import 'package:dsa_algorithm/ui/blocs/decrypt_bloc/decrypt_bloc.dart';
import 'package:dsa_algorithm/ui/blocs/sign_bloc/sign_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SenderAndRecipient extends StatefulWidget {
  const SenderAndRecipient(
      {super.key, required this.keysModel, required this.actionsLog});

  final KeysModel keysModel;
  final Function(String) actionsLog;
  @override
  State<SenderAndRecipient> createState() => _SenderAndRecipientState();
}

class _SenderAndRecipientState extends State<SenderAndRecipient> {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();
  late final SignBloc bloc;
  late final DecryptBloc decryptBloc;
  bool? verifyStatus;
  @override
  void initState() {
    bloc = SignBloc(_remoteDataSource);
    decryptBloc = DecryptBloc(_remoteDataSource);
    super.initState();
  }

  final TextEditingController message = TextEditingController();
  final TextEditingController encryptedMessage = TextEditingController();
  final TextEditingController decryptedMessage = TextEditingController();
  final TextEditingController r = TextEditingController();
  final TextEditingController s = TextEditingController();
  final TextEditingController recipientMesasge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<SignBloc, SignState>(
            listener: (context, state) {
              if (state is SignLoaded) {
                encryptedMessage.text = state.signedMessage.ciphertext;
                r.text = state.signedMessage.r;
                s.text = state.signedMessage.s;
              }
            },
            bloc: bloc,
            builder: (context, state) {
              return switch (state) {
                SignLoading _ => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Отправитель',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          SizedBox(
                            height: 75,
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: TextField(
                              controller: message,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Введите сообщение"),
                            ),
                          ),
                          Text(
                            'Подписанное сообщение',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: const TextField(
                              maxLines: 5,
                              readOnly: true,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Получатель',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          SizedBox(
                            height: 75,
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: const TextField(
                              readOnly: true,
                              maxLines: 5,
                              decoration:
                                  InputDecoration(border: OutlineInputBorder()),
                            ),
                          ),
                          Text(
                            'Расшифрованное сообщение',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: const TextField(
                              maxLines: 5,
                              readOnly: true,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                SignLoaded _ => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Отправитель',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          SizedBox(
                            height: 75,
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: TextField(
                              controller: message,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Введите сообщение"),
                            ),
                          ),
                          Text(
                            'Подписанное сообщение',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: TextField(
                              controller: r,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ],
                      ),
                      BlocConsumer<DecryptBloc, DecryptState>(
                        listener: (context, state) {
                          if (state is DecryptLoaded) {
                            verifyStatus = state.verifyStatusModel?.isValid;

                            if (verifyStatus != null) {
                              if (verifyStatus!) {
                                _showStatusDialog('Подпись верна');
                                decryptedMessage.text =
                                    state.decryptedMessageModel.decryptedText;
                              } else {
                                _showStatusDialog('Подпись неверна');
                                decryptedMessage.text = '';
                              }
                            }
                          }
                        },
                        bloc: decryptBloc,
                        builder: (context, state) {
                          return switch (state) {
                            DecryptLoading _ => Column(
                                children: [
                                  Text(
                                    'Получатель',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                  SizedBox(
                                    height: 75,
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    child: TextField(
                                      controller: recipientMesasge,
                                      readOnly: true,
                                      maxLines: 5,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                  Text(
                                    'Расшифрованное сообщение',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    child: const TextField(
                                      maxLines: 5,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ],
                              ),
                            DecryptLoaded _ => Column(
                                children: [
                                  Text(
                                    'Получатель',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                  SizedBox(
                                    height: 75,
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    child: TextField(
                                      controller: recipientMesasge,
                                      readOnly: true,
                                      maxLines: 5,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                  Text(
                                    'Расшифрованное сообщение',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    child: TextField(
                                      controller: decryptedMessage,
                                      maxLines: 5,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ],
                              ),
                            DecryptError _ => const Center(
                                child: Text('Something went Wrong'),
                              )
                          };
                        },
                      )
                    ],
                  ),
                SignError _ => Center(
                    child: Text(state.errorMessage),
                  ),
              };
            }),
        Row(
          children: [
            TextButton(
              onPressed: () {
                bloc.add(SignMessageEvent(message.text));
                widget.actionsLog('Отправитель: Подписал сообщение');
              },
              child: Text(
                'Подписать сообщение',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            TextButton(
              onPressed: () {
                widget.actionsLog('Отправитель: Отправил сообщение');
              },
              child: Text(
                'Отправить сообщение',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const Expanded(child: SizedBox()),
            TextButton(
              onPressed: () {
                setState(() {
                  recipientMesasge.text = encryptedMessage.text;
                  widget.actionsLog('Получатель: Получил сообщение');
                });
              },
              child: Text(
                'Получить сообщение',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            TextButton(
              onPressed: () {
                decryptBloc.add(VerifyMessageEvent(
                    r: r.text,
                    s: s.text,
                    publicKey: widget.keysModel.publicKey,
                    encryptedMessage: encryptedMessage.text));
              },
              child: Text(
                'Проверить подпись',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            TextButton(
              onPressed: () {
                if (verifyStatus == null) {
                  _showStatusDialog('Небходимо проверить подпись');
                } else {
                  decryptBloc.add(DecryptMessageEvent(verifyStatus!,
                      encryptedMessage: encryptedMessage.text));
                }
              },
              child: Text(
                'Расшифровать сообщение',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ],
        )
      ],
    );
  }

  void _showStatusDialog(String statusMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: 300,
            height: 200,
            child: Center(
              child: Text(
                statusMessage,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        );
      },
    );
  }
}
