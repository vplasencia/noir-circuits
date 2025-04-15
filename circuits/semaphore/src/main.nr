use ec::bjj::BabyJubJubParams;
use ec::Curve;
use ec::CurveTrait;
use ec::scalar_field::ScalarField;
use std::field::bn254::assert_lt;
use std::hash::poseidon::bn254::hash_2 as poseidon2;
use binary_merkle_root;

// Maximum depth of the Merkle Tree.
pub global MAX_DEPTH: u32 = 10;

// Generator point of Baby Jubjub curve.
// ref: https://github.com/noir-lang/noir-edwards/blob/main/src/test.nr#L7-L9
global BASE8: [Field; 2] = [
    5299619240641551281634865583518297030282874472190772894086521144482721001553,
    16950150798460657717958625567821834550301663161624707787222815936182638968203,
];

// This is a 251 bit value.
global L: Field = 2736030358979909402780800718157159386076813972158567259200215660948447373041;

fn main(
    secret: Field,
    merkle_proof_length: u32, 
    merkle_proof_indices: [u1; MAX_DEPTH], 
    merkle_proof_siblings: [Field; MAX_DEPTH], 
    message: pub Field,
    scope: pub Field,
) -> pub (Field, Field) {

    // Ensure secret < l.
    assert_lt(secret, L);

    // Identity generation.
    let generator: Curve<BabyJubJubParams> = Curve { x: BASE8[0], y: BASE8[1] };
    let secret_scalar: ScalarField<63> = ScalarField::from(secret);
    let public_key = generator.mul(secret_scalar);

    let identity_commitment = poseidon2([public_key.x, public_key.y]);

    // Calculate Merkle root.
    let merkle_root = binary_merkle_root::binary_merkle_root(poseidon2, identity_commitment, merkle_proof_length, merkle_proof_indices, merkle_proof_siblings);

    // Nullifier generation.
    let nullifier = poseidon2([scope, secret]);

    // Output the root and nullifier.
    (merkle_root, nullifier)
}

#[test]
fn generate_root_and_nullifier_correctly() {
    let secret = 1108309587400101993411102416244214863407236426086075003887302581916280632942;
    let merkle_proof_indices = [ 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 ];
    let merkle_proof_length = 2;
    let merkle_proof_siblings = [
        4,
        3720616653028013822312861221679392249031832781774563366107458835261883914924,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
    ];
    let message = 43;
    let scope = 32;

    let result = main(
        secret,
        merkle_proof_length,
        merkle_proof_indices,
        merkle_proof_siblings,
        message,
        scope
    );

    let root = 10509779603326422522676562251845606046522679317041388765499233991324785125471;
    println(result.0);

    let nullifier = 2759611332136168109384444309579308983577092287391539422712141904222269274304;
    println(result.1);

    assert(
        result.0 == root
    );

    assert(
        result.1 == nullifier
    );
}
