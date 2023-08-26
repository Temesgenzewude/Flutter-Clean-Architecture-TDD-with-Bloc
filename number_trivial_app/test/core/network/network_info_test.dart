
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:number_trivial_app/core/network/network_info.dart';

import '../../features/number_trivia/helpers/mock_network_connectivity_plus.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockConnectivity mockNetworkConnectivityChecker;

  setUp(() {
    mockNetworkConnectivityChecker = MockConnectivity();
    networkInfoImpl =
        NetworkInfoImpl(connectivity: mockNetworkConnectivityChecker);
  });

  group('isConnected', () {
    test('should forward the call to Connectivity.checkConnectivity', () async {
      // arrange
      const tConnectivityResult = ConnectivityResult.wifi;
      when(mockNetworkConnectivityChecker.checkConnectivity())
          .thenAnswer((_) async => tConnectivityResult);
      // act
      final result = await networkInfoImpl.isConnected;
      // assert
      verify(mockNetworkConnectivityChecker.checkConnectivity());
      expect(result, tConnectivityResult);
    });
  });
}
