// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract veterinary {


    enum Situation {
        Accepted,
        FirstVaccine, 
        SecondVaccine, 
        ThirdVaccine, 
        Finished
    }


    struct Client {
        address PetOwner;
        string PetSpecies;
        bool Registered;
        Situation situation;
    }


    Client[] public clients;
    address public owner;
    uint256 fee = 1 ether;


    event Welcome(address indexed sender);
    event leaved(address indexed sender);
    event Updated(uint256 id);
    event deletedUser(uint256 id);
    event Withdraw(string message);
    event Fixed(address indexed sender,uint256 id, string message);


    constructor() {
        owner = msg.sender;
    }


    function getRegister(string memory _petspecies) external payable{
        require(msg.value == fee,"Fee is 1 Ether");
        
        Client memory client;
        client.PetOwner = msg.sender;
        client.PetSpecies = _petspecies;
        client.Registered = true;
        client.situation = Situation.Accepted;
        clients.push(client);
       
        emit Welcome(msg.sender);

    }


    function updateSituation(uint256 _clientId) external onlyOwner {
        require(_clientId < clients.length, "Invalid client id");

        Client storage client = clients[_clientId];

        if(client.situation == Situation.Accepted){
        client.situation = Situation.FirstVaccine;
        }else if(client.situation == Situation.FirstVaccine){
        client.situation = Situation.SecondVaccine;    
        }else if(client.situation == Situation.SecondVaccine){
        client.situation = Situation.ThirdVaccine;   
        }else if(client.situation == Situation.ThirdVaccine){
        client.situation = Situation.Finished;
        }

        emit Updated(_clientId);
    }

    // Belki updateti geri alma fonksiyonu yapılabilir.


    function leaveTheVeterinary(uint256 _clientId) external {
        require(_clientId < clients.length, "Invalid client id");
        Client storage client = clients[_clientId];
        require(client.PetOwner == msg.sender, "Invalid client id");
        delete clients[_clientId];
       
        emit leaved(msg.sender);
    }


    function fixThePetSpecies(uint256 _clientId, string memory _petspecies) external {
        
        require(_clientId < clients.length, "Invalid client id");
        Client storage client = clients[_clientId];
        require(client.PetOwner == msg.sender, "Invalid client id");
        client.PetSpecies = _petspecies;

        emit Fixed(msg.sender, _clientId, _petspecies);

    }


    /* 
    function readClientSituation(uint256 _clientId)  external view returns(Client memory){
        require(_clientId < clients.length,"Client not found");
        Client memory client = clients[_clientId];
        return client;
    }
    */


    function deleteMember(uint256 _clientId) external onlyOwner{

        delete clients[_clientId];

        emit deletedUser(_clientId);

    }


    function WithdrawMoney() external onlyOwner {

        payable(msg.sender).transfer(address(this).balance);  
        emit Withdraw("Owner withdrawed balance");
    }


    modifier onlyOwner() {
        require(msg.sender == owner, "onlyOwner");
        
       _;
    }


}