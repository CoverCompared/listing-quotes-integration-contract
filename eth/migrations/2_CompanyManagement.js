const CompanyManagement = artifacts.require("./CompanyManagement.sol");

module.exports = function (deployer) {
  deployer.deploy(CompanyManagement);
};
