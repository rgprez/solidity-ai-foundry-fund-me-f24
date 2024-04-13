-include .env

build:
	 /home/rayprez/.foundry/bin/forge build

test-all:
	 /home/rayprez/.foundry/bin/forge test

deploy-sepolia-base:
	/home/rayprez/.foundry/bin/forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(RPC_URL_SEPOLIA_BASE) --private-key $(PRIVATE_KEY_SOLIDITY_AI) --broadcast --verify --etherscan-api-key $(API_KEY_BASESCAN) -vvvv



