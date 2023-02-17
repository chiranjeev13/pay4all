// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract dClap {
    address immutable tokenAddress = 0x0000000000000000000000000000000000001010;

    struct Society_members {
        uint256 member_id;
        uint256 society_id;
        string name;
        uint256 phone_no;
        bool active;
        string role; // resident, coordinators, workers
    }

    struct Society {
        address society_deployer;
        uint256 society_id;
        string society_name;
        string employer_name;
        string purpose;
        uint256 period_of_operation;
        bool active; // to check whether the society is under operation or has discontinued in between.
    }

    struct Workers {
        uint256 worker_id;
        address worker_address;
        string name;
        uint256 phone_no;
        uint256 balance;
        bool active;
        bool inService;
    }

    struct Residents {
        uint256 resident_id;
        address resident_address;
        string name;
        uint256 phone_no;
        uint256 balance;
        bool active;
        bool inService;
    }

    mapping(uint256 => mapping(address => Society_members)) SocietyMapper;
    mapping(address => Workers) worker;
    mapping(address => Residents) resident;
    mapping(address => uint256) public workerBalances;

    Workers[] public workersArray;
    Residents[] public residentsArray;

    mapping(address => Society) public societyLogs;
    Society[] public societies;

    uint256 public workerCount;
    uint256 public residentCount;
    uint256 public societyCount;

    function registerForSociety(
        string memory society_name,
        string memory employer_name,
        string memory purpose,
        uint256 period_of_operation
    ) public {
        societies.push(
            Society(
                msg.sender,
                societyCount,
                society_name,
                employer_name,
                purpose,
                period_of_operation,
                true
            )
        );
        societyLogs[msg.sender] = societies[societyCount];
        societyCount++;
    }

    // function addSociety(
    //     uint256 resident_id,
    //     string memory name,
    //     uint256 phone_no
    // ) public {
    //     Society[society_id][msg.sender] = Society_members(
    //         resident_id,
    //         name,
    //         phone_no,
    //         true
    //     ); //atleast one resident is reqd to register
    //     society_id++;
    // }

    function addMembersToSociety(
        uint256 society_id,
        address member_address,
        uint256 member_id,
        uint256 phone_no,
        string memory name,
        string memory role
    ) public {
        require(
            SocietyMapper[society_id][member_address].active == false,
            "Already in society"
        );
        SocietyMapper[society_id][member_address] = Society_members(
            member_id,
            society_id,
            name,
            phone_no,
            true,
            role
        );
    }

    function deleteMembers_from_society(uint256 society_id) public {
        require(
            SocietyMapper[society_id][msg.sender].active == true,
            "not from this society"
        );
        SocietyMapper[society_id][msg.sender].active = false;
    }

    function registerWorkers(
        uint256 worker_id,
        string memory name,
        uint256 phone_no
    ) public {
        require(worker[msg.sender].active == false, "Already registered");
        worker[msg.sender] = Workers(
            worker_id,
            msg.sender,
            name,
            phone_no,
            0,
            true,
            false
        );
        workersArray.push(
            Workers(worker_id, msg.sender, name, phone_no, 0, true, false)
        );
        workerCount++;
    }

    function registerResidents(
        uint256 resident_id,
        string memory name,
        uint256 phone_no
    ) public {
        require(resident[msg.sender].active == false, "Already registered");
        resident[msg.sender] = Residents(
            resident_id,
            msg.sender,
            name,
            phone_no,
            0,
            true,
            false
        );
        residentsArray.push(
            Residents(resident_id, msg.sender, name, phone_no, 0, true, false)
        );
        residentCount++;
    }

    function pay_to_worker(
        uint256 society_id,
        uint256 val,
        address workerAddress
    ) public payable {
        require(
            SocietyMapper[society_id][msg.sender].active == true,
            "Not a valid resident"
        );
        require(worker[workerAddress].active == true, "Not a valid worker");
        require(
            IERC20(tokenAddress).balanceOf(msg.sender) > msg.value,
            "Not enough to balance to make this transaction"
        );
        IERC20(tokenAddress).transferFrom(msg.sender, address(this), val);
        workerBalances[workerAddress] += val;

        // IERC20(0x0000000000000000000000000000000000001010)
    }
}
