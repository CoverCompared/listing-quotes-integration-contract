const CompanyManagement = artifacts.require("CompanyManagement");
const companiesInfo = [
    {
        name: 'Company1',
        link: 'TestLink1',
        status: 0,
        apiProductListing: 'test',
        apiQuoteListing: 'test',
    },
    {
        name: 'Company2',
        link: 'TestLink2',
        status: 2,
        apiProductListing: 'test',
        apiQuoteListing: 'test',
    },
]

contract("CompanyManagement", (accounts) => {
    let [alice, bob] = accounts;
    before(async () => {
        this.contractInstance = await CompanyManagement.new();
    });

    it("should be able to create a new company", async () => {
        const address = "0x627306090abaB3A6e1400e9345bC60c78a8BEf57";
        const result = await this.contractInstance.setCompany(
            1,
            "test",
            "test",
            "test",
            "test",
            address,
            { from: alice });

        const currentCompany = await this.contractInstance.getCompany(address);
        assert.equal(currentCompany.link, "test");

        const currentProducts = await this.contractInstance.getProductList();
        console.log(currentProducts);
    })
})
