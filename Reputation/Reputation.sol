// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;
import "./Company.sol";
import "./Employee.sol";
import "./TokenBound.sol";
import "./SimpleToken.sol";
struct Attributes {
    uint256 punctuality;
    uint256 hard_working;
    uint256 skill;
    uint256 fast_learner;
}

contract Reputation {
    mapping(string => Company) public verified_companies;
    mapping(string => Company) public old_comapnies;
    address private owner;

    modifier isOwner() {
        // If the first argument of 'require' evaluates to 'false', execution terminates and all
        // changes to the state and to Ether balances are reverted.
        // This used to consume all gas in old EVM versions, but not anymore.
        // It is often a good idea to use 'require' to check if functions are called correctly.
        // As a second argument, you can also provide an explanation about what went wrong.
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    constructor() {
        //console.log("Owner contract deployed by:", msg.sender);
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        // verified_companies =[]
    }

    function add_Company( bytes memory url) public pure returns ( bytes32 )  {
        //TODO: verify vcdzZAGG 
        bytes32 hash = keccak256((url));

        return hash;

        
    }

    function remove_Company(string memory ID) public {
        delete verified_companies[ID];
    }
    function review_Request(string memory requested_company_ID ,string memory user_ID, string memory current_company_ID   ) public isOwner{
      verified_companies[current_company_ID].review_Request(requested_company_ID, user_ID, current_company_ID);

    }
    function calculateURLHash(string memory url) public pure returns (bytes32) {
        bytes32 hash = keccak256(bytes(url));
        return hash;
    }
    function verify_Company(string memory url)public returns (bool) {

        // bytes32  hash = keccak256(bytes(url));
        // // string memory txtRecord =get_Txt(url); 
        // if( hash == hash){
        //     string memory string_hash = bytes32ToString(hash);
        //     Company company = new Company(string_hash);
        //     verified_companies[string_hash] = company;
            return true;
        // }
        // else {
        //     return false;
        // }
    }
    function bytes32ToString(bytes32 _bytes32) private pure returns (string memory) {
        bytes memory bytesArray = new bytes(64);
        for (uint256 i = 0; i < 32; i++) {
            bytes1 char = bytes1(bytes32(uint256(_bytes32) * 2 ** (8 * i)));
            bytesArray[i * 2] = char;
            bytesArray[i * 2 + 1] = bytes1(0);
        }
        return string(bytesArray);
    }

//   function review_Request(string memory requested_company_ID ,string memory user_ID, string memory current_company_ID   ) public isOwner{
//       verified_companies[current_company_ID].review_Request(requested_company_ID, user_ID, current_company_ID);

//     }
    function add_Employee(string memory employee_ID, string memory url) public {
            bytes32 hash = keccak256(bytes(url));
            string memory string_hash = bytes32ToString(hash);
            verified_companies[string_hash].add_employee(employee_ID);
    }

    function add_review(
        uint256 punctuality,
        uint256 hard_working,
        uint256 skill,
        uint256 fast_learner
    ) public pure {
        require(punctuality < 11);
        require(hard_working < 11);
        require(skill < 11);
        require(fast_learner < 11);
        require(punctuality >0);
        require(hard_working >0);
        require(skill >0);
        require(fast_learner >0);
        
      //SimpleToken st = token.realTolken();
     // Employee a = verified_companies[st.requested_company_ID].old_employees[st.employee_ID];
    }
// }
}