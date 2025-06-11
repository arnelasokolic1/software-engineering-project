//CONTRACT ADDRESS : 0x6Bc3ce3D718808Dffa6C3A9dFC17d4f090A1a399





// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QuizContract {

    struct Question {
        string questionText;
        string[] options;
        uint256 correctAnswer;
    }

    struct ContactMessage {
        string name;
        string email;
        string message;
    }

    address public admin;
    Question[] public questions;
    ContactMessage[] public contactMessages;

    // Mappings to store user scores and whether they attempted the quiz
    mapping(address => uint256) public userScores;
    mapping(address => bool) public hasAttemptedQuiz;

    // Events
    event QuestionAdded(uint256 id, string questionText, string[] options);
    event QuestionRemoved(uint256 id);
    
    event ContactMessageReceived(uint256 id, string name, string email, string message);
    event ContactMessageRemoved(uint256 id);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender; // Set the contract creator as the admin
    }

    // Function to add a question
    function addQuestion(
        string memory _questionText,
        string[] memory _options,
        uint256 _correctAnswer
    ) public onlyAdmin {
        require(
            _correctAnswer >= 1 && _correctAnswer <= 4,
            "Correct answer must be between 1 and 4"
        );
        questions.push(Question(_questionText, _options, _correctAnswer));
        emit QuestionAdded(questions.length - 1, _questionText, _options);
    }

    // Function to remove a question
    function removeQuestion(uint256 _id) public onlyAdmin {
        require(_id < questions.length, "Invalid question ID");
        for (uint256 i = _id; i < questions.length - 1; i++) {
            questions[i] = questions[i + 1];
        }
        questions.pop();
        emit QuestionRemoved(_id);
    }

    // Function to get question count
    function getQuestionCount() public view returns (uint256) {
        return questions.length;
    }

    // Function to get question by ID
    function getQuestion(uint256 _id)
        public
        view
        returns (
            string memory,
            string[] memory,
            uint256
        )
    {
        require(_id < questions.length, "Invalid question ID");
        Question memory q = questions[_id];
        return (q.questionText, q.options, q.correctAnswer);
    }

    // Function for users to submit contact messages
    function submitContactMessage(string memory _name, string memory _email, string memory _message) public {
        contactMessages.push(ContactMessage(_name, _email, _message));
        emit ContactMessageReceived(contactMessages.length - 1, _name, _email, _message);
    }

    // Function to remove a contact message (only accessible by admin)
    function removeContactMessage(uint256 _id) public onlyAdmin {
        require(_id < contactMessages.length, "Invalid contact message ID");
        for (uint256 i = _id; i < contactMessages.length - 1; i++) {
            contactMessages[i] = contactMessages[i + 1];
        }
        contactMessages.pop();
        emit ContactMessageRemoved(_id);
    }

    // Function to get contact message by ID
    function getContactMessage(uint256 _id)
        public
        view
        returns (
            string memory name,
            string memory email,
            string memory message
        )
    {
        require(_id < contactMessages.length, "Invalid contact message ID");
        ContactMessage memory cm = contactMessages[_id];
        return (cm.name, cm.email, cm.message);
    }

    // Function to get the contact message count
    function getContactMessageCount() public view returns (uint256) {
        return contactMessages.length;
    }
}



/*ABI 

[
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_questionText",
				"type": "string"
			},
			{
				"internalType": "string[]",
				"name": "_options",
				"type": "string[]"
			},
			{
				"internalType": "uint256",
				"name": "_correctAnswer",
				"type": "uint256"
			}
		],
		"name": "addQuestion",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "name",
				"type": "string"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "email",
				"type": "string"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "message",
				"type": "string"
			}
		],
		"name": "ContactMessageReceived",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			}
		],
		"name": "ContactMessageRemoved",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "questionText",
				"type": "string"
			},
			{
				"indexed": false,
				"internalType": "string[]",
				"name": "options",
				"type": "string[]"
			}
		],
		"name": "QuestionAdded",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			}
		],
		"name": "QuestionRemoved",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_id",
				"type": "uint256"
			}
		],
		"name": "removeContactMessage",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_id",
				"type": "uint256"
			}
		],
		"name": "removeQuestion",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_name",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_email",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_message",
				"type": "string"
			}
		],
		"name": "submitContactMessage",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "admin",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "contactMessages",
		"outputs": [
			{
				"internalType": "string",
				"name": "name",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "email",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "message",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_id",
				"type": "uint256"
			}
		],
		"name": "getContactMessage",
		"outputs": [
			{
				"internalType": "string",
				"name": "name",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "email",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "message",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getContactMessageCount",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_id",
				"type": "uint256"
			}
		],
		"name": "getQuestion",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			},
			{
				"internalType": "string[]",
				"name": "",
				"type": "string[]"
			},
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getQuestionCount",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "hasAttemptedQuiz",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "questions",
		"outputs": [
			{
				"internalType": "string",
				"name": "questionText",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "correctAnswer",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "userScores",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]
*/