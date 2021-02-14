// SPDX-License-Identifier: CC-BY-4.0
pragma solidity ^0.6.4;

import "@openzeppelin/contracts/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20PausableUpgradeable.sol";
import "@openzeppelin/contracts/access/OwnableUpgradeable.sol";

contract LoveToken is  Initializable, ERC20PausableUpgradeable, OwnableUpgradeable {
    // ------------------------------------------------------------------------
    // Gives Owner all tokens
    // ------------------------------------------------------------------------
    function initialize() public virtual initializer {
        __Context_init_unchained();
        __Ownable_init_unchained();
        __ERC20_init_unchained('? Love Token', '? Love');
        __Pausable_init_unchained();
        __ERC20Pausable_init_unchained();

        _mint(_msgSender(), 1 ether); //one ?
        transferOwnership(_msgSender());
    }


    // ------------------------------------------------------------------------
    // Owner can transfer out any accidentally sent ERC20 tokens
    // ------------------------------------------------------------------------
    function transferAnyERC20Token(address tokenAddress, uint amount) public onlyOwner returns (bool) {
        _transfer(tokenAddress, owner(), amount);
        return true;
    }

   
    // ------------------------------------------------------------------------
    // Owner can pause all transfers
    // ------------------------------------------------------------------------
    function pause() public onlyOwner {
        _pause();
    }

    // ------------------------------------------------------------------------
    // Owner can unpause all transfers
    // ------------------------------------------------------------------------
    function unpause() public onlyOwner {
        _unpause();
    }


    // ------------------------------------------------------------------------
    // Claim one and share with others. Love is free!
    // ------------------------------------------------------------------------
    function claim() public {
       _mint(msg.sender, 1 ether);
    }
    
    
    // ------------------------------------------------------------------------
    // Get love tokens by sharing love
    // ------------------------------------------------------------------------
    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal virtual override
    {
        super._beforeTokenTransfer(from, to, amount); // Call parent hook
        if (from!=address(0))
          _mint(from, amount);
    }
}
