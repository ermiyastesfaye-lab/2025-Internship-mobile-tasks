import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_7/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
      () async {
        final tHasConnectionFuture = Future.value(true);

        when(mockDataConnectionChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);

        final result = networkInfo.isConnected;

        verify(mockDataConnectionChecker.hasConnection);

        expect(result, tHasConnectionFuture);
      },
    );
  });
}
