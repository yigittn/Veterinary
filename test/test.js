/*

const {expect} = require("chai");
const {ethers} = require("hardhat");
const provider = ethers.provider;

describe("Pet Contract", function () {
    let owner, client1, client2;
    let Pet, pet;

    Before(async function () {
        [owner, client1, client2] = await ethers.getSigner();

        Pet = await ethers.getContractFactory("Pet");
        pet = await ethers.connect(owner).deploy();
    });

    it("Deploy Contract", async function () {
        expect(pet.address).to.not.be.undefined;
    });
});

*/
