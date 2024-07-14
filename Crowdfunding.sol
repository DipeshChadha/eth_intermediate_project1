// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    struct Campaign {
        address payable creator;
        uint goal;
        uint deadline;
        uint pledged;
        bool claimed;
        mapping(address => uint) contributions;
    }
    
    uint public campaignCount;
    mapping(uint => Campaign) public campaigns;

    event CampaignCreated(uint indexed campaignId, address indexed creator, uint goal, uint deadline);
    event Contributed(uint indexed campaignId, address indexed contributor, uint amount);
    event Withdrawn(uint indexed campaignId, address indexed creator, uint amount);
    event Refunded(uint indexed campaignId, address indexed contributor, uint amount);

    function createCampaign(uint _goal, uint _deadline) public {
        require(_goal > 0, "Goal should be greater than zero");
        require(_deadline > block.timestamp, "Deadline should be in the future");

        campaignCount++;
        Campaign storage campaign = campaigns[campaignCount];
        campaign.creator = payable(msg.sender);
        campaign.goal = _goal;
        campaign.deadline = _deadline;
        campaign.pledged = 0;
        campaign.claimed = false;

        emit CampaignCreated(campaignCount, msg.sender, _goal, _deadline);
    }

    function contribute(uint _campaignId) public payable {
        Campaign storage campaign = campaigns[_campaignId];

        require(block.timestamp < campaign.deadline, "Campaign is over");
        require(msg.value > 0, "Contribution should be greater than zero");

        campaign.contributions[msg.sender] += msg.value;
        campaign.pledged += msg.value;

        emit Contributed(_campaignId, msg.sender, msg.value);
    }

    function withdraw(uint _campaignId) public {
        Campaign storage campaign = campaigns[_campaignId];

        require(msg.sender == campaign.creator, "Only the campaign creator can withdraw");
        require(block.timestamp >= campaign.deadline, "Campaign is not over yet");
        require(campaign.pledged >= campaign.goal, "Campaign did not reach the goal");
        require(!campaign.claimed, "Funds have already been claimed");

        uint amount = campaign.pledged;
        campaign.claimed = true;
        campaign.creator.transfer(amount);

        emit Withdrawn(_campaignId, msg.sender, amount);
    }

    function refund(uint _campaignId) public {
        Campaign storage campaign = campaigns[_campaignId];

        require(block.timestamp >= campaign.deadline, "Campaign is not over yet");
        require(campaign.pledged < campaign.goal, "Campaign reached the goal, no refunds");

        uint contributed = campaign.contributions[msg.sender];
        require(contributed > 0, "No contributions to refund");

        campaign.contributions[msg.sender] = 0;
        campaign.pledged -= contributed;
        payable(msg.sender).transfer(contributed);

        emit Refunded(_campaignId, msg.sender, contributed);
    }

    function getCampaign(uint _campaignId) public view returns (
        address creator,
        uint goal,
        uint deadline,
        uint pledged,
        bool claimed
    ) {
        Campaign storage campaign = campaigns[_campaignId];
        return (
            campaign.creator,
            campaign.goal,
            campaign.deadline,
            campaign.pledged,
            campaign.claimed
        );
    }

    function getContribution(uint _campaignId, address _contributor) public view returns (uint) {
        Campaign storage campaign = campaigns[_campaignId];
        return campaign.contributions[_contributor];
    }
}
