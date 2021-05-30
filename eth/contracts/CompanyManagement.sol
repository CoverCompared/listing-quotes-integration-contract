pragma solidity ^0.8.4;

contract CompanyManagement {
    constructor() {
        owner = payable(msg.sender);
    }

    address payable owner;

    modifier onlyOwnerCanDoIt {
        require(msg.sender == owner, "You are not the owner!");
        _;
    }

    enum status {A, B, S, N, V}
    //ACTIVE, BANNED, SUSPENDED, NOTACTIVE, VERYSOON
    status choice;

    struct Company {
        string name;
        string link;
        status Status;
        // mapping(uint256 => Product) products;
        // uint256[] productIDX;
        string apiProductListing;
        string apiQuoteListing;
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

    mapping(uint256 => Company) companies;
    uint256[] public idx;

    function setCompany(
        status _status,
        string memory link,
        string memory name,
        string memory apiProduct,
        string memory apiQuote
    ) public onlyOwnerCanDoIt {
        Company storage company = companies[idx.length];

        company.name = name;
        company.link = link;
        company.Status = _status;
        company.apiProductListing = apiProduct;
        company.apiQuoteListing = apiQuote;

        idx.push(idx.length + 1);
    }

    function getIdxLength() public view returns (uint256) {
        return idx.length;
    }

    function getCompany(uint256 id)
        public
        view
        returns (
           
            string memory,
            string memory,
            status,
            string memory,
            string memory
        )
    {
        return (
            companies[id].link,
            companies[id].name,
            companies[id].Status,
            companies[id].apiProductListing,
            companies[id].apiQuoteListing
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
        returns (
            string memory,
            string memory,
            status
        )
    {
        Company storage company = companies[_id];
        company.Status = _status;

        return (
            companies[_id].link,
            companies[_id].name,
            companies[_id].Status
        );
    }

    function updateLogo(string memory logoLink, uint256 _id)
        public
        onlyOwnerCanDoIt
        returns (
            
            string memory,
            string memory,
            status
        )
    {
        Company storage company = companies[_id];
        company.link = logoLink;

        return (
           
            companies[_id].link,
            companies[_id].name,
            companies[_id].Status
        );
    }
}
