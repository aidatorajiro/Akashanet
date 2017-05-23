let web3_extended = require('web3_ipc');
let contract = require("truffle-contract");
let options = {
  host: argv[2],
  ipc: true
};
var web3 = web3_extended.create(options);

let akashanet_artifacts = require('../build/contracts/Akashanet.json');
let Akashanet = contract(akashanet_artifacts);
Akashanet.setProvider(web3.currentProvider);

const mime = require('mime-types')
const http = require('http');
const url = require('url');
const path = require('path');

(async () => {
  let akash = await Akashanet.deployed();
  
  http.createServer(async (cliReq, cliRes) => {
    const x = url.parse(cliReq.url);
    const c = mime.contentType(path.extname(cliReq.url));
    if (await akash.getContentExists.call(x.hostname, x.path.substr(1))) {
      cliRes.writeHead(200, {"Content-Type": c || "text/html; charset=utf-8"});
      cliRes.end(await akash.getContentData.call(x.hostname, x.path.substr(1)));
    } else {
      cliRes.writeHead(404, {"Content-Type": "text/plain"});
      cliRes.end("Not found.");
    }
  }).listen(8080);
})();