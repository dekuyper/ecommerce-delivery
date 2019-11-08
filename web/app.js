import { Drizzle } from 'drizzle';

// Import contracts
import EcommerceDelivery from './../build/contracts/EcommerceDelivery.json'

const options = {
    contracts: [
        EcommerceDelivery
    ]
};

const drizzle = new Drizzle(options);
