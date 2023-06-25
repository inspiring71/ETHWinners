// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "./SimpleToken.sol";
import "@thirdweb-dev/contracts/smart-wallet/non-upgradeable/Account.sol";
import "@thirdweb-dev/contracts/eip/interface/IERC721.sol";
import "https://github.com/erc6551/reference/blob/main/src/lib/ERC6551AccountLib.sol";
import "https://github.com/erc6551/reference/blob/main/src/interfaces/IERC6551Account.sol";

contract TokenBoundAccount is  IERC6551Account {
    /*///////////////////////////////////////////////////////////////
                            Events
    //////////////////////////////////////////////////////////////*/
 
    event TokenBoundAccountCreated(address indexed account, bytes indexed data);
 SimpleToken  public stoken;
    /*///////////////////////////////////////////////////////////////
                            Constructor
    //////////////////////////////////////////////////////////////*/

    // /**
    //  * @notice Executes once when a contract is created to initialize state variables
    //  *
    //  * @param _entrypoint - 0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789
    //  * @param _factory - The factory contract address to issue token Bound accounts
    //  *
    //  */
    // constructor(
    //     IEntryPoint _entrypoint,
    //     address _factory
    // ) {}
  
    receive() external payable  {}

    /// @notice Returns whether a signer is authorized to perform transactions using the wallet.
    function isValidSigner(
        address _signer
    ) public view returns (bool) {
        return (owner() == _signer);
    }

    function owner() public view returns (address) {
        (
            uint256 chainId,
            address tokenContract,
            uint256 tokenId
        ) = ERC6551AccountLib.token();

        if (chainId != block.chainid) return address(0);

        return IERC721(tokenContract).ownerOf(tokenId);
    }

    function executeCall(
        address to,
        uint256 value,
        bytes calldata data
    ) external payable  returns (bytes memory result) {
        return _call(to, value, data);
    }

    /// @notice Withdraw funds for this account from Entrypoint.
    function withdrawDepositTo(
        address payable withdrawAddress,
        uint256 amount
    ) public virtual  {
        require(owner() == msg.sender, "Account: not NFT owner");
       
    }

    function token()
        external
        view
        returns (uint256 chainId, address tokenContract, uint256 tokenId)
    {
        return ERC6551AccountLib.token();
    }

    function realTolken() external returns (SimpleToken){
        return stoken;
    }
    function addToken(string memory requested_company_ID ,string memory user_ID, string memory current_company_ID  ) external {
       stoken = new SimpleToken(user_ID,current_company_ID,requested_company_ID );
    }
    function nonce() external view returns (uint256) {
        return 0;
    }

    /*///////////////////////////////////////////////////////////////
                            Internal Functions
    //////////////////////////////////////////////////////////////*/

    function _call(
        address _target,
        uint256 value,
        bytes memory _calldata
    ) internal virtual  returns (bytes memory result) {
        bool success;
        (success, result) = _target.call{value: value}(_calldata);
        if (!success) {
            assembly {
                revert(add(result, 32), mload(result))
            }
        }
    }

    /*///////////////////////////////////////////////////////////////
                            Modifiers
    //////////////////////////////////////////////////////////////*/


}