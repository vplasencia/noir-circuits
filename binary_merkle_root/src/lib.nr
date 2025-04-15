pub fn binary_merkle_root<let MAX_DEPTH: u32>(hasher: fn([Field; 2]) -> Field, leaf: Field, depth: u32, indices: [u1; MAX_DEPTH], siblings: [Field; MAX_DEPTH]) -> Field {
    
    let mut node = leaf;

    for i in 0..MAX_DEPTH {
        if i < depth {
            if indices[i] == 1 {
                node = hasher([siblings[i], node]);
            } else {
                node = hasher([node, siblings[i]]);
            }
        }
    }
    
    node
}
