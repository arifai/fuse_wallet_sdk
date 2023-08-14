import 'dart:io';

import 'package:fuse_wallet_sdk/fuse_wallet_sdk.dart';

void main() async {
  final EthPrivateKey credentials = EthPrivateKey.fromHex('YOUR_PRIVATE_KEY');
  // Create a project: https://developers.staging.fuse.io
  final String publicApiKey = 'YOUR_PUBLIC_API_KEY';
  final FuseSDK fuseSDK = await FuseSDK.init(
    publicApiKey,
    credentials,
  );

  final res = await fuseSDK.stakeToken(
    StakeRequestBody(
      accountAddress: fuseSDK.simpleAccount.getSender(),
      tokenAmount: '0.5',
      tokenAddress: '0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE',
    ),
  );
  print('UserOpHash: ${res.userOpHash}');

  print('Waiting for transaction...');
  final ev = await res.wait();
  print('Transaction hash: ${ev?.transactionHash}');
  exit(1);
}
