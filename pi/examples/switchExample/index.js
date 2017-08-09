import gpio from 'rpi-gpio';
import Web3 from 'web3';

export default (app) => {
  //app state
  app.triggered = false;

  //GPIO SETUP
  const INPUT = 3;
  gpio.setup(INPUT, gpio.DIR_IN, gpio.EDGE_BOTH);

  // ETH CONTRACT SETUP
  const web3 = new Web3(new Web3.providers.HttpProvider("http://192.168.1.113:8545"));

  const coinbase = web3.eth.coinbase;
  const balance = web3.eth.getBalance(coinbase);
  const contractAddress = '0x5dadf5f93ef4dba46e7f26a28f1ad495bc9e2d54';
  const ABI = JSON.parse('[{"constant":true,"inputs":[],"name":"getSwitch","outputs":[{"name":"switchState","type":"bool"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"toggleSwitch","outputs":[],"payable":false,"type":"function"},{"inputs":[],"payable":false,"type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"name":"newState","type":"bool"}],"name":"switchEvent","type":"event"}]')

  const switchContract = web3.eth.contract(ABI).at(contractAddress);

  //console.log(switchContract)
  web3.eth.defaultAccount = web3.eth.accounts[0];

  gpio.on('change', function(channel, value) {
    console.log('Channel ' + channel + ' value is now ' + value);
    if(channel === INPUT && value === false && app.triggered === false) {
      console.log("Triggered!")
      app.triggered = true;
      switchContract.toggleSwitch();
    }

  });

  console.log("Current contract state is : " + switchContract.getSwitch())

  switchContract.switchEvent({}, (error, msg) => {
    if(!error) {
      console.log(msg);
      app.triggered = false;
    } else {
      console.log(err)
    }
  })

  return app;
}
