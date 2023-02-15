# AASX Signer

Tool to sign and verify Asset Administration Shell AASX files.

## Prerequisites

AASX Signer uses PGP for signing / verification.
Therefore you need to create a PGP keypair beforehand, for example using:

```bash
gpg --gen-key
```

## Usage

Sign `file.aasx`:

```bash
./aasx-signer.sh sign file.aasx file_signed.aasx
```

Verify `file_signed.aasx`:

```bash
./aasx-signer.sh verify file_signed.aasx
```

## How it works

For signing, AASX Signer generates a PGP signature for the input file and adds it to the input file (which is a zip container) as `SIGNATURE` file.

For verification, this process is reversed, i.e., the `SIGNATURE` file is extracted and removed from the input file and then checked via PGP.