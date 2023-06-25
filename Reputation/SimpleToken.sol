pragma solidity ^0.8.0;

interface ERC721 /* is ERC165 */ {
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    function balanceOf(address _owner) external view returns (uint256);
    function ownerOf(uint256 _tokenId) external view returns (address);
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) external payable;
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
    function approve(address _approved, uint256 _tokenId) external payable;
    function setApprovalForAll(address _operator, bool _approved) external;
    function getApproved(uint256 _tokenId) external view returns (address);
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}


contract SimpleToken is ERC721 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    string public employee_ID;
    string public company_ID;
    string public requested_company_ID;

    mapping(address => uint256) public balanceOf;

   // event Transfer(address indexed from, address indexed to, uint256 value);

    constructor(
        string memory _employee_ID,
        string memory _company_ID,
        string memory _requested_company_ID
    ) {
        employee_ID = _employee_ID;
        company_ID = _company_ID;
        name = "reviewToken";
        symbol = "request";
        decimals = 1;
        totalSupply = 1;
       
        requested_company_ID = _requested_company_ID;
    }

    //  function balanceOf(address _owner) external view override returns (uint256) {
    //     return balanceOf[_owner];
    // }


    function ownerOf(uint256 _tokenId) external view override returns (address) {
        return address(this);
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) external payable override {
        require(_from != address(0), "Invalid sender address");
        require(_to != address(0), "Invalid recipient address");
        require(balanceOf[_from] > 0, "Sender does not own any tokens");

        balanceOf[_from] -= 1;
        balanceOf[_to] += 1;

        emit Transfer(_from, _to, _tokenId);
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable override {
      
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable override {
        require(msg.sender == _from , "Caller is not owner nor approved");
        require(_from != address(0), "Invalid sender address");
        require(_to != address(0), "Invalid recipient address");
        require(balanceOf[_from] > 0, "Sender does not own any tokens");

        balanceOf[_from] -= 1;
        balanceOf[_to] += 1;

        emit Transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint256 _tokenId) external payable override {
        

        // Approve the address
        // (This implementation does not support multiple approvals)
    }

    function setApprovalForAll(address _operator, bool _approved) external override {
        // Set operator approval for all tokens owned by the caller
    }

    function getApproved(uint256 _tokenId) external view override returns (address) {
        // Get the approved address for the token
    }

    function isApprovedForAll(address _owner, address _operator) external view override returns (bool) {
        // Check if the operator is approved for all tokens owned by the owner
    }
}
