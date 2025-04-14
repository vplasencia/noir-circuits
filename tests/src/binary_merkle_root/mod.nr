use binary_merkle_root;
use std::hash::poseidon::bn254::hash_2 as poseidon2;

#[test]
fn correct_binary_merkle_root() {
    let identityCommitment = 1280033553760815678764770846139155613435155939625621669696967390845036381755;
    let merkleProofLength = 2;
    let merkleProofIndices = [1, 1];
    let merkleProofSiblings = [ 4, 3720616653028013822312861221679392249031832781774563366107458835261883914924];
    let root = 10509779603326422522676562251845606046522679317041388765499233991324785125471;
    let rootResult = binary_merkle_root::binary_merkle_root(poseidon2, identityCommitment, merkleProofLength, merkleProofIndices, merkleProofSiblings);

    assert(rootResult == root);
}

#[test]
fn max_depth_greater_than_depth() {
    let identityCommitment = 1280033553760815678764770846139155613435155939625621669696967390845036381755;
    let merkleProofLength = 2;
    let merkleProofIndices = [1, 1, 0, 0, 0];
    let merkleProofSiblings = [ 4, 3720616653028013822312861221679392249031832781774563366107458835261883914924, 0, 0, 0];
    let root = 10509779603326422522676562251845606046522679317041388765499233991324785125471;
    let rootResult = binary_merkle_root::binary_merkle_root(poseidon2, identityCommitment, merkleProofLength, merkleProofIndices, merkleProofSiblings);

    assert(rootResult == root);
}

#[test(should_fail)]
fn incorrect_binary_merkle_root() {
    let identityCommitment = 1280033553760815678764770846139155613435155939625621669696967390845036381755;
    let merkleProofLength = 2;
    let merkleProofIndices = [1, 0];
    let merkleProofSiblings = [ 4, 3720616653028013822312861221679392249031832781774563366107458835261883914924];
    let root = 10509779603326422522676562251845606046522679317041388765499233991324785125471;
    let rootResult = binary_merkle_root::binary_merkle_root(poseidon2, identityCommitment, merkleProofLength, merkleProofIndices, merkleProofSiblings);

    assert(rootResult == root);
}

