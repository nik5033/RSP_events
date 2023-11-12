// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RSP is ERC20 {
    uint256 private _total;
    uint256 private _win_price;
    address private _owner;
    uint256 private _game_cost;
    int8[] private _player_moves;
    address payable[] _players;

    constructor() ERC20("Rock Scissors Paper", "RSP") {        
        _total = 1000*(10**18);
        _win_price = 0;
        _owner = msg.sender;
        _game_cost = 1*(10**18);
        _mint(address(this), _total/100*50);
        _mint(_owner, _total/100*50);
    }

    event EventEndGame(address first_player, address second_player);

    event EventTotalSupply(uint256 totalSupply); 

    function totalSupply_event() external returns(uint256) {
        uint256 total_supply = totalSupply();
        emit EventTotalSupply(total_supply);
        return total_supply;
    }

    //0 - победил p1
    //1 - победил p2
    //-1 - ничья
    function run_game(int8 p1, int8 p2) private pure returns(int8) {
        //1 - ножницы
        //2 - камень
        //3 - бумага
        if (p2 == p1) {
            return -1;
        }
        else if (p2 > p1) {
            if (p2 - p1 > 1) {
                return 1;
            }
            else {
                return 0;
            }
        }
        else {
            if (p1 - p2 > 1) {
                return 0;
            }
            else {
                return 1;
            }
        }
    }

    function transfer_price(int winner_idx) private  {
        if (winner_idx >= 0) {
            _win_price = 2*_game_cost*9/10;
            if (winner_idx == 0) {
                _transfer(address(this),_players[0], _win_price);
            }
            else {
                _transfer(address(this),_players[1], _win_price);
            }     
        }
        else {
            _transfer(address(this),_players[0], _game_cost);
            _transfer(address(this),_players[1], _game_cost);
        }

        emit EventEndGame(_players[0], _players[1]);

        _players = new address payable[](0);
        _player_moves = new int8[](0);

    }

    function transfer_for_game(uint256 amount, int8 action) external {
        require(amount == _game_cost, "Incorrent value");
        require(0 < action && action < 4, "Incorrent move");

        address to = address(this);
        address owner = _msgSender();
        _transfer(owner, to, amount);

        if (_players.length < 2) {  
            _players.push(payable(owner));
            _player_moves.push(action);
        }

        if (_players.length == 2) {
            int8 winner = run_game(_player_moves[0], _player_moves[1]);
            transfer_price(winner);
        }
    }
}
