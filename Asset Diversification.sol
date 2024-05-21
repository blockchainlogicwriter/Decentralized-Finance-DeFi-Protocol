// Define supported assets
enum AssetType {ETH, ERC20}

// Define asset struct
struct Asset {
    AssetType assetType;
    address tokenAddress;
}

// Function to add supported assets
function addAsset(AssetType assetType, address tokenAddress) external onlyOwner {
    // Implement asset addition logic here
}
