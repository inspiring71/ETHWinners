// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
import "./Employee.sol";
import "./TokenBound.sol";
contract Company {
    address NFT = 0x47CaB25128b348D01c7eF7bEdacDBAd0c76C3116;
    mapping(string => Employee) public employees;
    mapping(string => Employee) public old_employees;
    string[] current_IDs;
    string company_ID;
    event NewEmployee(string indexed new_employee);
    event RemovedEmployee(string indexed employee, string[] employees, Company company);
    address public main_contract;
    // modifier to check if caller is owner
    modifier isOwner() {
        require(msg.sender == main_contract, "Caller is not owner");
        _;
    }

    constructor(string memory ID) {
        main_contract = msg.sender;
        company_ID = ID ; 
    }

    function add_employee( string memory ID)
        public
        isOwner
    {
        Employee new_employee = new Employee(ID, this);
        employees[ID] = new_employee;
        current_IDs.push(ID);
        emit NewEmployee(ID);
    }

    function removeElement(string memory ID) public {
        for (uint256 i = 0; i < current_IDs.length; i++) {
            if (keccak256(bytes(current_IDs[i])) == keccak256(bytes(ID))) {
                // Found the ID at index i, now remove it
                if (i < current_IDs.length - 1) {
                    // Shift the remaining IDs to fill the gap
                    current_IDs[i] = current_IDs[current_IDs.length - 1];
                }
                current_IDs.pop(); // Remove the last ID
                break; // Exit the loop after removing the ID
            }
        }
    }

    function remove_employee(string memory ID) public isOwner {
        old_employees[ID] = employees[ID];
        delete employees[ID];
        removeElement(ID);
        emit RemovedEmployee(ID, current_IDs, this);
    }


    function review_Request(string memory requested_company_ID ,string memory user_ID, string memory current_company_ID   ) public isOwner{
        
        for (uint i =0 ; i< current_IDs.length; i++){
           TokenBoundAccount st = new TokenBoundAccount();
           st.addToken(user_ID,current_company_ID,requested_company_ID ); // string memory _employee_ID,
      
            employees[current_IDs[i]].addReviewToken(st);
            
        }

    }
}
