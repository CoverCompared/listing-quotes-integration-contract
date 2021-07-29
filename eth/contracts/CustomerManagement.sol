// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "../node_modules/@openzeppelin/contracts/access/AccessControlEnumerable.sol";

contract CustomerManagement is AccessControlEnumerable {
    bytes32 public constant UPDATE_ROLE = keccak256("UPDATE_ROLE");

    /**
     * @dev Grants `DEFAULT_ADMIN_ROLE`, `UPDATE_ROLE` to the
     * account that deploys the contract.
     */

    constructor() {
        owner = msg.sender;

        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _setupRole(UPDATE_ROLE, _msgSender());
    }

    address owner;

    struct Product {
        bytes32 productProvider;
        bytes32 productId;
        uint256 amount;
        bytes32 currency;
        bytes32 period;
    }

    mapping(address => Product[]) products;
    address[] public addresses;

    /**
     * Buy a product
     */
    event boughtProduct(address buyer, bytes32 _provider);

    /**
     * @dev buyProduct
     * only accessible by user having `UPDATE_ROLE`
     * or account that deploys the contract.
     */

    function buyProduct(
        bytes32 _provider,
        bytes32 _id,
        uint256 _amount,
        bytes32 _currency,
        bytes32 _period,
        address _address
    ) public {
        require(hasRole(UPDATE_ROLE, _msgSender()));
        Product[] storage product = products[_address];

        product.push(Product(_provider, _id, _amount, _currency, _period));
        addresses.push(_address);

        emit boughtProduct(_address, _provider);
    }

    function getIdxLength() public view returns (uint256) {
        return addresses.length;
    }

    function getProducts(address _address)
        public
        view
        returns (Product[] memory)
    {
        return (products[_address]);
    }
}
