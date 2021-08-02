// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "../node_modules/@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "../node_modules/@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract CompanyManagement is AccessControlEnumerable, ChainlinkClient {
    bytes32 public constant UPDATE_ROLE = keccak256("UPDATE_ROLE");

    /**
     * @dev Grants `DEFAULT_ADMIN_ROLE`, `UPDATE_ROLE` to the
     * account that deploys the contract.
     */

    using Chainlink for Chainlink.Request;
    address private oracle;
    bytes32 private jobId;
    uint256 private fee;
    uint256 private list;

    constructor() {
        owner = msg.sender;
        oracle = 0x2f90A6D021db21e1B2A077c5a37B3C7E75D15b7e;
        jobId = "29fa9aa13bf1468788b7cc4a500a45b8";
        fee = 1; // (Varies by network and job)
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
        string name;
        string link;
        status Status;
        string apiProductListing;
        string apiQuoteListing;
    }

    mapping(address => Company) companies;
    address[] public addresses;

    /**
     * New company has been added
     */
    event newCompany(address company, string name);

    /**
     * Company status has been updated
     */
    event statusChanged(address company, string name, status newStatus);

    /**
     * @dev Add company
     * only accessible by user having `UPDATE_ROLE`
     * or account that deploys the contract.
     */

    function setCompany(
        status _status,
        string memory link,
        string memory name,
        string memory apiProduct,
        string memory apiQuote,
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

        emit newCompany(_address, name);
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

        emit statusChanged(_address, company.name, _status);
    }

    function getProductList() public returns (bytes32 requestId) {
        Chainlink.Request memory request = buildChainlinkRequest(
            jobId,
            address(this),
            this.fulfill.selector
        );
        request.add("get", "https://api.nsure.network/v1/get_quote");
        request.add("path", "result.list");
        request.addInt("product", 1);
        request.add("amount", "1000000000000000000");
        request.addInt("period", 30);
        request.addInt("currency", 0);

        // Sends the request
        return sendChainlinkRequestTo(oracle, request, fee);
    }

    function fulfill(bytes32 _requestId, uint256 _list)
        public
        recordChainlinkFulfillment(_requestId)
    {
        list = _list;
    }
}
