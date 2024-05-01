import 'package:dsa_algorithm/logic/remote_data_source.dart';
import 'package:dsa_algorithm/models/keys_model.dart';
import 'package:dsa_algorithm/ui/blocs/decrypt_bloc/decrypt_bloc.dart';
import 'package:dsa_algorithm/ui/blocs/sign_bloc/sign_bloc.dart';
import 'package:dsa_algorithm/utils/strings.dart';
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
                            Strings.sender,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Text(
                            Strings.originalMessage,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          CustomTextField(
                            height: 75,
                            controller: message,
                            readOnly: false,
                            hintText: "Введите сообщение",
                          ),
                          Text(
                            Strings.sign,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const CustomTextField(
                            height: 50,
                            readOnly: true,
                            padding: EdgeInsets.all(5),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            Strings.recipient,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Text(
                            Strings.encryptedMessage,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const CustomTextField(
                            height: 75,
                            readOnly: true,
                          ),
                          Text(
                            Strings.decryptedMessage,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const CustomTextField(
                            height: 50,
                            readOnly: true,
                            padding: EdgeInsets.all(5),
                          )
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
                            Strings.sender,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Text(
                            Strings.originalMessage,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          CustomTextField(
                            height: 75,
                            controller: message,
                            readOnly: false,
                            hintText: "Введите сообщение",
                          ),
                          Text(
                            Strings.sign,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          CustomTextField(
                            height: 50,
                            controller: r,
                            readOnly: false,
                            padding: const EdgeInsets.all(5),
                          )
                        ],
                      ),
                      BlocConsumer<DecryptBloc, DecryptState>(
                        listener: (context, state) {
                          if (state is DecryptLoaded) {
                            verifyStatus = state.verifyStatusModel?.isValid;

                            decryptedMessage.text =
                                state.decryptedMessageModel.decryptedText;

                            if (state.shouldShowDialog) {
                              if (verifyStatus != null) {
                                if (verifyStatus!) {
                                  _showStatusDialog('Подпись верна');
                                  widget.actionsLog('Подпись верна');
                                } else {
                                  _showStatusDialog('Подпись неверна');
                                  widget.actionsLog('Подпись неверна');
                                }
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
                                    Strings.recipient,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                  Text(
                                    Strings.encryptedMessage,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  CustomTextField(
                                    controller: recipientMesasge,
                                    height: 75,
                                    readOnly: true,
                                  ),
                                  Text(
                                    Strings.decryptedMessage,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  const CustomTextField(
                                    height: 50,
                                    readOnly: true,
                                    padding: EdgeInsets.all(5),
                                  ),
                                ],
                              ),
                            DecryptLoaded _ => Column(
                                children: [
                                  Text(
                                    Strings.recipient,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                  Text(
                                    Strings.encryptedMessage,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  CustomTextField(
                                    controller: recipientMesasge,
                                    height: 75,
                                    readOnly: true,
                                  ),
                                  Text(
                                    Strings.decryptedMessage,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  CustomTextField(
                                    controller: decryptedMessage,
                                    height: 50,
                                    readOnly: true,
                                    padding: const EdgeInsets.all(5),
                                  ),
                                ],
                              ),
                            DecryptError _ => Center(
                                child: Text(state.errorMessage),
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
            FilledButton.tonal(
              onPressed: () {
                bloc.add(SignMessageEvent(message.text));
                widget.actionsLog(
                    'Отправитель: Отправитель создает подпись (r,s)');
              },
              child: Text(
                Strings.createSign,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            FilledButton.tonal(
              onPressed: () {
                widget
                    .actionsLog('Отправитель: Отправляет сообщение и подпись');
              },
              child: Text(
                Strings.sendMessage,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const Expanded(child: SizedBox()),
            FilledButton.tonal(
              onPressed: () {
                setState(() {
                  recipientMesasge.text = encryptedMessage.text;
                  widget.actionsLog('Получатель: Получает сообщение и подпись');
                });
              },
              child: Text(
                Strings.getMessage,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            FilledButton.tonal(
              onPressed: () {
                decryptBloc.add(DecryptMessageEvent(
                    encryptedMessage: encryptedMessage.text));
                widget.actionsLog(
                    'Получатель: Расшифровывает сообщение с использованием открытого ключа отправителя');
              },
              child: Text(
                Strings.decryptMessage,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            FilledButton.tonal(
              onPressed: () {
                decryptBloc.add(VerifyMessageEvent(
                    r: r.text,
                    s: s.text,
                    publicKey: widget.keysModel.publicKey,
                    encryptedMessage: encryptedMessage.text));
                widget.actionsLog('Получатель: Проверяет подпись');
              },
              child: Text(
                Strings.checkSign,
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

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.height,
      this.controller,
      required this.readOnly,
      this.hintText,
      this.padding});

  final int height;
  final TextEditingController? controller;
  final bool readOnly;
  final String? hintText;

  final EdgeInsets? padding;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height.toDouble(),
      width: MediaQuery.of(context).size.width / 2.1,
      child: TextField(
        controller: widget.controller,
        readOnly: widget.readOnly,
        maxLines: 5,
        decoration: InputDecoration(
            contentPadding: widget.padding,
            border: const OutlineInputBorder(),
            hintText: widget.hintText),
      ),
    );
  }
}
