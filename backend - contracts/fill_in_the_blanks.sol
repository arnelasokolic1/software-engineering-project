// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Importing the interface of the ERC20 token
interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract QuizScore {

    // Token address 
    address public tokenAddress;

    // Define the ERC-20 token interface
    IERC20 public token;

    // Struct to store user score
    struct UserScore {
        address userAddress;
        uint256 score;
    }

    // Mapping to store scores by user address
    mapping(address => uint256) public scores;
    
    // Array to store all user scores
    UserScore[] public userScores;

    // Event to log the submission of the score and token transfer
    event ScoreSubmitted(address user, uint256 score, uint256 tokensSent);

    // Constructor with token address as parameter
    constructor(address _tokenAddress) {
        require(_tokenAddress != address(0), "Invalid token address");
        tokenAddress = _tokenAddress;
        token = IERC20(_tokenAddress);
    }

    // Function to submit the quiz score and send tokens
    function submitQuizResults(address _user, uint256 _score) public {
        require(_user != address(0), "Invalid address");
        require(_score >= 0, "Score must be a positive number");

        // Save the score for the user
        scores[_user] = _score;
        
        // Push the result to the userScores array
        userScores.push(UserScore(_user, _score));

        // Calculate the number of tokens to send (1 token per score point)
        uint256 tokensToSend = _score; 

        // Transfer the tokens from the contract to the user
        require(token.transfer(_user, tokensToSend), "Token transfer failed");

        // Emit the event when score is submitted and tokens are transferred
        emit ScoreSubmitted(_user, _score, tokensToSend);
    }

    // Function to retrieve a user's score
    function getUserScore(address _user) public view returns (uint256) {
        return scores[_user];
    }

    // Function to retrieve the total number of users who submitted scores
    function getTotalUsers() public view returns (uint256) {
        return userScores.length;
    }

    // Function to get the score of a specific user in the userScores array
    function getUserAtIndex(uint256 index) public view returns (address, uint256) {
        require(index < userScores.length, "Index out of bounds");
        return (userScores[index].userAddress, userScores[index].score);
    }
}


/* ABI

[{
            "inputs": [{
                "internalType": "uint256",
                "name": "seed",
                "type": "uint256"
            }],
            "name": "getRandomFact",
            "outputs": [{
                "internalType": "string",
                "name": "",
                "type": "string"
            }],
            "stateMutability": "view",
            "type": "function"
        }];


*/