// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
contract dClap {
    
    address tokenAddress = 
   mapping(uint256 => mapping (address => Society_members)) Society;
    struct Society_members
    {
        uint256 resident_id;
        string name;
        uint256 phone_no;
        bool active;
    }
    mapping(address => Workers) worker;
    struct Workers
    {
        uint256 worker_id;
        string name;
        uint256 phone_no;
        bool active;
    }
    function addSociety(uint256 resident_id,string memory name,uint256 phone_no) public {
        uint256 society_id =0;
        Society[society_id][msg.sender]=Society_members(resident_id,name,phone_no,true);//atleast one resident is reqd to register
        society_id++;

    }
    function addMembers_to_society(uint256 society_id,address resident_address,uint256 resident_id,string memory name,uint256 phone_no) public 
    {
        require(Society[society_id][resident_address].active == false,"Already in society");
        Society[society_id][resident_address]=Society_members(resident_id,name,phone_no,true);

    }
    function deleteMembers_from_society(uint256 society_id) public 
    {
        require(Society[society_id][msg.sender].active == true,"not from this society");
        Society[society_id][msg.sender].active = false;
    }

    function registerWorkers(uint256 worker_id,string memory name,uint256 phone_no)public 
    {
        require(worker[msg.sender].active==false,"Already registered");
        worker[msg.sender]=Workers(worker_id,name,phone_no,true);

    }
    function pay_to_worker(uint256 society_id,uint256 val,address workerAddress) public
    {
        require(Society[society_id][msg.sender].active == true,"Not a valid resident");
        require(worker[workerAddress].active==true,"Not a valid worker");

    }
}