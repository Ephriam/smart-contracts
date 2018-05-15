var EthUtil = require('ethereumjs-util');
var Web3 = require('web3');
var EthTx = require('ethereumjs-tx');


var password = 'AlwaysBCoding!BitcoinScreencast1'.repeat(1161);
var pKey = EthUtil.sha3(password);
//var pkey = EthUtil.bufferToHex(pKeyBuffer);
var address = EthUtil.bufferToHex(EthUtil.privateToAddress(pKey));

var lEndpoint, tEndpoint, rEndpoint;
lEndpoint = 'http://127.0.0.1:8545';
var web3 = new Web3(new Web3.providers.HttpProvider(lEndpoint));

var addressInfo = (address) => {return web3.fromWei(
    web3.eth.getBalance(address), 'ether').toNumber()}
  

var genTransaction = function(from, to, pKey, mf, amount){ 
    let rawTx = {
        nounce: web3.toHex(web3.eth.getTransactionCount(from)),
        to: to,
        gasPrice: web3.toHex(mf),
        gasLimit: web3.toHex(21000),
        value: web3.toHex(web3.toWei(amount, 'ether')),
        data:""
    }
    rawTx = new EthTx(rawTx);
    rawTx.sign(pKey);
    rawTx = `0x${rawTx.serialize().toString('hex')}`;
    web3.eth.sendRawTransaction(rawTx, (err, data) => {
        if(!err) {console.log(data);}else{console.log(err);}
    });
}

var transactionInfo = function(tx){
    return web3.eth.getTransaction(tx);
}


genTransaction(address, '0xedd9f524aaf8c97738730eba93c80e7922960c0b', pKey, 20000000000, 22);




/*var hexToBytes = function(hex){
    for(var bytes = [], c = 0; c <hex.length; c+=2)
    bytes.push(parseInt(hex.substr(c, 2), 16));
    return bytes;
}

var privateKeyToAddress = function(privateKey) {
    return `0x${EthUtil.privateToAddress(hexToBytes(privateKey)).toString('hex')}`;
}
*/
//console.log(privateKeyToAddress(process.argv[2]));