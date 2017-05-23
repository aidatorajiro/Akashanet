pragma solidity ^0.4.11;

contract Akashanet {

	struct content {
		bool exists;
		string metadata;
		string data;
		address owner;
		bool canOwnerWrite;
	}

	struct site {
		bool exists;
		string metadata;
		mapping (string => content) contents;
		address owner;
		bool canOwnerWrite;
	}

	mapping (string => site) sites;

	function Akashanet() {
	}

	function createSite(string site_id, string metadata) returns(bool) {
		var site = sites[site_id];
		if (site.exists) { return false; }
		site.exists   = true;
		site.metadata = metadata;
		site.owner    = msg.sender;
		site.canOwnerWrite = true;
		return true;
	}
	
	function createContent(string site_id, string content_id, string metadata, string data) returns(bool sufficient) {
		var site    = sites[site_id];
		var content = site.contents[content_id];
		if (!site.exists || !site.canOwnerWrite || content.exists) { return false; }
		content.exists   = true;
		content.metadata = metadata;
		content.data     = data;
		content.owner    = msg.sender;
		content.canOwnerWrite = true;
		return true;
	}

	function getContentExists(string site_id, string content_id) returns(bool) {
		return sites[site_id].contents[content_id].exists;
	}

	function getContentMetaData(string site_id, string content_id) returns(string) {
		return sites[site_id].contents[content_id].metadata;
	}

	function getContentData(string site_id, string content_id) returns(string) {
		return sites[site_id].contents[content_id].data;
	}

	function getContentOwner(string site_id, string content_id) returns(address) {
		return sites[site_id].contents[content_id].owner;
	}

	function getContentCanOwnerWrite(string site_id, string content_id) returns(bool) {
		return sites[site_id].contents[content_id].canOwnerWrite;
	}

	function modifyContentMetaData(string site_id, string content_id, string metadata) returns(bool) {
		var site    = sites[site_id];
		var content = site.contents[content_id];
		if (!site.exists || !site.canOwnerWrite || !content.exists || content.owner != msg.sender || !content.canOwnerWrite) { return false; }
		content.metadata = metadata;
		return true;
	}

	function modifyContentData(string site_id, string content_id, string data) returns(bool) {
		var site    = sites[site_id];
		var content = site.contents[content_id];
		if (!site.exists || !site.canOwnerWrite || !content.exists || content.owner != msg.sender || !content.canOwnerWrite) { return false; }
		content.data = data;
		return true;
	}
}
