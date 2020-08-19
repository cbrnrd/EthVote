pragma solidity ^0.6.4;

contract Voting {

  // A mapping that associates a candidate name with a number of votes received.
  mapping (bytes32 => uint256) public votesReceived;
  bytes32[] private alreadyVotedUids;
  bytes32[] private registeredUids;

  // The list of candidates to be passed into the constructor.
  bytes32[] public candidateList;
  
  // Start out with an initial list of candidates and registered UIDs.
  constructor(bytes32[] memory candidateNames, bytes32[] memory registeredUidList) public {
    candidateList = candidateNames;
    registeredUids = registeredUidList;
  }

  // Returns the total number of votes for some candidate.
  function totalVotes(bytes32 candidate) view public returns (uint256) {
    require(validCandidate(candidate));
    return votesReceived[candidate];
  }

  // Submits a single vote for a candidate. As of now there is no verification to make sure someone votes more than once.
  function voteForCandidate(bytes32 candidate, bytes32 uid) public {
    require(validCandidate(candidate));
    require(!hasAlreadyVoted(uid));

    // This uid hasn't voted yet, so cast a vote then push uid into alreadyVotedUids.
    votesReceived[candidate] += 1;
    alreadyVotedUids.push(uid);
  }

  // Check if `candidate` is a valid candidate.
  function validCandidate(bytes32 candidate) view public returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (candidateList[i] == candidate) {
        return true;
      }
    }
    return false;
  }

  // Check if the passed uid has voted already.
  function hasAlreadyVoted(bytes32 uid) view public returns (bool) {
    require(validUid(uid));
    for(uint i = 0; i < alreadyVotedUids.length; i++) {
      if (alreadyVotedUids[i] == uid)
        return true;
    }
    return false;
  }

  // Checks if the given uid has been registered
  function validUid(bytes32 uid) view public returns (bool) {
    for(uint i = 0; i < registeredUids.length; i++) {
      if (registeredUids[i] == uid)
        return true;
    }
    return false;
  }

}