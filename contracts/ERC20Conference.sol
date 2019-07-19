pragma solidity ^0.5.4;

import './AbstractConference.sol';
import 'openzeppelin-solidity/contracts/token/ERC20/ERC20.sol';

contract ERC20Conference is AbstractConference {

    ERC20 public token; // @todo use a safe transfer proxy

    constructor(
        string memory _name,
        uint256 _deposit,
        uint256 _limitOfParticipants,
        uint256 _coolingPeriod,
        address payable _owner,
        ERC20 _token
    )
        AbstractConference(_name, _deposit, _limitOfParticipants, _coolingPeriod, _owner)
        public
    {
        token = _token;
    }

    /**
     * @dev Returns total balance of the contract. This function can be deprecated when refactroing front end code.
     * @return The total balance of the contract.
     */
    function totalBalance() view public returns (uint256){
        return token.balanceOf(address(this));
    }

    function doWithdraw(address payable participant, uint256 amount) internal {
        token.transfer(participant, amount);
    }

    function doDeposit(address participant, uint256 amount) internal {
        token.transferFrom(participant, address(this), amount);
    }

}