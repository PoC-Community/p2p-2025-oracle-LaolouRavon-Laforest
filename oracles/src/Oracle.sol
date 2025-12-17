// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Oracle {
    address public owner;
    address[] public nodes;
    mapping(address => bool) public isNode;
    mapping(string => uint256) public currentPrices;

    constructor() {
        owner = msg.sender;
    }

    function getQuorum() public view returns (uint256) {
        uint256 nodeCount = nodes.length;

        if (nodeCount < 3) {
            return 3;
        }

        return (nodeCount * 2 + 2) / 3;
    }

    function addNode() public {
        require(!isNode[msg.sender], "Node already exists");

        isNode[msg.sender] = true;
        nodes.push(msg.sender);
    }

    function removeNode() public {
        require(isNode[msg.sender], "Node does not exist");

        isNode[msg.sender] = false;

        for (uint256 i = 0; i < nodes.length; i++) {
            if (nodes[i] == msg.sender) {
                nodes[i] = nodes[nodes.length - 1];
                nodes.pop();
                break;
            }
        }
    }
}
