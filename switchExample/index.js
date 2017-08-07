import gpio from 'rpi-gpio';
import Web3 from 'web3';

const IO_PIN = 3;

export default (app) => {
  let web3 = new Web3();
  console.log("Hello switchExample!");

   gpio.on('change', function(channel, value) {
       console.log('Channel ' + channel + ' value is now ' + value);
   });
   gpio.setup(IO_PIN, gpio.DIR_IN, gpio.EDGE_BOTH);

  return app;
}
