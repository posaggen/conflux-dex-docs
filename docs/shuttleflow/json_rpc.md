## JSON-RPC Methods
### getHotWalletBalance
Get the hot wallet balance of specified token.
#### Parameters
(1) token: (string)
#### Returns
String
#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getHotWalletBalance","params":["btc"],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": 0.00281705
}
```
### getColdWalletBalance
Get the cold wallet balance of specified token.
#### Parameters
(1) token: (string)
#### Returns
String
#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getColdWalletBalance","params":["btc"],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": 0
}
```
### getProfitWalletBalance
Get the profit wallet balance of specified token.
#### Parameters
(1) token: (string)
#### Returns
Number
#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getProfitWalletBalance","params":["eth"],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": "0"
}
```
### getWalletAddress
Get the wallet address url for different token.
#### Parameters
None.
#### Returns
JSON object:\
{\
&nbsp;&nbsp;token_name: (JSON object)\
&nbsp;&nbsp;&nbsp;&nbsp;{\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"hot_wallet": (String) url of  wallet,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"cold_wallet": (String) url of  wallet,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"profit_wallet": (String) url of  wallet,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"personal_wallet": (String) url of  wallet,\
&nbsp;&nbsp;&nbsp;&nbsp;}\
}
#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getWalletAddress","params":[],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": {
		"btc": {
			"hot_wallet": "https://blockstream.info/testnet/address/2MsPJwNqdeUHvxM3munWBxtCE2WncF9PKbZ",
			"cold_wallet": "https://blockstream.info/testnet/address/2N5d2CVouyjaF8thM9anTTcJFyHvhF2AdRS",
			"profit_wallet": "https://blockstream.info/testnet/address/2N9rEmrpFA1b7HKZiDghnNEmTy6MDrgV3aC",
			"personal_wallet": "https://blockstream.info/testnet/address/mhMHPARYGwa4gki9bjtyZnSWAX7ApfjhuR"
		},
		"eth": {
			"hot_wallet_address": "https://rinkeby.etherscan.io/address/0x81632943BA6395d5E998393343e2Bb47c9f8Aa18",
			"cold_wallet_address": "https://rinkeby.etherscan.io/address/0x81632943BA6395d5E998393343e2Bb47c9f8Aa18",
			"profit_wallet_address": "https://rinkeby.etherscan.io/address/0x81632943BA6395d5E998393343e2Bb47c9f8Aa18",
			"personal_address": "https://rinkeby.etherscan.io/address/0x6B6C3A1eC5C689C3dd158b1a6E8Bc722373a2BfA"
		},
		"usdt": {
			"hot_wallet_address": "https://rinkeby.etherscan.io/token/0xd5185bF8E6F0706aBED0a4025bA4969197c8166B?a=0x81632943BA6395d5E998393343e2Bb47c9f8Aa18",
			"cold_wallet_address": "https://rinkeby.etherscan.io/token/0xd5185bF8E6F0706aBED0a4025bA4969197c8166B?a=0x81632943BA6395d5E998393343e2Bb47c9f8Aa18",
			"profit_wallet_address": "https://rinkeby.etherscan.io/token/0xd5185bF8E6F0706aBED0a4025bA4969197c8166B?a=0x81632943BA6395d5E998393343e2Bb47c9f8Aa18",
			"personal_address": "https://rinkeby.etherscan.io/token/0xd5185bF8E6F0706aBED0a4025bA4969197c8166B?a=0x6B6C3A1eC5C689C3dd158b1a6E8Bc722373a2BfA"
		}
	}
}
```
### verifyBalance
verify the balance of a specified token.
#### Parameters
(1) token: (string)
#### Returns
JSON object:\
{\
&nbsp;&nbsp;hot: (string) hot wallet balance,\
&nbsp;&nbsp;cold: (string) cold wallet balance,\
&nbsp;&nbsp;total: (string) cToken total supply,\
&nbsp;&nbsp;success: (bool) verification result,\
}
#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"verifyBalance","params":["btc"],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": {
		"hot": "0",
		"cold": "0.0203324",
		"total": "0.005",
		"success": false
	}
}
```

### getColdTransferHashBtc
Get the hash of bitcoin operation which need private key of cold wallet.
#### Parameters
(1) type: (string), "ColdToHot"|"ColdTransfer"|"ProfitTransfer"|"SplitProfit",\
(2) amount: (string | number), Optional (only "ColdToHot" | "SplitProfit")
#### Returns
JSON object:\
{\
&nbsp;&nbsp;digest:(array of array of string) hash of each utxos used to sign,\
&nbsp;&nbsp;hash:(string) internal transaction hash,
}
#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getColdTransferHashBtc","params":["ColdToHot","100000"],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": {
		"hash": "c051866e922c9d0eee16b075791fc71076c55b0e7c7da2f03cebc41ff3f234e0#1",
		"digests": [
			["7d6b239bab77e06a7814e07653ce0b746b559a101f4958dccd5cab0e8801c00c"]
		]
	}
}

$ curl -X POST --data '{"jsonrpc":"2.0","method":"getColdTransferHashBtc","params":["SplitProfit","100000"],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": {
		"hash": "SplitProfit@2N9rEmrpFA1b7HKZiDghnNEmTy6MDrgV3aC@@0x186a0#1",
		"digests": [
			["298b25483820fddf35a3930422690f8a5053fb3ffa9ec660627a39ed78bec3d7"]
		]
	}
}
```

### getColdTransferHashEth
Get the hash of eth/erc20 token operation which need private key of cold wallet.
#### Parameters
(1) type: (string), "ColdToHot"|"SplitProfit",\
(2) token: (string)\
(3) amount: (string | number)
#### Returns
JSON object:\
{\
&nbsp;&nbsp;token:(string),\
&nbsp;&nbsp;amount:(string),\
&nbsp;&nbsp;nonce:(string), operation nonce, \
&nbsp;&nbsp;hash:(string), internal transaction hash,\
}
#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getColdTransferHashEth","params":["ColdToHot","eth","100000"],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": {
		"token": "eth",
		"amount": "0x186a0",
		"nonce": "0",
		"hash": "0xecf1cd87d27cbd0785da88625b7c414ed1954fd8abb3a427f295537152fdeed2"
	}
}
```

### signColdTransferBtc
sign the bitcoin transfer cold wallet to another address request.
#### Parameters
(1) type:(string) "ColdToHot"|"ColdTransfer"|"ProfitTransfer"|"SplitProfit",\
(2) amount: (string | number), Optional (only "ColdToHot" | "SplitProfit"),\
(3) hash:(string) internal transaction hash to sign\
(4) signatures:(array of array of string) signature of each utxos used
(5) signer:(string) signer's public key
#### Returns
"sign successfully" | Error Message (string)
#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"signColdTransferBtc","params":["ColdToHot","100000","c051866e922c9d0eee16b075791fc71076c55b0e7c7da2f03cebc41ff3f234e0#1",[["7d6b239bab77e06a7814e07653ce0b746b559a101f4958dccd5cab0e8801c00c"]]],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": "sign successfully"
}

$ curl -X POST --data '{"jsonrpc":"2.0","method":"signColdTransferBtc","params":["SplitProfit","100000","SplitProfit@2N9rEmrpFA1b7HKZiDghnNEmTy6MDrgV3aC@@0x186a0#1",[["304402202c645b25cc329d2b8adb82c7ee0aca60e28e132bc8ac500efd18aa5229b9531b02201a4972bda60aeaddd489d0774d3b2648a3384c2767dbb6ee1a395941e241909301"]]],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": "sign successfully"
}
```
### signColdTransferEth
sign the ethereum or erc20 token transfer cold wallet to another address request.
#### Parameters
(1) type: (string), "ColdToHot"|"SplitProfit",\
(2) token:(string) token name or erc20 or eth,\
(3) amount:(string),\
(4) nonce:(string), operation nonce,\
(5) hash:(string), internal transaction hash,\
(6) signature:(string), signature of hash
(7) signer:(string), signer's public key
#### Returns
"sign successfully" | Error Message (string)
#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"signColdTransferEth","params":["ColdToHot","eth","100000","0","0xecf1cd87d27cbd0785da88625b7c414ed1954fd8abb3a427f295537152fdeed2","0x6df962201a0372d415d79ef6b8cfde457ea2f6a352651f0b189c6d114615a4cb6a9c298fe36b9954bc55a6e42295a8c6720a0aec0d4d85b0c82db1d6e10d1c741b"],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": "sign successfully"
}
```
### getMemberChangeInfo
Get last member change information.
#### Parameters
None.
#### Returns
JSON object:\
{\
&nbsp;&nbsp;info:(JSON object) Member change detail:\
&nbsp;&nbsp;&nbsp;&nbsp;{\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;epoch:(Number),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;changes:(array of JSON object) [{,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;member:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;operation:(string) "add" | "remove",\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}...]\
&nbsp;&nbsp;&nbsp;&nbsp;}\
&nbsp;&nbsp;address_change:(JSON object) bitcoin address change detail:\
&nbsp;&nbsp;&nbsp;&nbsp;{\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;last_hot_address:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;last_cold_address:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;last_profit_address:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hot_address:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cold_address:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;profit_address:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;}\
}
#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getMemberChangeInfo","params":[],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": {
		"info": {
			"epoch": 200924,
			"changes": [{
				"member": "0x81f3521d71990945B99e1C592750D7157F2b544f",
				"operation": "remove"
			}, {
				"member": "0x65CF2b2c91e6eff901F10ab7363ae58cf1bfCCc5",
				"operation": "remove"
			}, {
				"member": "0x81f3521d71990945b99e1c592750d7157f2b544f",
				"operation": "add"
			}, {
				"member": "0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5",
				"operation": "add"
			}, {
				"member": "0x2338f8646aeaa5a32d374fae49ee7aae6bca1efc",
				"operation": "add"
			}]
		},
		"address_change": {
			"last_hot_address": "2MsPJwNqdeUHvxM3munWBxtCE2WncF9PKbZ",
			"last_cold_address": "2N5d2CVouyjaF8thM9anTTcJFyHvhF2AdRS",
			"last_profit_address": "2N9rEmrpFA1b7HKZiDghnNEmTy6MDrgV3aC",
			"cold_address": "2MyP3jysyz1GTeD6VHPZ6Wqs5SkNc2VkNBb",
			"profit_address": "2N7tUaxmwq9rwtXZUYymiYXnn9s7Vd2hMZp",
			"hot_address": "2N7UpxpCo6gEpPdjksZPPE9GjTq8JY1KQpz"
		}
	}
}
```
### getHotColdWalletTransferList
Get wallet transfer operations list between hot and cold wallet.
#### Parameters
(1) skip:(Number) the number of leading operations to be ignored\
(2) count:(Number) the maximum number of operations to return
#### Returns
#### Example
JSON object:\
{\
&nbsp;&nbsp;txs: (Array of JSON objects) transactions in requested range\
&nbsp;&nbsp;&nbsp;&nbsp;[\
&nbsp;&nbsp;&nbsp;&nbsp;For doing request:\
&nbsp;&nbsp;&nbsp;&nbsp;{\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nonce_or_txid:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amount:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user_addr:(string) user address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;to_addr:(string) money to address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;need:(Number) total number of signatures needed,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;signer:(array of string) list of members who have signed,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;has_signed:(bool) whether current member has signed or not,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;status:(string) "doing",\
&nbsp;&nbsp;&nbsp;&nbsp;},\
&nbsp;&nbsp;&nbsp;&nbsp;For finished request:\
&nbsp;&nbsp;&nbsp;&nbsp;{\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nonce_or_txid:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amount:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user_addr:(string) user address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;to_addr:(string) money to address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;status:(string) "finished",\
&nbsp;&nbsp;&nbsp;&nbsp;}...]\
&nbsp;&nbsp;total: (Number) total number of transactions,\
}
#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getHotColdWalletTransferList","params":[0,100],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": {
		"txs": [{
			"type": "eth_ColdToHot",
			"nonce_or_txid": "0",
			"amount": "100000",
            "user_addr": "",
            "addr": "",
			"signer": ["0x6B6C3A1eC5C689C3dd158b1a6E8Bc722373a2BfA"],
			"has_signed": true,
			"need": 2,
			"status": "doing"
		}, {
			"type": "eth_HotToCold",
			"nonce_or_txid": "0",
            "user_addr": "",
            "addr": "",
			"status": "finished"
		}],
		"total": 2
	}
}
```
### getProfitSplitList
Get profit split operations list.
#### Parameters
(1) skip:(Number) the number of leading operations to be ignored\
(2) count:(Number) the maximum number of operations to return
#### Returns
JSON object:\
{\
&nbsp;&nbsp;txs: (Array of JSON objects) transactions in requested range\
&nbsp;&nbsp;&nbsp;&nbsp;[\
&nbsp;&nbsp;&nbsp;&nbsp;For doing request:\
&nbsp;&nbsp;&nbsp;&nbsp;{\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nonce_or_txid:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amount:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user_addr:(string) user address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;to_addr:(string) money to address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;need:(Number) total number of signatures needed,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;signer:(array of string) list of members who have signed,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;has_signed:(bool) whether current member has signed or not,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;status:(string) "doing",\
&nbsp;&nbsp;&nbsp;&nbsp;},\
&nbsp;&nbsp;&nbsp;&nbsp;For finished request:\
&nbsp;&nbsp;&nbsp;&nbsp;{\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nonce_or_txid:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amount:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user_addr:(string) user address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;to_addr:(string) money to address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;status:(string) "finished",\
&nbsp;&nbsp;&nbsp;&nbsp;}...]\
&nbsp;&nbsp;total: (Number) total number of transactions,\
}
#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getProfitSplitList","params":[0,100],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": {
		"txs": [{
			"type": "eth_SplitProfit",
			"nonce_or_txid": "1",
			"amount": "100",
            "user_addr": "",
            "addr": "",
			"status": "finished"
		}],
		"total": 1
	}
}
```
### getUserOperationList
Get user mint/burn operations list.
#### Parameters
(1) skip:(Number) the number of leading operations to be ignored\
(2) count:(Number) the maximum number of operations to return
#### Returns
JSON object:\
{\
&nbsp;&nbsp;txs: (Array of JSON objects) transactions in requested range\
&nbsp;&nbsp;&nbsp;&nbsp;[\
&nbsp;&nbsp;&nbsp;&nbsp;For doing request:\
&nbsp;&nbsp;&nbsp;&nbsp;{\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nonce_or_txid:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amount:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user_addr:(string) user address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;to_addr:(string) money to address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;need:(Number) total number of signatures needed,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;signer:(array of string) list of members who have signed,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;has_signed:(bool) whether current member has signed or not,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;status:(string) "doing",\
&nbsp;&nbsp;&nbsp;&nbsp;},\
&nbsp;&nbsp;&nbsp;&nbsp;For finished request:\
&nbsp;&nbsp;&nbsp;&nbsp;{\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nonce_or_txid:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amount:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user_addr:(string) user address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;to_addr:(string) money to address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;status:(string) "finished",\
&nbsp;&nbsp;&nbsp;&nbsp;}...]\
&nbsp;&nbsp;total: (Number) total number of transactions,\
}
#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getUserOperationList","params":[0,100],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": {
		"txs": [{
			"type": "eth_mint",
			"nonce_or_txid": "0x0002a128139692f866b6a1615ce2c40ad337796fc0ca6e51cc7eb6e30baab760",
			"amount": "1000000000000000",
			"user_addr": "0x65CF2b2c91e6eff901F10ab7363ae58cf1bfCCc5",
			"to_addr": "0x65CF2b2c91e6eff901F10ab7363ae58cf1bfCCc5",
			"signer": ["fafa"],
			"has_signed": true,
			"need": 2,
			"status": "doing"
		}, {
			"type": "btc_mint",
			"nonce_or_txid": "ab68b057429271ac11a860002264c77e074d1125e3ee30d865e5276a488fad90",
			"amount": "100000",
			"user_addr": "0x81f3521d71990945b99e1c592750d7157f2b544f",
			"to_addr": "0x81f3521d71990945b99e1c592750d7157f2b544f",
			"status": "finished"
		}, {
			"type": "eth_mint",
			"nonce_or_txid": "0xe06818b9da4feef5cd590bd68aa23f13e29ef49354ecdd1ae18b11074bf47478",
			"amount": "1000000000000000",
			"user_addr": "0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5",
			"to_addr": "0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5",
			"status": "finished"
		}, {
			"type": "cUSDT_mint",
			"nonce_or_txid": "0xf1685c53cf641b330d580e9a38f783d1ad875250ffae49d182d7189c9de7907e",
			"amount": "100000",
			"user_addr": "0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5",
			"to_addr": "0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5",
			"status": "finished"
		}, {
			"type": "withdraw",
			"nonce_or_txid": "af6e2107fe26a54f84f234941db111afea9de9c9d1caa4d18778fcf22fe12247",
 			"amount": "100000",
			"user_addr": "",
			"to_addr": "",
			"status": "finished"
		}],
		"total": 5
	}
}
```
### getSpecificUserOperationList
Get user mint/burn operations list of specific user.
#### Parameters
(1) data:(JSON Object) the query detail\
(2) skip:(Number) the number of leading operations to be ignored\
(3) count:(Number) the maximum number of operations to return
#### Returns
JSON object:\
{\
&nbsp;&nbsp;txs: (Array of JSON objects) transactions in requested range\
&nbsp;&nbsp;&nbsp;&nbsp;[\
&nbsp;&nbsp;&nbsp;&nbsp;For doing request:\
&nbsp;&nbsp;&nbsp;&nbsp;{\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nonce_or_txid:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amount:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user_addr:(string) user address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;to_addr:(string) money to address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;need:(Number) total number of signatures needed,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;signer:(array of string) list of members who have signed,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;has_signed:(bool) whether current member has signed or not,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;status:(string) "doing",\
&nbsp;&nbsp;&nbsp;&nbsp;},\
&nbsp;&nbsp;&nbsp;&nbsp;For finished request:\
&nbsp;&nbsp;&nbsp;&nbsp;{\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nonce_or_txid:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amount:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user_addr:(string) user address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;to_addr:(string) money to address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;status:(string) "finished",\
&nbsp;&nbsp;&nbsp;&nbsp;}...]\
&nbsp;&nbsp;total: (Number) total number of transactions,\
}
#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getSpecificUserOperationList","params":[{"address":"0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5","status":["doing","finished"],"types":["eth_mint","erc20_mint"]},0,100],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": {
		"txs": [{
			"type": "eth_mint",
			"nonce_or_txid": "0xe06818b9da4feef5cd590bd68aa23f13e29ef49354ecdd1ae18b11074bf47478",
			"amount": "1000000000000000",
			"user_addr": "0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5",
			"to_addr": "0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5",
			"status": "finished"
		}, {
			"type": "eth_mint",
			"nonce_or_txid": "0x0002a128139692f866b6a1615ce2c40ad337796fc0ca6e51cc7eb6e30baab760",
			"amount": "1000000000000000",
			"user_addr": "0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5",
			"to_addr": "0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5",
			"status": "finished"
		}],
		"total": 2
	}
}
```
### getWalletTransferList
Get wallet transfer operation list during custodian member changing.
#### Parameters
(1) skip:(Number) the number of leading operations to be ignored\
(2) count:(Number) the maximum number of operations to return
#### Returns
JSON object:\
{\
&nbsp;&nbsp;txs: (Array of JSON objects) transactions in requested range\
&nbsp;&nbsp;&nbsp;&nbsp;[\
&nbsp;&nbsp;&nbsp;&nbsp;For doing request:\
&nbsp;&nbsp;&nbsp;&nbsp;{\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nonce_or_txid:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amount:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user_addr:(string) user address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;to_addr:(string) money to address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;need:(Number) total number of signatures needed,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;signer:(array of string) list of members who have signed,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;has_signed:(bool) whether current member has signed or not,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;status:(string) "doing",\
&nbsp;&nbsp;&nbsp;&nbsp;},\
&nbsp;&nbsp;&nbsp;&nbsp;For finished request:\
&nbsp;&nbsp;&nbsp;&nbsp;{\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nonce_or_txid:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;amount:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user_addr:(string) user address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;to_addr:(string) money to address,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;status:(string) "finished",\
&nbsp;&nbsp;&nbsp;&nbsp;}...]\
&nbsp;&nbsp;total: (Number) total number of transactions,\
}
#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getWalletTransferList","params":[0,100],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": {
		"txs": [{
			"type": "ProfitTransfer",
			"nonce_or_txid": "3",
			"amount": "NaN",
			"user_addr": "2N9rEmrpFA1b7HKZiDghnNEmTy6MDrgV3aC",
			"to_addr": "2N7tUaxmwq9rwtXZUYymiYXnn9s7Vd2hMZp",
			"status": "finished"
		}, {
			"type": "HotTransfer",
			"nonce_or_txid": "ab68b057429271ac11a860002264c77e074d1125e3ee30d865e5276a488fad90",
			"amount": "60000",
			"user_addr": "2MsPJwNqdeUHvxM3munWBxtCE2WncF9PKbZ",
			"to_addr": "2N7UpxpCo6gEpPdjksZPPE9GjTq8JY1KQpz",
			"status": "finished"
		}],
		"total": 2
	}
}
```
### getCustodianInfo
Get information of custodian members.
#### Parameters
None.
#### Returns
JSON objects:\
{\
&nbsp;&nbsp;custodians:(Array of JSON objects):\
&nbsp;&nbsp;&nbsp;&nbsp;[{\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name:(string),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;keys:(JSON object) keys of custodian member,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;join_epoch:(Number) epoch the member joined the custodian,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sig_cnt:(string) times of multi-signature the member participated in,\
&nbsp;&nbsp;&nbsp;&nbsp;}, ...],\
&nbsp;&nbsp;op_cnt:(Number) total number of multi-signature operations,\
}
#### Example
```bash
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getCustodianInfo","params":[],"id":1}' -H "Content-Type: application/json" http://52.141.20.168:8001
{
	"jsonrpc": "2.0",
	"id": 1,
	"result": {
		"custodians": [{
			"name": "fafa",
			"keys": {
				"cfx_hot": "0x81f3521d71990945b99e1c592750d7157f2b544f",
				"cfx_cold": "0x81f3521d71990945b99e1c592750d7157f2b544f",
				"eth_hot": "0x6B6C3A1eC5C689C3dd158b1a6E8Bc722373a2BfA",
				"eth_cold": "0x6B6C3A1eC5C689C3dd158b1a6E8Bc722373a2BfA",
				"btc_hot": "021a72579a46e91c11cc01f8e072c4a4eedfc477bfc8f2925e02ec006420b4cfc8",
				"btc_cold": "039802c21509fdcec599680c04a7e93234a954997184aeccaf96006fe8c3c68b74"
			},
			"join_epoch": 1578246,
			"sig_cnt": 5
		}, {
			"name": "ppd",
			"keys": {
				"cfx_hot": "0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5",
				"cfx_cold": "0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5",
				"eth_hot": "0x578Dd2BFc41bb66e9f0ae0802C613996440C9597",
				"eth_cold": "0x578Dd2BFc41bb66e9f0ae0802C613996440C9597",
				"btc_hot": "02af37a0dbdb234f8f522b8980c9100b4a9cc989be54a09354a12f4122a7e2b87c",
				"btc_cold": "03919638867f7e32c58d902a7b95ccfe1bfd928fc44544e0414be99f6addcee790"
			},
			"join_epoch": 1578246,
			"sig_cnt": 5
		}, {
			"name": "autumn",
			"keys": {
				"cfx_hot": "0x2338f8646aeaa5a32d374fae49ee7aae6bca1efc",
				"cfx_cold": "0x2338f8646aeaa5a32d374fae49ee7aae6bca1efc",
				"eth_hot": "0xF0D8ABE44f98F198F1DB255A7833F27a28774D35",
				"eth_cold": "0xF0D8ABE44f98F198F1DB255A7833F27a28774D35",
				"btc_hot": "028ff2d81abce71ab8b910f4b604b976907f7310cf8970093f09bb7726f14d7534",
				"btc_cold": "028ff2d81abce71ab8b910f4b604b976907f7310cf8970093f09bb7726f14d7534"
			},
			"join_epoch": 1579865,
			"sig_cnt": 0
		}],
		"op_cnt": 18
	}
}
```

### getBounds
Get bounds of tokens.
#### Parameters
None.
#### Returns
JSON object
#### Example
```
$ curl -X POST --data '{"jsonrpc":"2.0","method":"getBounds","params":[],"id":1}' -H "Content-Type: application/json" http://52.141.21.174:8001
{
 "eth": {
  "lower_bound": "0",
  "upper_bound": "10000000000000000"
 },
 "btc": {
  "lower_bound": "0",
  "upper_bound": "10000000000"
 },
 "usdt": {
  "lower_bound": "0",
  "upper_bound": "10000000000000000"
 }
}
```
