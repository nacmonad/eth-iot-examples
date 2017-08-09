import express from 'express';
<<<<<<< HEAD
//import example from './examples/blinkExample';
import example from './examples/switchExample';
//import example from './examples/erc20Example';
=======
import switchExample from './examples/blinkExample';
>>>>>>> f5e8576853de85c6d01c61bd19785268ce36de4f

const PORT = 3030;

let app = new express();
app.set('port', PORT)

<<<<<<< HEAD
app = example(app);
=======
app = blinkExample(app);
>>>>>>> f5e8576853de85c6d01c61bd19785268ce36de4f

app.listen(app.get('port'), ()=>{
  console.log(`PI-Node on port ${app.get('port')}`);
})
