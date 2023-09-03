#![no_std]

multiversx_sc::imports!();

const ONE_HUNDREDTH_EGLD: u64 = 10000000000000000;
const MAX_NR: u64 = 3000;

#[multiversx_sc::contract]
pub trait LotteryContract {
    #[init]
    fn init(&self) {}

    #[payable("EGLD")]
    #[endpoint(endpointName)]
    fn endpoint_name(&self) { 
        let payment = self.call_value().egld_value().clone_value();
        require!(payment == ONE_HUNDREDTH_EGLD, "Invalid payment");
        
        let mut rand_source = RandomnessSource::new();
        let rand_nr = rand_source.next_u64_in_range(1, MAX_NR);
        if rand_nr < 1000 {
           let caller = self.blockchain().get_caller();
           self.send().direct_egld(&caller, &BigUint::from(2 * ONE_HUNDREDTH_EGLD));
        }
    }


}




