fn main(unsolved: pub [[Field; 9]; 9], solved: [[Field; 9]; 9]) {
    // Check if the numbers of the solved sudoku are >=1 and <=9
    // Each number in the solved sudoku is checked to see if it is >=1 and <=9

    for i in 0..9 {
        for j in 0..9 {
            assert(solved[i][j] as u8 > 0);
            assert(solved[i][j] as u8 < 10);
        }
    }

    // Check if unsolved is the initial state of solved
    // If unsolved[i][j] is not zero, it means that solved[i][j] is equal to unsolved[i][j]
    // If unsolved[i][j] is zero, it means that solved [i][j] is different from unsolved[i][j]

    for i in 0..9 {
        for j in 0..9 {
            if unsolved[i][j] != 0 {
                assert(solved[i][j] == unsolved[i][j]);
            }

            if unsolved[i][j] == 0 {
                assert(solved[i][j] != unsolved[i][j]);
            }
        }
    }

    // Check if each row in solved has all the numbers from 1 to 9, both included
    // For each element in solved, check that this element is not equal
    // to previous elements in the same row

    for i in 0..9 {
        for j in 0..9 {
            for k in 0..j {
                assert(solved[i][j] != solved[i][k]);
            }
        }
    }

    // Check if each column in solved has all the numbers from 1 to 9, both included
    // For each element in solved, check that this element is not equal
    // to previous elements in the same column

    for i in 0..9 {
        for j in 0..9 {
            for k in 0..i {
                assert(solved[i][j] != solved[k][j]);
            }
        }
    }

    // Check if each square in solved has all the numbers from 1 to 9, both included
    // For each square and for each element in each square, check that the
    // element is not equal to previous elements in the same square

    for i in 0..3 {
        for j in 0..3 {
            for k in i * 3..i * 3 + 3 {
                for l in j * 3..j * 3 + 3 {
                    for m in i * 3..=k {
                        for n in j * 3..l {
                            assert(solved[m][n] != solved[k][l]);
                        }
                    }
                }
            }
        }
    }
}

#[test]
fn test_correct_sudoku_solution() {
    let unsolved = [
        [0, 0, 0, 0, 0, 6, 0, 0, 0],
        [0, 0, 7, 2, 0, 0, 8, 0, 0],
        [9, 0, 6, 8, 0, 0, 0, 1, 0],
        [3, 0, 0, 7, 0, 0, 0, 2, 9],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [4, 0, 0, 5, 0, 0, 0, 7, 0],
        [6, 5, 0, 1, 0, 0, 0, 0, 0],
        [8, 0, 1, 0, 5, 0, 3, 0, 0],
        [7, 9, 2, 0, 0, 0, 0, 0, 4],
    ];
    let solved = [
        [1, 8, 4, 3, 7, 6, 2, 9, 5],
        [5, 3, 7, 2, 9, 1, 8, 4, 6],
        [9, 2, 6, 8, 4, 5, 7, 1, 3],
        [3, 6, 5, 7, 1, 8, 4, 2, 9],
        [2, 7, 8, 4, 6, 9, 5, 3, 1],
        [4, 1, 9, 5, 3, 2, 6, 7, 8],
        [6, 5, 3, 1, 2, 4, 9, 8, 7],
        [8, 4, 1, 9, 5, 7, 3, 6, 2],
        [7, 9, 2, 6, 8, 3, 1, 5, 4],
    ];

    let result = main(unsolved, solved);
    assert(result == ());
}

#[test(should_fail)]
fn test_incorrect_sudoku_solution() {
    let unsolved = [
        [0, 0, 0, 0, 0, 6, 0, 0, 0],
        [0, 0, 7, 2, 0, 0, 8, 0, 0],
        [9, 0, 6, 8, 0, 0, 0, 1, 0],
        [3, 0, 0, 7, 0, 0, 0, 2, 9],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [4, 0, 0, 5, 0, 0, 0, 7, 0],
        [6, 5, 0, 1, 0, 0, 0, 0, 0],
        [8, 0, 1, 0, 5, 0, 3, 0, 0],
        [7, 9, 2, 0, 0, 0, 0, 0, 4],
    ];

    // solved has a 0 in the first row, first column
    let solved = [
        [0, 8, 4, 3, 7, 6, 2, 9, 5],
        [5, 3, 7, 2, 9, 1, 8, 4, 6],
        [9, 2, 6, 8, 4, 5, 7, 1, 3],
        [3, 6, 5, 7, 1, 8, 4, 2, 9],
        [2, 7, 8, 4, 6, 9, 5, 3, 1],
        [4, 1, 9, 5, 3, 2, 6, 7, 8],
        [6, 5, 3, 1, 2, 4, 9, 8, 7],
        [8, 4, 1, 9, 5, 7, 3, 6, 2],
        [7, 9, 2, 6, 8, 3, 1, 5, 4],
    ];

    let result = main(unsolved, solved);
    assert(result == ());
}
