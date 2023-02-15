#! /usr/bin/bash

set -e

ussage ()
{
    echo "Sign AASX package:"
    echo "  $0 sign <IN_FILE> <OUT_FILE>"
    echo
    echo "Verify AASX package:"
    echo "  $0 verify <FILE>"
}

if [ "$#" -lt 1 ]; then
    ussage
    exit 1
fi

SIGNATURE_FILE="SIGNATURE"

if [ "$1"  ==  "sign" ]; then
    infile="$2"
    outfile="$3"

    echo "Signing $infile > $outfile"
    gpg --output "$SIGNATURE_FILE" --detach-sig "$infile"
    cp "$infile" "$outfile"
    zip -ur "$outfile" "$SIGNATURE_FILE"
    rm "$SIGNATURE_FILE"
elif [ "$1" == "verify" ]; then
    infile="$2"
    tmpfile="$2.tmp"

    echo "Verifying $2"
    unzip -p "$infile" "$SIGNATURE_FILE" > "$SIGNATURE_FILE"
    cp "$infile" "$tmpfile"
    zip -d "$tmpfile" "$SIGNATURE_FILE"
    gpg --verify "$SIGNATURE_FILE" "$tmpfile"
    rm "$tmpfile"
    rm "$SIGNATURE_FILE"
else
    ussage
    exit 1
fi