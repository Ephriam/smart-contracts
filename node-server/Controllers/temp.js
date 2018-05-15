global.Web3 = require('web3');
global.lEndpoint, global.tEndpoint, global.rEndpoint;
global.lEndpoint = 'http://127.0.0.1:8545';
global.web3 = new Web3(new Web3.providers.HttpProvider(lEndpoint));
global.accounts = web3.eth.accounts;
global.base = '../../contract/build/contracts/';
global.c = require('../../contract/build/contracts/Coin.json');
global.addressInfo = (address) => {return web3.fromWei(
    web3.eth.getBalance(address), 'ether').toNumber()}

global.deployer = function(path){
    contract = require(base + path);
    let Contract = web3.eth.contract(contract.abi);
    var deployed = Contract.new(accounts[1], 10, 100, {
        from: web3.eth.accounts[0],
        data: contract.bytecode,
        gas:4700000,
        //value: web3.toWei(15, 'ether'),
        gasPrice: 100        
    },(err, cont) => {if(err){console.log(err)}else{console.log(cont)}});
    
}  

global.vth = function(num){
    return web3.toWei(num, 'ether');
}

require('repl').start({});