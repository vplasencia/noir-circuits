pub fn binary_merkle_root<let MAX_DEPTH: u32>(hasher: fn([Field; 2]) -> Field, leaf: Field, depth: u32, indices: [u1; MAX_DEPTH], siblings: [Field; MAX_DEPTH]) -> Field {
    
    let mut node = leaf;

    for i in 0..MAX_DEPTH {
        if i < depth {
            let sibling = siblings[i];
            let (left, right) = if indices[i] == 0 {
                (node, sibling)
            } else {
                (sibling, node)
            };
            node = hasher([left, right]);
        }
    }
    
    node
}
