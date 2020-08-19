const Voting = artifacts.require("Voting");
module.exports = function(deployer) {
  //              Contract  Candidates                                                    registeredUids
  deployer.deploy(Voting, ['Biden', 'Trump'].map(name => web3.utils.asciiToHex(name)), ['uid1', 'uid2', 'uid3'].map(uid => web3.utils.asciiToHex(uid)));
};

// These ideally should be read from a file instead of hardcoded, especially registeredUids