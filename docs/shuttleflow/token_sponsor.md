### TokenSponsor

`TokenSponsor` is the contract to manage sponsor information of cross chain tokens.

### Core Storage Variables
```solidity
mapping(string => address) token_sponsor;
```
Mapping of reference token to its sponsor's conflux address.
```solidity
mapping(string => uint256) token_sponsor_value;
```
Mapping of reference token to its remaining sponsored cETH value.
```solidity
uint256 public sponsor_replace_ratio; // per cent
```
A percent ratio when a user want to replace the sponsor of a token `t`, he/she must mortgage 
more than `token_sponsor_value[t]*(100+sponsor_replace_ratio)/100` cETH.