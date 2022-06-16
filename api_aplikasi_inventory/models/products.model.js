const mongoose = require("mongoose");

const product = mongoose.model(
    "products",
    mongoose.Schema({
        productName: String,
        productType: String,
        productAmount: Number,
        productImage: String,
    }, {
        timestamps: true,
    })
);

module.exports = {
    product
}