use ec::bjj::BabyJubJubParams;
use ec::Curve;
use ec::CurveTrait;
use ec::scalar_field::ScalarField;
use std::field::bn254::assert_lt;
use std::hash::poseidon::bn254::hash_2 as poseidon2;

// Generator point of Baby Jubjub curve.
// ref: https://github.com/noir-lang/noir-edwards/blob/main/src/test.nr#L7-L9
global BASE8: [Field; 2] = [
    5299619240641551281634865583518297030282874472190772894086521144482721001553,
    16950150798460657717958625567821834550301663161624707787222815936182638968203,
];

// This is a 251 bit value.
global L: Field = 2736030358979909402780800718157159386076813972158567259200215660948447373041;

fn main(secret: Field, scope: pub Field) -> pub Field {
    // Ensure secret < l.
    assert_lt(secret, L);

    // Identity generation.
    let generator: Curve<BabyJubJubParams> = Curve { x: BASE8[0], y: BASE8[1] };
    let secret_scalar: ScalarField<63> = ScalarField::from(secret);
    let public_key = generator.mul(secret_scalar);

    let identity_commitment = poseidon2([public_key.x, public_key.y]);

    // Output the identity_commitment.
    identity_commitment
}

#[test]
fn generate_commitment_correctly() {
    let secret = 1108309587400101993411102416244214863407236426086075003887302581916280632942;
    let scope = 32;

    let result = main(secret, scope);

    let commitment = 1280033553760815678764770846139155613435155939625621669696967390845036381755;

    assert(result == commitment);
}
