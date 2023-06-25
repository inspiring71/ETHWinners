// SPDX-License-Identifier: MIT
 // Developed by ETH Winners 2023
pragma solidity >=0.7.0 <0.9.0;
import "./Company.sol";
import "./Reputation.sol";
import "./TokenBound.sol";
contract Employee{
    Attributes[] my_rankings;
    TokenBoundAccount[] st; 
    event NewCompany(Company indexed old_company, Company indexed new_comapny);
    event ReviewRequest(TokenBoundAccount token);
    address public main_contract;
    // modifier to check if caller is owner
    modifier isOwner() {
        require(msg.sender == main_contract, "Caller is not owner");
        _;
    }

     modifier isEmployee() {
        require(msg.sender == employee_address);
        _;
    }

    string public ID;
    Company[] my_company;
    address public employee_address;

    constructor(string memory id, Company current_company) {
        ID = id;
        my_company.push(current_company);
        main_contract = msg.sender;
    }

     function changeCompany(Company new_company) public isOwner {
        // add some checks
        emit NewCompany(my_company[my_company.length -1], new_company);
        my_company.push(new_company);
    }
    
    function addReviewToken(TokenBoundAccount token) public{
        st.push(token);
        emit ReviewRequest(token);
    }
    function add_review(TokenBoundAccount token, Attributes memory a) public {
        SimpleToken st2 = token.realTolken();
        require(keccak256(bytes(st2.employee_ID())) == keccak256(bytes(ID)));
        
    }


}