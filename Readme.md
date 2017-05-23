# Akashanet

An Internet system implemented on Ethereum.

## Run Proxy
1. ```npm install -g truffle```
2. ```npm install```
3. run some Ethereum client (e.g. geth)
4. ```truffle migrate```
5. ```node proxy/proxy_server.js [path to the client's ipc socket]```

localhost:8080 is the proxy server that connects to Akashanet.

When you access example.com via localhost:8080, the proxy server gets contents that are uploaded to the Ethereum network. 

## Create site
To upload contents to The Ethereum Network, you have to create a site first.

```javascript
// Let akash be a deployed Akashanet contract object.
akash.createSite("[site domain name]", "[site metadata]")
```
Site metadata helps the proxy to know how to render contents.

## Create contents
Then, upload contents.

```javascript
akash.createContent("[site domain name]", "[path to content]", "[file metadata]", "[file data]")
```

If you execute following script and access to "http://example.com/test.txt", your browser will display "test".

```javascript
akash.createSite("example.com", "")
akash.createContent("example.com", "test.txt", "", "test")
```