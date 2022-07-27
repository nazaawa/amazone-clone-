const mongoose = require("mongoose")


const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
             return   value.match(re);
            },
            message : ' please enter a valid e-mail address'
        }
    },
    password: {
        required: true,
        type :String,
        validate: {
            validator: (value) => {
                return value.length > 6;
            }
        },
        message : ' please password shoud have more than 6'

    },
    address: {
        type: String,
        default : ""
    },
    type: {
        type: String,
        default :"user"
    }
})


const User = mongoose.model("User", userSchema);
module.exports = User;