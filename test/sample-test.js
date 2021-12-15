const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NFTOwnerCloset", function () {
  it("Should...", async function () {
    const NFTOwnerCloset = await ethers.getContractFactory("NFTOwnerCloset");
    const closet = await NFTOwnerCloset.deploy();
    await closet.deployed();

  });
});
