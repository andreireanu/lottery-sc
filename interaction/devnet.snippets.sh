PROXY=https://devnet-gateway.multiversx.com
CHAIN_ID="D"
WALLET_ALICE="${PWD}/lottery/wallets/alice.pem"
WALLET_BOB="${PWD}/lottery/wallets/bob.pem"
WALLET_TONY="${PWD}/lottery/wallets/tony.pem"
CONTRACT_ADDRESS="erd1qqqqqqqqqqqqqpgquspc2ft4m7r820l52np04x22zeqven7l7wpq5enc2v"
ALICE_ADDRESS="erd1aqd2v3hsrpgpcscls6a6al35uc3vqjjmskj6vnvl0k93e73x7wpqtpctqw"
ALICE_ADDRESS_HEX="$(mxpy wallet bech32 --decode ${ALICE_ADDRESS})"
ALICE_ADDRESS_HEXX="0x$(mxpy wallet bech32 --decode ${ALICE_ADDRESS})"
BOB_ADDRESS="erd1wh2rz67zlq5nea7j4lvs39n0yavjlaxal88f744k2ps036ary8dq3ptyd4"
BOB_ADDRESS_HEX="$(mxpy wallet bech32 --decode ${BOB_ADDRESS})"
BOB_ADDRESS_HEXX="0x$(mxpy wallet bech32 --decode ${BOB_ADDRESS})"
MARTA_ADDRESS="erd1uycnjd0epww6xrmn0xjdkfhjengpaf4l5866rlrd8qpcsamrqr8qs6ucxx"
MARTA_ADDRESS_HEX="$(mxpy wallet bech32 --decode ${MARTA_ADDRESS})"
MARTA_ADDRESS_HEXX="0x$(mxpy wallet bech32 --decode ${MARTA_ADDRESS})"
TONY_ADDRESS="erd1pqrfjusazp8yuf6nwgqu3u6m3qz2cgpupacds5h39v47ezn03llqjpqg74"
TONY_ADDRESS_HEX="$(mxpy wallet bech32 --decode ${TONY_ADDRESS})"
TONY_ADDRESS_HEXX="0x$(mxpy wallet bech32 --decode ${TONY_ADDRESS})"

CONTRACT_ADDRESS_LOCAL="erd1qqqqqqqqqqqqqpgqfzydqmdw7m2vazsp6u5p95yxz76t2p9rd8ss0zp9ts"

deploy() {
 mxpy contract deploy --proxy=${PROXY} \
    --chain=${CHAIN_ID} \
    --bytecode=lottery/output/lottery.wasm \
    --pem="lottery/wallets/alice.pem" \
    --gas-limit=60000000 \
    --recall-nonce \
    --send \
    --metadata-payable
}
   
upgrade() {
 mxpy contract upgrade ${CONTRACT_ADDRESS} \
    --bytecode=lottery/output/lottery.wasm \
    --pem="lottery/wallets/alice.pem" \
    --chain=${CHAIN_ID} \
    --proxy=${PROXY} \
    --recall-nonce \
    --gas-limit=5000000 \
    --send \
    --metadata-payable
}




NAME=EGLD
AMOUNT=10000000000000000
METHOD_NAME=endpointName

endpointName() {
    erdpy --verbose contract call ${CONTRACT_ADDRESS} --recall-nonce \
    --send \
    --value=10000000000000000 \
    --proxy=${PROXY} \
    --chain=${CHAIN_ID} \
    --pem=${WALLET_ALICE} \
    --recall-nonce \
    --gas-limit=15000000 \
    --function="endpointName"
} 

endpointNameSimulate() {
    erdpy --verbose contract call ${CONTRACT_ADDRESS} --recall-nonce \
    --simulate \
    --value=10000000000000000 \
    --proxy=${PROXY} \
    --chain=${CHAIN_ID} \
    --pem=${WALLET_ALICE} \
    --recall-nonce \
    --gas-limit=15000000 \
    --function="endpointName"
} 

 

deployLocal() {
 mxpy contract deploy --proxy=${PROXY} \
    --bytecode=lottery/output/lottery.wasm \
    --pem="lottery/wallets/aliceLocal.pem" \
    --gas-limit=60000000 \
    --recall-nonce \
    --chain=localnet --proxy=http://localhost:7950 \
    --send \
    --metadata-payable
}

endpointNameLocal() {
    erdpy --verbose contract call ${CONTRACT_ADDRESS_LOCAL} --recall-nonce \
    --send \
    --value=10000000000000000 \
    --proxy=${PROXY} \
    --chain=localnet --proxy=http://localhost:7950 \
    --pem="lottery/wallets/aliceLocal.pem" \
    --recall-nonce \
    --gas-limit=15000000 \
    --function="endpointName"
}  