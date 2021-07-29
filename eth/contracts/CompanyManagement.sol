// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../node_modules/@openzeppelin/contracts/access/AccessControlEnumerable.sol";

contract CompanyManagement is AccessControlEnumerable {
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

    enum status {
        A,
        B,
        S,
        N,
        V
    }
    status choice;

    struct Company {
        bytes32 name;
        bytes32 link;
        status Status;
        bytes32 apiProductListing;
        bytes32 apiQuoteListing;
    }

    mapping(address => Company) companies;
    address[] public addresses;

    /**
     * @dev Add company
     * only accessible by user having `UPDATE_ROLE`
     * or account that deploys the contract.
     */

    function setCompany(
        status _status,
        bytes32 link,
        bytes32 name,
        bytes32 apiProduct,
        bytes32 apiQuote,
        address _address
    ) public {
        require(hasRole(UPDATE_ROLE, _msgSender()));
        Company storage company = companies[_address];

        company.name = name;
        company.link = link;
        company.Status = _status;
        company.apiProductListing = apiProduct;
        company.apiQuoteListing = apiQuote;

        addresses.push(_address);
    }

    function getIdxLength() public view returns (uint256) {
        return addresses.length;
    }

    function getCompany(address _address)
        public
        view
        returns (Company memory company)
    {
        return (companies[_address]);
    }

    /**
     * @dev Updae status of company
     * only accessible by user having `UPDATE_ROLE`
     * or account that deploys the contract.
     */

    function updateStatus(status _status, address _address) public {
        require(hasRole(UPDATE_ROLE, _msgSender()));
        Company storage company = companies[_address];
        company.Status = _status;
    }
}

