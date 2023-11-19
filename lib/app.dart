import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:test_xsis/core/network/networkInfo/network_info_bloc.dart';
import 'package:test_xsis/core/utils/extension/context_ext.dart';
import 'package:test_xsis/core/utils/themes/theme.dart';
import 'package:test_xsis/features/movie/presentation/screens/discover_screen.dart';
import 'package:test_xsis/generated/locale_keys.g.dart';
import 'package:test_xsis/injection.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkInfoBloc>(
          create: (context) => sl<NetworkInfoBloc>(),
        ),
      ],
      child: OKToast(
        textAlign: TextAlign.center,
        textPadding: const EdgeInsets.all(10),
        radius: 5,
        position: ToastPosition.bottom,
        child: MaterialApp(
          title: 'Test BRIK',
          debugShowCheckedModeBanner: false,
          theme: themeData,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: const ScaffoldConnection(),
        ),
      ),
    );
  }
}

class ScaffoldConnection extends StatelessWidget {
  const ScaffoldConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<NetworkInfoBloc, NetworkInfoState>(
        builder: (context, state) {
          if (state is NetworkInfoDisconnectedState) {
            return FloatingActionButton(
              onPressed: () {
                context.showErrorToast(
                  LocaleKeys.noInternetConnection.tr(),
                );
              },
              child: const Icon(Icons.signal_wifi_off_outlined),
            );
          }
          return const SizedBox();
        },
      ),
      body:  const DiscoverScreen(),
    );
  }
}
