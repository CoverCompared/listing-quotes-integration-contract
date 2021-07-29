// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.6;

contract CompanyManagementModify {
    constructor() {
        owner = payable(msg.sender);
    }

    address payable owner;

    enum status {
        Active,
        Banned,
        Suspended,
        Inactive,
        ComingSoon
    }

    struct Company {
        string name;
        string link;
        status Status;
        // mapping(uint256 => Product) products;
        // uint256[] productIDX;
        string apiProductListing;
        string apiQuoteListing;
        string apiThirdListing;
    }

    //Things to add
    //4. Adding an array of struct in the Company Struct regarding the policies they offer.

    // struct Product {
    //     uint256 productID;
    //     string productName;
    //     productStatus Status;
    //     // uint256 productPrice;
    //     // string currency;
    //     // uint256 productCoverageDates;
    //     // uint256 productPremium;
    // }
    // enum productStatus {ACTIVE, NOTACTIVE}

    Company[] public companies;
    uint32[] public deleteFlags;

    modifier onlyOwnerCanDoIt() {
        require(msg.sender == owner, "You are not the owner!");
        _;
    }

    modifier onlyUndeleted(uint256 _id) {
        require(deleteFlags[_id] == 0);
        _;
    }

    function createCompany(
        status _status,
        string memory _link,
        string memory _name,
        string memory _apiProduct,
        string memory _apiQuote,
        string memory _apiThird
    ) public onlyOwnerCanDoIt {
        companies.push(
            Company(_name, _link, _status, _apiProduct, _apiQuote, _apiThird)
        );
        deleteFlags.push(0);
    }

    function deleteCompany(uint32 _id) public onlyOwnerCanDoIt {
        deleteFlags[_id] = 1;
    }

    function getCompany(uint256 _id)
        public
        view
        onlyUndeleted(_id)
        returns (
            string memory,
            string memory,
            status,
            string memory,
            string memory
        )
    {
        return (
            companies[_id].link,
            companies[_id].name,
            companies[_id].Status,
            companies[_id].apiProductListing,
            companies[_id].apiQuoteListing
        );
    }

    // function getProduct(uint256 _id, uint256 _productID)
    //     public
    //     view
    //     returns (string memory _productName, productStatus _status)
    // {
    //     return (
    //         companies[_id].products[_productID].productName,
    //         companies[_id].products[_productID].Status
    //     );
    // }

    // function getProductListLength(uint256 _id)
    //     public
    //     view
    //     returns (uint256 length)
    // {
    //     return (companies[_id].productIDX.length);
    // }

    // function updateProductStatus(
    //     productStatus _status,
    //     uint256 _companyId,
    //     uint256 _productId
    // )
    //     public
    //     returns (
    //         uint256 _productID,
    //         productStatus _newStatus,
    //         string memory _productName
    //     )
    // {
    //     Product storage product = companies[_companyId].products[_productId];

    //     product.Status = _status;

    //     return (product.productID, product.Status, product.productName);
    // }

    // function addProduct(
    //     uint256 _id,
    //     uint256 _productID,
    //     productStatus _status,
    //     string memory _productName
    // ) public onlyOwnerCanDoIt {
    //     Product storage product =
    //         companies[_id].products[companies[_id].productIDX.length];

    //     product.productID = _productID;
    //     product.productName = _productName;
    //     product.Status = _status;

    //     companies[_id].productIDX.push(companies[_id].productIDX.length + 1);
    // }

    function updateStatus(status _status, uint256 _id)
        public
        onlyOwnerCanDoIt
        onlyUndeleted(_id)
        returns (
            string memory,
            string memory,
            status
        )
    {
        companies[_id].Status = _status;

        return (
            companies[_id].link,
            companies[_id].name,
            companies[_id].Status
        );
    }

    function updateLink(string memory _link, uint256 _id)
        public
        onlyOwnerCanDoIt
        onlyUndeleted(_id)
        returns (
            string memory,
            string memory,
            status
        )
    {
        companies[_id].link = _link;

        return (
            companies[_id].link,
            companies[_id].name,
            companies[_id].Status
        );
    }

    function updateApiProduct(string memory _apiProduct, uint256 _id)
        public
        onlyOwnerCanDoIt
        onlyUndeleted(_id)
        returns (
            string memory,
            string memory,
            status
        )
    {
        companies[_id].apiProductListing = _apiProduct;

        return (
            companies[_id].link,
            companies[_id].name,
            companies[_id].Status
        );
    }

    function updateApiQuote(string memory _apiQuote, uint256 _id)
        public
        onlyOwnerCanDoIt
        onlyUndeleted(_id)
        returns (
            string memory,
            string memory,
            status
        )
    {
        companies[_id].apiQuoteListing = _apiQuote;

        return (
            companies[_id].link,
            companies[_id].name,
            companies[_id].Status
        );
    }

    function updateApiThird(string memory _apiThird, uint256 _id)
        public
        onlyOwnerCanDoIt
        onlyUndeleted(_id)
        returns (
            string memory,
            string memory,
            status
        )
    {
        companies[_id].apiThirdListing = _apiThird;

        return (
            companies[_id].link,
            companies[_id].name,
            companies[_id].Status
        );
    }
}
