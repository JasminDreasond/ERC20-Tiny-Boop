// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.8.0) (token/ERC20/ERC20.sol)

/*

    I'm creating the version BSC made by me too.
    The original version url is here:

    https://bscscan.com/token/0x00343061bdbc79ad64018fb4b3aed2e1701b0e24#code

*/

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "@openzeppelin/contracts/utils/Context.sol";

contract ERC20 is Context, IERC20, IERC20Metadata {
    
    // User Balances
    mapping(address => uint256) private _balances;

    // Boop Pair Balance
    mapping (string => uint256) public _balances_pair;

    // Tiny Data
    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    // Event
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Constructor
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    // Information
    function name() public view virtual override returns (string memory) {
        return _name;
    }


    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    function decimals() public view virtual override returns (uint8) {
        return 1;
    }

    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    // Boop Pair
    function balancePairOf(address sender, address receiver) external view returns (uint256) {

        // Detect Address.
        require(sender != address(0), "Boop Sender address invalid");
        require(receiver != address(0), "Boop Receiver address invalid");

        // Base Values
        string memory _string_sender;
        string memory _string_to;
        string memory _pair_value;

        // Convert to String
        _string_sender = Strings.toHexString(sender);
        _string_to = Strings.toHexString(receiver);

        _pair_value = string(abi.encodePacked(_string_sender,'__'));
        _pair_value = string(abi.encodePacked(_pair_value,_string_to));

        return _balances_pair[_pair_value];
    
    }

    // Token Viewer
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    // Transfer and boop alias
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    function boop(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {

        // Validator
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        // You can only send 3 boops.
        require(to != address(msg.sender), "Hey! You can't try to boop yourself! >:c");
        require(amount >= 1, "Calm your crazy paw! Boop Value must be between 1 to 3");
        require(amount <= 3, "Calm your crazy paw! Boop Value must be between 1 to 3");

        // Execute
        unchecked {
            _balances[to] += amount;
        }

        // Emit
        emit Transfer(from, to, amount);

    }

    // Mint
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply += amount;
        unchecked {
            // Overflow not possible: balance + amount is at most totalSupply + amount, which is checked above.
            _balances[account] += amount;
        }

    }

}

// Create Contract here!
pragma solidity ^0.8.4;
contract TinyBoop is ERC20 {
    constructor() ERC20("Tiny Boop", "Boop") {}
}