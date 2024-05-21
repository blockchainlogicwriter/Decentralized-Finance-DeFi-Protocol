// Define interest rate variables
uint256 public variableInterestRate;
uint256 public stableInterestRate;

// Function to set interest rates
function setInterestRates(uint256 _variableInterestRate, uint256 _stableInterestRate) external onlyOwner {
    variableInterestRate = _variableInterestRate;
    stableInterestRate = _stableInterestRate;
}
