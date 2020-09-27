# The Shuttleflow Smart Contracts Design and Implementation

## Design Goals

The Shuttleflow smart contracts have following design goals:

1. Support atomic mapping between Conflux cToken and cross chain assets including BTC, ETH and ERC20 tokens.
2. Maintain the membership and authority of custodian alliance.
3. Pausable and upgradable, data migration.

The code of smart contract will open source in future.

## Components (on Conflux)

* [CustodianCore](custodian_core.md): crosschain goverance contract
* [TokenSponsor](token_sponsor.md): token sponsor contract
* [TokenBase](token_base.md): cToken contract

## Components (on Ethereum)

* [EthFactory](eth_factory.md): crosschain goverance contract on ethereum
* [DefiRelayer](defi_relayer.md): the defi relayer contract for defi on ethereum who want to receive assets migrated from conflux chain.

