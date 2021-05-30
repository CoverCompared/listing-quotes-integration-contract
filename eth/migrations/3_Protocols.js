const Protocols = artifacts.require("./Protocols.sol");

module.exports = function (deployer) {
  deployer.deploy(Protocols);
};