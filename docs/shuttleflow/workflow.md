# The Shuttleflow Work Process

In this section, we will introduce the work process of shuttleflow: user migrate asset from Ethereum to Conflux (Shuttle-in) and transfer back to Ethereum (Shuttle-out).

## Shuttle-in

When users want to migrate assets on Ethereum such as ETH or ERC20 token to Conflux:

1. Send an Ethereum transaction to call [Deposit Relayer contract](deposit_relayer.md), in this transaction, user will specify the token, value and Conflux recipient address.

2. Check corresponding cToken balance in conflux wallet after custodian alliance processed user's request.

## Shuttle-out

When users already have some cToken and want to migrate them back to Ethereum:

1. Send a Conflux transaction to call the `burn` function of [cToken](token_base.md), in this transaction, user will specify the value, max tolerable shuttle-out fee and Ethereum ricipent address.

2. Check ETH or corresponding ERC20 balance in Ethereum wallet after custodian alliance processed user's request.