# FoodDelivery Smart Contract

## Overview
The `FoodDelivery` smart contract is a decentralized application built on the Ethereum blockchain that allows users to place, pay for, and manage food delivery orders. The contract ensures secure and transparent handling of order placements, payments, deliveries, and cancellations.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contract Details

### State Variables
- `address public owner`: The owner of the contract, set to the address that deploys the contract.
- `uint256 public orderCount`: The total number of orders placed.
- `enum OrderStatus { Placed, Paid, Delivered, Cancelled }`: Enumeration representing the possible statuses of an order.
- `struct Order`: A structure representing an order, containing:
  - `uint256 id`: The unique ID of the order.
  - `address customer`: The address of the customer who placed the order.
  - `string foodItem`: The food item ordered.
  - `uint256 price`: The price of the food item.
  - `OrderStatus status`: The current status of the order.

### Mappings
- `mapping(uint256 => Order) public orders`: Maps an order ID to an `Order` struct.

### Events
- `event OrderPlaced(uint256 orderId, address customer, string foodItem, uint256 price)`: Emitted when an order is placed.
- `event OrderPaid(uint256 orderId)`: Emitted when an order is paid.
- `event OrderDelivered(uint256 orderId)`: Emitted when an order is delivered.
- `event OrderCancelled(uint256 orderId)`: Emitted when an order is cancelled.

## Functions

### Constructor
- `constructor()`: Sets the owner of the contract to the address that deploys it.

### Modifiers
- `modifier onlyOwner()`: Restricts the function to be executed only by the owner.
- `modifier onlyCustomer(uint256 _orderId)`: Restricts the function to be executed only by the customer who placed the order.

### Core Functions
- `function placeOrder(string memory _foodItem, uint256 _price) public`: Allows a user to place an order with a specified food item and price.
- `function payForOrder(uint256 _orderId) public payable onlyCustomer(_orderId)`: Allows the customer to pay for their order. The payment must match the order price.
- `function deliverOrder(uint256 _orderId) public onlyOwner`: Allows the owner to mark an order as delivered.
- `function cancelOrder(uint256 _orderId) public onlyCustomer(_orderId)`: Allows the customer to cancel their order if it is still in the 'Placed' status.

### Utility Functions
- `function assertOrder(uint256 _orderId) public view`: Asserts that the given order ID is valid and matches the order stored in the contract.
- `function revertOrder(uint256 _orderId) public view`: Reverts if the given order ID is invalid.

## Usage

### Deploying the Contract
1. Deploy the `FoodDelivery` contract to the Ethereum blockchain.
2. The deployer's address will be set as the `owner` of the contract.

### Placing an Order
1. Call `placeOrder` with the food item and price.
2. The contract will emit an `OrderPlaced` event with the order details.

### Paying for an Order
1. Call `payForOrder` with the order ID and send the exact payment amount.
2. The contract will update the order status to `Paid` and emit an `OrderPaid` event.

### Delivering an Order
1. The owner calls `deliverOrder` with the order ID.
2. The contract updates the order status to `Delivered` and emits an `OrderDelivered` event.

### Cancelling an Order
1. The customer calls `cancelOrder` with the order ID.
2. The contract updates the order status to `Cancelled` and emits an `OrderCancelled` event.

## Notes
- Ensure the food item string is not empty and the price is greater than zero when placing an order.
- Payments must match the exact price specified in the order.
- Only the owner can deliver orders.
- Customers can only cancel orders that are still in the 'Placed' status.

## Security Considerations
- The contract includes checks to ensure only the rightful customer or owner can execute specific actions.
- The `assertOrder` and `revertOrder` functions help validate order existence and integrity.

## Contact
For any questions or issues, please open an issue on the [GitHub repository](https://github.com/your-repo/food-delivery).
