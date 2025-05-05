// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QuizResults {
    // Structure to store user quiz results
    struct UserQuizResult {
        address userAddress;
        uint score;
    }

    // Mapping to store quiz results by user address
    mapping(address => UserQuizResult) public userResults;

    // Event to log the result submission
    event QuizResultSubmitted(address indexed userAddress, uint score);

    // Function to submit quiz results
    function submitQuizResults(address _userAddress, uint _score) external {
        // Ensure the user address is not the zero address
        require(_userAddress != address(0), "Invalid address");

        // Store the user's result
        userResults[_userAddress] = UserQuizResult({
            userAddress: _userAddress,
            score: _score
        });

        // Emit event
        emit QuizResultSubmitted(_userAddress, _score);
    }

    // Function to get a user's quiz result by their address
    function getQuizResult(address _userAddress) external view returns (uint score) {
        return userResults[_userAddress].score;
    }
}
