# MatchFlow WebSocket API
**MatchFlow WebSocket API** provides pub/sub way to monitor the market data and user data, including orders, trades and balance changes.

## General
### Websocket URL
ws://${conflux_dex_url}/ws

### Heartbeat and Connection
Websocket server will send `PING` heartbeat message periodically (20 seconds) with an integer number. When client receives the heartbeat message, it should response with a matching `PONG` message which has the same integer number.

Websocket server will disconnect clients if there is no communication message (inclues `PING` message) in 30 seconds.

On the other hand, Websocket server will periodically (20 seconds) disconnect clients if no topic subscribed.

### Subscribe to Topic
To subscribe a topic, please send below message to Websocket server:
```json
{
    "topic": "topic name",
    "sub": true,
    "arguments": {}
}
```
The `arguments` is used to specify additional parameters to subscribe a topic, e.g. specify user address to subscribe **Asset** or **Order** related topics.

### Unsubscribe
To unsubscribe, please send below message to Websocket server:
```json
{
    "topic": "topic name",
    "sub": false
}
```

### Topic Response
Websocket server push messages of different topics in the same format as below:
```json
{
	"topic": "topic name",
	"timestamp": 1582609926336,
	"data": {}
}
```
As for the `data` value, please refer to the **Update Content** that defined for each topic.

## Market Data

### Best Bid/Offer
#### Topic
`market.$product.bbo`
#### Update Content
```java
public class BestBidOffer {
	/**
	 * Product name.
	 */
	private String product;
	/**
	 * Quote timestamp.
	 */
	private Instant quoteTime;
	/**
	 * Best bid price.
	 */
	private BigDecimal bid;
	/**
	 * Best bid amount.
	 */
	private BigDecimal bidAmount;
	/**
	 * Best bid order count.
	 */
	private int bidCount;
	/**
	 * Best ask price.
	 */
	private BigDecimal ask;
	/**
	 * Best ask amount.
	 */
	private BigDecimal askAmount;
	/**
	 * Best ask order count.
	 */
	private int askCount;
}
```
### Market Depth
#### Topic
`market.$product.depth.$step`

`$step`: market depth aggregation level, including "step0", "step1", "step2", "step3", "step4" and "step5". For "step0", market depth data supports up to 150 levels. For others, market depth data supports up to 20 levels.
#### Update Content
```json
{
    "Buy": [{}],
    "Sell": [{}]
}
```
```java
public class DepthPriceLevel {
	/**
	 * Order price.
	 */
	private BigDecimal price;
	/**
	 * Total amount in all orders.
	 */
	private BigDecimal amount;
	/**
	 * Total number of all orders.
	 */
	private int count;
}
```

### Market Details in Last 24 Hours
#### Topic
`market.$product.detail`
#### Update Content
```java
public class Tick implements Cloneable {
	/**
	 * Tick id. (auto-generated)
	 */
	private long id;
	/**
	 * Referenced product id.
	 */
	private int productId;
	/**
	 * Tick granularity in minutes.
	 */
	private int granularity;
	/**
	 * Tick open value.
	 */
	private BigDecimal open;
	/**
	 * Tick high value.
	 */
	private BigDecimal high;
	/**
	 * Tick low value.
	 */
	private BigDecimal low;
	/**
	 * Tick close value.
	 */
	private BigDecimal close;
	/**
	 * Total volume of base currency.
	 */
	private BigDecimal baseCurrencyVolume;
	/**
	 * Total volume of quote currency.
	 */
	private BigDecimal quoteCurrencyVolume;
	/**
	 * Total number of trades.
	 */
	private int count;
	/**
	 * Tick creation timestamp.
	 */
	private Timestamp createTime;
	/**
	 * Last update timestamp.
	 */
	private Timestamp updateTime;
}
```

### Market Tick
#### Topic
`market.$product.tick.$granularity`

`$granularity`: tick granularity, including 1min, 5min, 15min, 30min, 60min, 1day, 1week and 1month.

#### Update Content
```java
public class Tick implements Cloneable {
	/**
	 * Tick id. (auto-generated)
	 */
	private long id;
	/**
	 * Referenced product id.
	 */
	private int productId;
	/**
	 * Tick granularity in minutes.
	 */
	private int granularity;
	/**
	 * Tick open value.
	 */
	private BigDecimal open;
	/**
	 * Tick high value.
	 */
	private BigDecimal high;
	/**
	 * Tick low value.
	 */
	private BigDecimal low;
	/**
	 * Tick close value.
	 */
	private BigDecimal close;
	/**
	 * Total volume of base currency.
	 */
	private BigDecimal baseCurrencyVolume;
	/**
	 * Total volume of quote currency.
	 */
	private BigDecimal quoteCurrencyVolume;
	/**
	 * Total number of trades.
	 */
	private int count;
	/**
	 * Tick creation timestamp.
	 */
	private Timestamp createTime;
	/**
	 * Last update timestamp.
	 */
	private Timestamp updateTime;
}
```

### Trade Detail
#### Topic
`market.$product.trade.detail`

#### Update Content
```java
public class Trade {
	/**
	 * Trade id. (auto-generated)
	 */
	private long id;
	/**
	 * Referenced product id.
	 */
	private int productId;
	/**
	 * Referenced taker order id.
	 */
	private long takerOrderId;
	/**
	 * Referenced maker order id.
	 */
	private long makerOrderId;
	/**
	 * Trade price from maker order.
	 */
	private BigDecimal price;
	/**
	 * Trade amount.
	 */
	private BigDecimal amount;
	/**
	 * Taker order side: "Buy", "Sell".
	 */
	private OrderSide side;
	/**
	 * Trade fee of taker side.
	 * For "Buy" order, it is base currency.
	 * For "Sell" order, it is quote currency.
	 */
	private BigDecimal takerFee;
	/**
	 * Trade fee of maker side.
	 * For "Buy" order, it is base currency.
	 * For "Sell" order, it is quote currency.
	 */
	private BigDecimal makerFee;
	/**
	 * Settlement status: "OffChainSettled", "OnChainSettled", "OnChainConfirmed".
	 */
	private SettlementStatus status = SettlementStatus.OffChainSettled;
	/**
	 * Transaction hash of settlement on blockchain.
	 */
	private String txHash;
	/**
	 * Transaction nonce of settlement on blockchain.
	 */
	private long txNonce;
	/**
	 * Create timestamp.
	 */
	private Timestamp createTime = Timestamp.from(Instant.now());
	/**
	 * Update timestamp.
	 */
	private Timestamp updateTime = this.createTime;
}
```

## Asset and Order

### Account Updates
#### Topic
`accounts`

#### Arguments
`address`: user address.  
`model`: trigger mode in integer type.

- 0: Only update when account balance changed;
- 1: Update when either account balance changed or available balance changed.

#### Update Content
```java
public class BalanceChange {
	/**
	 * Balance change type, including "OrderPlace", "OrderMatch", "OrderCancel",
	 * "Deposit", "Withdraw" and "Transfer".
	 */
	private BalanceChangeType type;
	/**
	 * The account id of the changed balance.
	 */
	private long accountId;
	/**
	 * The currency name of the changed balance.
	 */
	private String currency;
	/**
	 * Account balance (only exists when account balance changed).
	 */
	private BigDecimal balance;
	/**
	 * Available balance (only exists when available balance changed).
	 */
	private BigDecimal available;
	/**
	 * Change time, unix timestamp in milliseconds.
	 */
	private long changeTime;
}
```

### Order Updates
#### Topic
`order.$product`

`$product`: product name or **\*** for all products.

#### Arguments
`address`: user address.

#### Update Content
```java
public class OrderChange {
	/**
	 * Changed order ID.
	 */
	private long id;
	/**
	 * Optional client defined order identity, which is unique for a user.
	 */
	private String clientOrderId;
	/**
	 * Product ID of the changed order.
	 */
	private int productId;
	/**
	 * Order type: "Limit", "Market".
	 */
	private OrderType type;
	/**
	 * Order side: "Buy", "Sell".
	 */
	private OrderSide side;
	/**
	 * Order status: "New", "Open", "Cancelling", "Cancelled", "Filled".
	 */
	private OrderStatus status;
	/**
	 * Order price for "Limit" order type only.
	 */
	private BigDecimal price;
	/**
	 * Order amount for "Limit" order type or "Market-Sell" order.
	 * For "Market-Buy" order, it is the total order value.
	 */
	private BigDecimal amount;
	/**
	 * For order matched event, it indicates whether it is a taker order.
	 * For order status changed event, it is true by default.
	 */
	private boolean taker;
	/**
	 * Trade price (only exists for order matched event).
	 */
	private BigDecimal tradePrice;
	/**
	 * Trade amount (only exists for order matched event).
	 */
	private BigDecimal tradeAmount;
	/**
	 * Trade fee (only exists for order matched event).
	 * 
	 * For taker order trade, it is calculated by taker fee rate.
	 * For maker order trade, it is calculated by maker fee rate.
	 * 
	 * For "Buy" order trade, it is base currency.
	 * For "Sell" order trade, it is quote currency.
	 */
	private BigDecimal tradeFee;
	/**
	 * Filled amount of base currency.
	 */
	private BigDecimal filledAmount;
	/**
	 * Filled funds of quote currency.
	 */
	private BigDecimal filledFunds;
}
```

### Trade Details
#### Topic
`trade.$product`

`$product`: product name or **\*** for all products.

#### Arguments
`address`: user address.

#### Update Content
```java
public class UserTrade {
	/**
	 * Trade ID.
	 */
	private long id;
	/**
	 * Product ID.
	 */
	private int productId;
	/**
	 * Order ID.
	 */
	private long orderId;
	/**
	 * Order type: "Limit", "Market".
	 */
	private OrderType orderType;
	/**
	 * Order side: "Buy", "Sell".
	 */
	private OrderSide orderSide;
	/**
	 * Trade price from maker order.
	 */
	private BigDecimal tradePrice;
	/**
	 * Trade amount.
	 */
	private BigDecimal tradeAmount;
	/**
	 * Trade fee.
	 * 
	 * For taker order trade, it is calculated by taker fee rate.
	 * For maker order trade, it is calculated by maker fee rate.
	 * 
	 * For "Buy" order trade, it is base currency.
	 * For "Sell" order trade, it is quote currency.
	 */
	private BigDecimal tradeFee;
	/**
	 * Whether the trade is from taker order.
	 */
	private boolean taker;
	/**
	 * Trade time, unix timestamp in milliseconds.
	 */
	private long tradeTime;
}
```