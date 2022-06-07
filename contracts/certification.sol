//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract certificate{

    struct cert_details{
        string username;
        string title; // course title
        uint256 date;
    }
    
    mapping(bytes32=>cert_details) certificates;
    
    address owner;

    constructor() public {
        owner=msg.sender;
        console.log("Deploying the Certificate by owner:", owner);
    }
    
    modifier ownerOnly{
        require(owner==msg.sender);
        _;
    }
    
    event certadded(bytes32 byte_id);// event fired when a new certificate is added
    
    function viewcert(string memory _id) public view returns(string memory, string memory, uint256) {
        bytes32 byte_id = stringToBytes32(_id);
        cert_details memory temp = certificates[byte_id];
        require(temp.date != 0, "No data exists");
        return (temp.username, temp.title, temp.date);
    }
    
    function stringToBytes32(string memory source) private pure returns (bytes32 result) {
        // takes a string an convert it to a bytes32 code

        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
        assembly {
                result := mload(add(source, 32))
        }
    }

    function generateCertificate(string memory _id,string memory username,string memory title,uint256 date) public {
        //params: _id, username, title, date
        //emit: byte_id of the certificate of that user

        bytes32 byte_id = stringToBytes32(_id);

        require(certificates[byte_id].date == 0, "Certificate with given id already exists");
        certificates[byte_id] = cert_details(username,title,date);
        emit certadded(byte_id);
    }
}
