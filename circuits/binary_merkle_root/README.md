# Binary Merkle Root

This project contains the Binary Merkle Root Noir circuit. It's used to calculate the Merkle root of a binary tree (including the LeanIMT).

## Import the library

To import the library, add the lib to the `Nargo.toml` file. For example:

```toml
[dependencies]
binary_merkle_root = { git = "https://github.com/vplasencia/noir-circuits", tag = "main", directory = "circuits/binary_merkle_root" }
```

## Usage

```rs
use std::hash::poseidon::bn254::hash_2 as poseidon2;
use binary_merkle_root;

fn main(
    identity_commitment: Field,
    merkle_proof_length: u32, 
    merkle_proof_indices: [u1; MAX_DEPTH], 
    merkle_proof_siblings: [Field; MAX_DEPTH], 
) -> pub (Field, Field) {

    // Calculate Merkle root.
    let merkle_root = binary_merkle_root::binary_merkle_root(poseidon2, identity_commitment, merkle_proof_length, merkle_proof_indices, merkle_proof_siblings);
}
```

## References

- [Noir docs](https://noir-lang.org/)
- [zk-kit.circom: binary-merkle-root.circom](https://github.com/privacy-scaling-explorations/zk-kit.circom/blob/main/packages/binary-merkle-root/src/binary-merkle-root.circom)
- [zk-kit.noir: merkle.nr calculate root function](https://github.com/privacy-scaling-explorations/zk-kit.noir/blob/main/packages/merkle-trees/src/merkle.nr#L76)
- [Semaphore Noir implementation by HashCloak](https://github.com/hashcloak/semaphore-noir)
