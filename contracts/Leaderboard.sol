// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract Leaderboard {
struct Entry { address player; uint256 score; }
Entry[] public entries;


mapping(address => uint256) public playerIndex; // 1-based index, 0 = not present


event ScoreUpdated(address indexed player, uint256 newScore);


function submitScore(address player, uint256 score) external {
uint256 idx = playerIndex[player];
if (idx == 0) {
entries.push(Entry(player, score));
playerIndex[player] = entries.length; // store 1-based
} else {
uint256 realIdx = idx - 1;
if (score > entries[realIdx].score) {
entries[realIdx].score = score;
}
}
emit ScoreUpdated(player, score);
}


// Returns top N (simple linear scan — OK for small arrays)
function topN(uint256 n) external view returns (Entry[] memory) {
uint256 len = entries.length;
if (n > len) n = len;
Entry[] memory out = new Entry[](n);
// naive selection sort style — gas costly when large; for onchain use consider offchain ranking
Entry[] memory copy = entries;
for (uint256 i = 0; i < n; i++) {
uint256 maxIdx = i;
for (uint256 j = i+1; j < len; j++) {
if (copy[j].score > copy[maxIdx].score) {
maxIdx = j;
}
}
out[i] = copy[maxIdx];
// swap
Entry memory tmp = copy[i];
copy[i] = copy[maxIdx];
copy[maxIdx] = tmp;
}
return out;
}
}
