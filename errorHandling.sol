// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FoodDelivery {
    address public owner;
    uint256 public orderCount = 0;

    enum OrderStatus { Placed, Paid, Delivered, Cancelled }

    struct Order {
        uint256 id;
        address customer;
        string foodItem;
        uint256 price;
        OrderStatus status;
    }

    mapping(uint256 => Order) public orders;

    event OrderPlaced(uint256 orderId, address customer, string foodItem, uint256 price);
    event OrderPaid(uint256 orderId);
    event OrderDelivered(uint256 orderId);
    event OrderCancelled(uint256 orderId);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    modifier onlyCustomer(uint256 _orderId) {
        require(msg.sender == orders[_orderId].customer, "Only the customer can perform this action");
        _;
    }

    function placeOrder(string memory _foodItem, uint256 _price) public {
        require(bytes(_foodItem).length > 0, "Food item must be specified");
        require(_price > 0, "Price must be greater than zero");

        orderCount++;
        orders[orderCount] = Order(orderCount, msg.sender, _foodItem, _price, OrderStatus.Placed);

        emit OrderPlaced(orderCount, msg.sender, _foodItem, _price);
    }

    function payForOrder(uint256 _orderId) public payable onlyCustomer(_orderId) {
        Order storage order = orders[_orderId];

        require(msg.value == order.price, "Incorrect payment amount");
        require(order.status == OrderStatus.Placed, "Order must be in 'Placed' status");

        order.status = OrderStatus.Paid;

        emit OrderPaid(_orderId);
    }

    function deliverOrder(uint256 _orderId) public onlyOwner {
        Order storage order = orders[_orderId];

        require(order.status == OrderStatus.Paid, "Order must be in 'Paid' status");

        order.status = OrderStatus.Delivered;

        emit OrderDelivered(_orderId);
    }

    function cancelOrder(uint256 _orderId) public onlyCustomer(_orderId) {
        Order storage order = orders[_orderId];

        require(order.status == OrderStatus.Placed, "Order can only be cancelled if it is in 'Placed' status");

        order.status = OrderStatus.Cancelled;

        emit OrderCancelled(_orderId);
    }

    function assertOrder(uint256 _orderId) public view {
        assert(_orderId > 0 && _orderId <= orderCount);
        assert(orders[_orderId].id == _orderId);
    }

    function revertOrder(uint256 _orderId) public view {
        if (_orderId == 0 || _orderId > orderCount) {
            revert("Order does not exist");
        }
    }
}
