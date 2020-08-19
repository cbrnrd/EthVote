fs = require('fs');
Web3 = require('web3');
web3 = new Web3("http://localhost:8545");

// print addresses
web3.eth.getAccounts(console.log);

web3.eth.getAccounts().then(accounts => {

    bytecode = fs.readFileSync('Voting_sol_Voting.bin').toString();

    abi = JSON.parse(fs.readFileSync('Voting_sol_Voting.abi').toString());


    // Deploy the contract
    deployedContract = new web3.eth.Contract(abi);

    listOfCandidates = ['Biden', 'Trump'];

    deployedContract.deploy({
        data: bytecode,
        arguments: [listOfCandidates.map(name => web3.utils.asciiToHex(name))]
    }).send({
        from: accounts[0],
        gas: 1500000,
        gasPrice: web3.utils.toWei('0.00003', 'ether')
    }).then((newContractInstance) => {
        deployedContract.options.address = newContractInstance.options.address
        console.log(newContractInstance.options.address)
    });


});
