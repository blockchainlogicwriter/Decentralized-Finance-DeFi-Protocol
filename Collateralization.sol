// Define collateral ratio variable
uint256 public collateralRatio;

// Function to set collateral ratio
function setCollateralRatio(uint256 _collateralRatio) external onlyOwner {
    collateralRatio = _collateralRatio;
}
