# Crowdfunding Smart Contract
## Simple Overview
A decentralized crowdfunding platform that allows users to create campaigns, contribute funds, and withdraw or refund based on the campaign outcome.

## Description
This smart contract enables users to create crowdfunding campaigns with a specific goal and deadline. Contributors can pledge funds to these campaigns. If the campaign reaches its goal by the deadline, the creator can withdraw the funds. If the goal is not met, contributors can get refunds. This ensures transparency and trust in the crowdfunding process.

## Getting Started
### Installing
*Download the Solidity code from Crowdfunding.sol repository.
*Open Remix IDE at remix.ethereum.org.
*Create a new file and paste the Solidity code into the file.

## Executing program
*Compile the Solidity code using the Remix IDE compiler.
*Deploy the contract to the Ethereum network using the Remix IDE deployer.

### Interact with the Contract:
Use the deployed contract instance to create campaigns, contribute, withdraw, and refund using the provided functions.

1. Create a Campaign:
*Call createCampaign with _goal and _deadline parameters.
``
createCampaign(1000000000000000000, 1735689600); // 1 ETH goal, future deadline
``

2. Contribute to a Campaign:
*Call contribute with _campaignId parameter and send Ether.
``
contribute(1); // Send Ether in the value field
``

3. Withdraw Funds:
*Call withdraw with _campaignId parameter.
``
withdraw(1);
``
4. Refund Contribution:
*Call refund with _campaignId parameter.
``
refund(1);
``

## Help
### Common Issues
*Make sure the _deadline is a future timestamp.
*Only the campaign creator can withdraw funds.

## Authors
Dipesh Chadha
* GitHub: @DipeshChadha
* Email: chadhadipesh@gmail.com
