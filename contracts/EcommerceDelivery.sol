pragma solidity ^0.5.12;

contract EcommerceDelivery {

    struct Order {
        address buyer;
        address courier;
        uint256 value;
        bool buyerConfirmed;
        bool courierConfirmed;
    }

    mapping (uint256 => Order) public orders;

    address payable private _owner;

    modifier onlyOwner()
    {
        require(msg.sender == _owner, "You are not the owner!");
        _;
    }

    modifier onlyWithValue()
    {
        require(msg.value > 0, "There has to be some mone'");
        _;
    }

    constructor() public {
        _owner = msg.sender;
    }

    // PUBLIC API
    function placeOrder(address buyer, uint256 orderId)
    public
    payable
    onlyWithValue
    {
        orders[orderId] = Order(buyer, address(0), msg.value, false, false);
    }

    function dispatchOrder(uint256 orderId, address courier)
    public
    onlyOwner
    {
        Order storage order = orders[orderId];
        order.courier = courier;
    }

    function orderReceived(uint256 orderId)
    public
    {
        Order storage order = orders[orderId];
        require(msg.sender == order.buyer || msg.sender == order.courier, "Not your order!");

        if(msg.sender == order.buyer)
            order.buyerConfirmed = true;

        if(msg.sender == order.courier)
            order.courierConfirmed = true;

        if(order.buyerConfirmed && order.courierConfirmed)
            _owner.transfer(order.value);
    }

}
