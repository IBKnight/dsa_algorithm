import 'package:dsa_algorithm/logic/remote_data_source.dart';
import 'package:dsa_algorithm/models/keys_model.dart';
import 'package:dsa_algorithm/ui/blocs/keys_bloc/keys_bloc.dart';
import 'package:dsa_algorithm/ui/widgets/sender_and_recipient.dart';
import 'package:dsa_algorithm/utils/text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => KeysBloc(remoteDataSource),
        child: const HomePageView());
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final TextEditingController _pValue = TextEditingController();
  final TextEditingController _qValue = TextEditingController();
  final TextEditingController _pCheks = TextEditingController();
  final TextEditingController _qCheks = TextEditingController();
  final TextEditingController _publicKey = TextEditingController();
  final TextEditingController _privateKey = TextEditingController();
  final TextEditingController _logs = TextEditingController();

  void updateLogs(String text) {
    setState(() {
      _logs.text += '$text\n';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text('DSA'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocConsumer<KeysBloc, KeysState>(listener: (context, state) {
              if (state is KeysLoaded) {
                _pValue.text = 'p = ${state.primeNumbers.p}';
                _qValue.text = 'q = ${state.primeNumbers.q}';

                _pCheks.text = TextFormatter.prepareText(state.primeNumbers.pA);
                _qCheks.text = TextFormatter.prepareText(state.primeNumbers.qA);
                _publicKey.text = state.keys.publicKey;
                _privateKey.text = state.keys.privateKey;
                setState(() {});
              }
            }, builder: (context, state) {
              return switch (state) {
                KeysLoading _ => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 75,
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: TextField(
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                  controller: _pValue,
                                  readOnly: true,
                                  maxLines: 5,
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: TextField(
                                  controller: _pCheks,
                                  readOnly: true,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 75,
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: TextField(
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                  controller: _qValue,
                                  readOnly: true,
                                  maxLines: 5,
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: TextField(
                                  controller: _qCheks,
                                  readOnly: true,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Приватный ключ',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              SizedBox(
                                height: 55,
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: TextField(
                                  controller: _privateKey,
                                  readOnly: true,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Публичный ключ',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              SizedBox(
                                height: 55,
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: TextField(
                                  controller: _publicKey,
                                  readOnly: true,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                KeysLoaded _ => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 75,
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: TextField(
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                  controller: _pValue,
                                  readOnly: true,
                                  maxLines: 5,
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: TextField(
                                  controller: _pCheks,
                                  readOnly: true,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 75,
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: TextField(
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                  controller: _qValue,
                                  readOnly: true,
                                  maxLines: 5,
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: TextField(
                                  controller: _qCheks,
                                  readOnly: true,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Приватный ключ',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              SizedBox(
                                height: 55,
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: TextField(
                                  controller: _privateKey,
                                  readOnly: true,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Публичный ключ',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              SizedBox(
                                height: 55,
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: TextField(
                                  controller: _publicKey,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                KeysError _ => Center(
                    child: Text(state.errorMessage),
                  )
              };
            }),
            TextButton(
              onPressed: () {
                context.read<KeysBloc>().add(LoadKeys());
                _logs.text = '';
              },
              child: Text(
                'Сгенерировать ключи',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            SenderAndRecipient(
              keysModel: KeysModel(
                publicKey: _publicKey.text,
                privateKey: _privateKey.text,
              ),
              actionsLog: updateLogs,
            ),
            Column(
              children: [
                Text(
                  'Логи',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _logs,
                    readOnly: true,
                    maxLines: 5,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
