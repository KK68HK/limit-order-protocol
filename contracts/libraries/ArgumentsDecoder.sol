// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;
pragma abicoder v1;

/// @title Library with gas efficient alternatives to `abi.decode`
library ArgumentsDecoder {
    function decodeUint256Memory(bytes memory data) internal pure returns(uint256 value) {
        /// @solidity memory-safe-assembly
        assembly { // solhint-disable-line no-inline-assembly
            value := mload(add(data, 0x20))
        }
    }

    function decodeUint256(bytes calldata data) internal pure returns(uint256 value) {
        // no memory ops inside so this insertion is automatically memory safe
        assembly { // solhint-disable-line no-inline-assembly
            value := calldataload(data.offset)
        }
    }

    function decodeBoolMemory(bytes memory data) internal pure returns(bool value) {
        /// @solidity memory-safe-assembly
        assembly { // solhint-disable-line no-inline-assembly
            value := eq(mload(add(data, 0x20)), 1)
        }
    }

    function decodeBool(bytes calldata data) internal pure returns(bool value) {
        // no memory ops inside so this insertion is automatically memory safe
        assembly { // solhint-disable-line no-inline-assembly
            value := eq(calldataload(data.offset), 1)
        }
    }

    function decodeTargetAndCalldata(bytes calldata data) internal pure returns(address target, bytes calldata args) {
        // no memory ops inside so this insertion is automatically memory safe
        assembly {  // solhint-disable-line no-inline-assembly
            target := shr(96, calldataload(data.offset))
        }
        args = data[20:];
    }
}
