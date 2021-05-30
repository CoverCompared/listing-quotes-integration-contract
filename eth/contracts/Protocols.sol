// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Protocols {
    constructor() {
        owner = payable(msg.sender);
    }

    address payable owner;

    modifier onlyOwnerCanDoIt {
        require(msg.sender == owner, "You are not the owner!");
        _;
    }
    
    
    
    struct Protocol {
        uint256 id;
        string name;
    }
    
    mapping(uint256 => Protocol) protocols;
    uint256[] public protocolLength;
    
    function addProtocol(
        uint256 _id
        ,string memory _protocolName
    ) public onlyOwnerCanDoIt {
     Protocol storage protocol = protocols[protocolLength.length];
     
     protocol.id = _id;
     protocol.name = _protocolName;
     
     protocolLength.push(protocolLength.length +1);
     
    }


    function getProtocolLength() public view returns (uint256) {
        return protocolLength.length;
    }
    
    function getProtocol(uint256 _id) public view returns (uint256, string memory) {
        
        return (
            protocols[_id].id,
            protocols[_id].name
            );
        
    }
}