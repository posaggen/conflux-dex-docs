## JSON-RPC Methods

### getSpecificUserOperationList
Get user mint/burn operations list of specific user.
#### Parameters
(1) data:(JSON Object) the query detail
```bash
{
    "type": "mint" | "burn"
    "token": "btc" | "eth" | lowercase erc20 address
    "defi": conflux defi address (for shuttleflow frontend, hard code zero address)
    "address": user conflux address
    "status": ["doing", "finished"]
}
```

(2) offset:(Number) the number of leading operations to be ignored

(3) count:(Number) the maximum number of operations to return, <= 100

#### Returns

#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getSpecificUserOperationList","params":[{"type":"mint","token":"eth","defi":"0x0000000000000000000000000000000000000000","address":"0x1f04dcc0432b2df7ce604f0ad4736cadf5ed04ea","status":["doing","finished"]},0,10],"id":1}' -H "Content-Type: application/json" https://dev.shuttleflow.io

{
    "jsonrpc": "2.0",
	"id": 1,
	"result": {
		"txs": [{
			"token": "eth",
			"type": "cETH_mint",
			"nonce_or_txid": "0xf5fd4b2936d18395c4c6c1f282cef725c22770edf79029bbda97ee8d623222c2",
			"amount": "490000000000000000", 
			"user_addr": "0x135d73d6ce217f8fe255f98e1589158972d8adc3",
			"defi": "0x0000000000000000000000000000000000000000",
			"to_addr": "0x135d73d6ce217f8fe255f98e1589158972d8adc3", 
			"status": "finished",
			"settled_tx": "0xb706503e8bdbc0fba10040aa59fda3d0c7732967fc08591ff03df6102cbb1b6c"
		}, {
			"token": "eth",
			"type": "cETH_mint",
			"nonce_or_txid": "0x720549e44b83bb076a3f0ab8b118457de1f59c1aab9ec3ef56217107bc51adf7",
			"amount": "95000000000000000",
			"user_addr": "0x135d73d6ce217f8fe255f98e1589158972d8adc3",
			"defi": "0x0000000000000000000000000000000000000000",
			"to_addr": "0x135d73d6ce217f8fe255f98e1589158972d8adc3",
			"status": "finished",
			"settled_tx": "0x5912e0a5177a90547cc792a1bf63a4b81f0a775d819e3ffecc93ac63b3c0c346"
		}, {
			"token": "eth",
			"type": "cETH_mint",
			"nonce_or_txid": "0x113f4a0304b196be1de746d6f72d3e3abd7af87e68ed2f0bed4447ae86b7be51",
			"amount": "95000000000000000",
			"user_addr": "0x135d73d6ce217f8fe255f98e1589158972d8adc3",
			"defi": "0x0000000000000000000000000000000000000000",
			"to_addr": "0x135d73d6ce217f8fe255f98e1589158972d8adc3",
			"status": "finished",
			"settled_tx": "0xdb404e46caebd987ef6abaf7578fc2d42445ad1db1c361a56b687dcd70271957"
		}, {
			"token": "eth",
			"type": "cETH_mint",
			"nonce_or_txid": "0x2dfd88f434280dcf6f5e01d977ddede4b083f19dfb6384aee03ed47b12272dd3",
			"amount": "195000000000000000",
			"user_addr": "0x135d73d6ce217f8fe255f98e1589158972d8adc3",
			"defi": "0x0000000000000000000000000000000000000000",
			"to_addr": "0x135d73d6ce217f8fe255f98e1589158972d8adc3",
			"status": "finished",
			"settled_tx": "0x2721c5013fad1c49b88edb7409614b9cd532b8225f6e3d54f77d262eec659668"
		}, {
			"token": "eth",
			"type": "cETH_mint",
			"nonce_or_txid": "0xdb38ce8d9512b2a736ba9889dca63ff2b0939621b654fc615241fe886bde74a5",
			"amount": "95000000000000000",
			"user_addr": "0x135d73d6ce217f8fe255f98e1589158972d8adc3",
			"defi": "0x0000000000000000000000000000000000000000",
			"to_addr": "0x135d73d6ce217f8fe255f98e1589158972d8adc3",
			"status": "finished",
			"settled_tx": "0xc735ec52e425fb518610b18e3620347a868ed13baf08ae6aa212e46c8dba3751"
		}, {
			"token": "eth",
			"type": "cETH_mint",
			"nonce_or_txid": "0x1dbe784def8f208f519128c4d83666b3be1d5675ac458c10aa609914e856d57e",
			"amount": "95000000000000000",
			"user_addr": "0x135d73d6ce217f8fe255f98e1589158972d8adc3",
			"defi": "0x0000000000000000000000000000000000000000",
			"to_addr": "0x135d73d6ce217f8fe255f98e1589158972d8adc3",
			"status": "finished",
			"settled_tx": "0x13bde6d88ea027b9c2c92b596a221ab235964da89ced66ea4e92d7958486864c"
		}, {
			"token": "eth",
			"type": "cETH_mint",
			"nonce_or_txid": "0xc01a4d86ac352c7980d76e9edb419ffb8db39255cc4cba47b95295e232371816",
			"amount": "95000000000000000",
			"user_addr": "0x135d73d6ce217f8fe255f98e1589158972d8adc3",
			"defi": "0x0000000000000000000000000000000000000000",
			"to_addr": "0x135d73d6ce217f8fe255f98e1589158972d8adc3",
			"status": "finished",
			"settled_tx": "0x268bab123f111f23ffac1716f3bf7bed6b0124772eb285406123b727b90a3b10"
		}],
		"total": 7
	}
}
```

### getUserReceiveWalletEth
Get user eth receive wallet.
#### Parameters
(1) address: (String) user conflux address

(2) defi: (String) conflux defi address (for shuttleflow frontend, hard code zero address)
#### Returns
String, user ethereum receive wallet address
### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getUserReceiveWalletEth","params":["0x1d9fdbe7cad3d82cc539b3b7c8bd8a8437ad5b58", "0x0000000000000000000000000000000000000000"],"id":1}' -H "Content-Type: application/json" https://dev.shuttleflow.io

{"jsonrpc":"2.0","id":1,"result":"0x4e0095dc1fed099ed73a749def57905387a11271"}
```

### getUserReceiveWalletBtc
Get user btc receive wallet.
#### Parameters
(1) address: (String) user conflux address

(2) defi: (String) conflux defi address (for shuttleflow frontend, hard code zero address)
#### Returns
String, user bitcoin receive wallet address
### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getUserReceiveWalletBtc","params":["0x1d9fdbe7cad3d82cc539b3b7c8bd8a8437ad5b58", "0x0000000000000000000000000000000000000000"],"id":1}' -H "Content-Type: application/json" https://dev.shuttleflow.io

{"jsonrpc":"2.0","id":1,"result":"2MutEXoJsQMm4jviPVchfm2HuZsbusVizCz"}
```

## Public Nodes

Now we provide public api endpoint for both mainnet and testnet of shuttleflow:

Mainnet: https://open-api.shuttleflow.io

Testnet: https://dev.shuttleflow.io
