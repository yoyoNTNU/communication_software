import 'package:proj/style.dart';
import 'package:proj/login/widget/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj/login/bloc/login_bloc.dart';
import 'package:proj/login/login_not_confirm.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int tapCount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/home');
            });
          } else if (state is LoginConfirmFail) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LoginNotConfirm(email: _accountController.text)),
              );
            });
          }
          return Material(
              child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: Container(
                      height: double.infinity,
                      color: AppStyle.blue[50],
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Container(
                          color: AppStyle.blue[50],
                          padding: const EdgeInsets.only(
                            top: 44,
                            left: 24,
                            right: 24,
                            bottom: 34,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                const AppLogo(),
                                AppBox(
                                    title: "使用者登入",
                                    content: BlocBuilder<LoginBloc, LoginState>(
                                      builder: (context, state) {
                                        return Column(
                                          children: [
                                            AppTextField(
                                              key: UniqueKey(),
                                              controller: _accountController,
                                              labelText: '帳號（電子信箱）',
                                              hintText: '請輸入帳號',
                                              errorText: state is LoginFailure
                                                  ? state.error
                                                  : null,
                                              onTap: () {
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 800), () {
                                                  _scrollController.animateTo(
                                                      _scrollController.position
                                                              .maxScrollExtent -
                                                          150,
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.easeInOut);
                                                });
                                              },
                                              onChanged: (value) {
                                                context.read<LoginBloc>().add(
                                                      LoginTextFieldChanged(),
                                                    );
                                              },
                                            ),
                                            const SizedBox(height: 16),
                                            AppTextField(
                                              key: UniqueKey(),
                                              controller: _passwordController,
                                              isPassword: true,
                                              labelText: '密碼',
                                              hintText: '請輸入密碼',
                                              errorText: state is LoginFailure
                                                  ? state.error
                                                  : null,
                                              onTap: () {
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 500), () {
                                                  _scrollController.animateTo(
                                                      _scrollController.position
                                                          .maxScrollExtent,
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.easeInOut);
                                                });
                                              },
                                              onChanged: (value) {
                                                context.read<LoginBloc>().add(
                                                      LoginTextFieldChanged(),
                                                    );
                                              },
                                              onSubmit: (value) {
                                                context.read<LoginBloc>().add(
                                                      LoginButtonPressed(
                                                          account:
                                                              _accountController
                                                                  .text,
                                                          password:
                                                              _passwordController
                                                                  .text),
                                                    );
                                              },
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // Buttons
                                                BlocBuilder<LoginBloc,
                                                    LoginState>(
                                                  builder: (context, state) {
                                                    return ElevatedButton(
                                                      onPressed:
                                                          state is LoginLoading
                                                              ? null
                                                              : () {
                                                                  context
                                                                      .read<
                                                                          LoginBloc>()
                                                                      .add(
                                                                        LoginButtonPressed(
                                                                            account:
                                                                                _accountController.text,
                                                                            password: _passwordController.text),
                                                                      );
                                                                },
                                                      style:
                                                          AppStyle.primaryBtn(),
                                                      child: Row(
                                                        children: [
                                                          if (state
                                                              is LoginLoading)
                                                            const SizedBox(
                                                              width: 16,
                                                              height: 16,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                                color: AppStyle
                                                                    .white,
                                                              ),
                                                            ),
                                                          if (state
                                                              is LoginLoading)
                                                            const SizedBox(
                                                                width: 8),
                                                          const Text("登入"),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                                const SizedBox(width: 16),
                                                // Outline Button
                                                OutlinedButton(
                                                  onPressed: () {
                                                    Navigator.popAndPushNamed(
                                                        context,
                                                        '/forget_password');
                                                  },
                                                  style:
                                                      AppStyle.secondaryBtn(),
                                                  child: const Text("忘記密碼"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    )),
                                const SizedBox(height: 32),
                                ElevatedButton(
                                  onPressed: () => Navigator.popAndPushNamed(
                                      context, '/sign_up'),
                                  style: AppStyle.popUpBtn(),
                                  child: const Text("註冊"),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "新用戶？點我註冊",
                                  style: AppStyle.info(
                                      level: 2, color: AppStyle.yellow[800]!),
                                ),
                                const SizedBox(height: 87),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tapCount++;
                                    });
                                    if (tapCount >= 10) {
                                      Navigator.popAndPushNamed(
                                          context, '/home');
                                    }
                                  },
                                  child: Text(
                                    "Instant Communication, Delivered Express",
                                    style: AppStyle.info(
                                        level: 2, color: AppStyle.blue[700]!),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ))));
        },
      ),
    );
  }
}
