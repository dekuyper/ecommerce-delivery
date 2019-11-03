const EcommerceDelivery = artifacts.require("EcommerceDelivery");

module.exports = function(deployer) {
  deployer.deploy(EcommerceDelivery);
};
