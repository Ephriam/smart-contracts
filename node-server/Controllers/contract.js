var Web3 = require('web3');
var lEndpoint, tEndpoint, rEndpoint;
lEndpoint = 'http://127.0.0.1:8545';
var web3 = new Web3(new Web3.providers.HttpProvider(lEndpoint));


var x = '../../contract/build/contracts/Coin.json';
//console.log(x);
var coursetro = '../../contract/build/contracts/Coursetro.json';

var accounts = web3.eth.accounts;

var deployer = function(path){
    contract = require(path);
    let Contract = web3.eth.contract(contract.abi);
    var deployed = Contract.new(accounts[1], accounts[2], {
        from: web3.eth.accounts[0],
        data: contract.bytecode,
        gas:4700000,
        //value: web3.toWei(15, 'ether'),
        gasPrice: 100        
    },(err, cont) => {if(err){console.log(err)}else{console.log(cont)}});
    
}  



deployer(x);