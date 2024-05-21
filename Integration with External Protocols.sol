// Interface for interacting with external protocols
interface ExternalProtocol {
    function swapTokens(uint256 amount) external returns (bool);
}

// Function to interact with external protocol
function swapTokensWithExternalProtocol(uint256 amount, address externalProtocol) external onlyOwner {
    ExternalProtocol protocol = ExternalProtocol(externalProtocol);
    protocol.swapTokens(amount);
}
