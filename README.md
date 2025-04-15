# Noir Circuits

This project contains some Noir circuits, which can be found in the `circuits` folder.

## Install dependencies

```sh
yarn
```

## Compile circuit

To compile the circuit, run:

```sh
yarn compile <circuit-name>
```

Note: Replace `<circuit-name>` with the name of the specific circuit you want to use.

## Generate prover file

To generate the `Prover.toml` file, run:

```sh
yarn generate:prover <circuit-name>
```

## Generate witness

To compile and generate the witness, run:

```sh
yarn generate:witness <circuit-name>
```

## Generate and verify proof

To generate and verify the proof, run:

```sh
yarn prove:verify <circuit-name>
```

## Run tests

```sh
yarn test <circuit-name>
```

To show test logs, run:

```sh
yarn test:log <circuit-name>
```

If the circuit is a library (e.g. binary_merkle_root), run:

```sh
yarn test:libraries
```

To show library test logs, run:

```sh
yarn test:libraries:log
```

## Code formatting

Run [Prettier](https://prettier.io/) to check formatting rules:

```bash
yarn prettier
```

Or to automatically format the code:

```bash
yarn prettier:write
```