import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


// XP token: transferable but typically used inside game logic. Mintable by owner (game contract)
contract XPPoints is ERC20, Ownable {
constructor() ERC20("XP Points","XP") {}


function mint(address to, uint256 amount) external onlyOwner {
_mint(to, amount);
}


function burn(address from, uint256 amount) external onlyOwner {
_burn(from, amount);
}
}
