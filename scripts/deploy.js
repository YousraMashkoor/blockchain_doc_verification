const hre = require("hardhat");

async function main() {
 

  // We get the contract to deploy
  const Cert = await hre.ethers.getContractFactory("certificate");
  const cert = await Cert.deploy();


  await cert.deployed();
  console.log("Certification contract is deployed to:", cert.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });