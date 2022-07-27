//IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
//IMPORT FROM OTHER FILES
const authRouter = require("./routes/auth")

//INIT
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://johnny:Johnny144000@cluster0.e3vyn.mongodb.net/?retryWrites=true&w=majority";
//middleware
app.use(express.json())
app.use(authRouter);


//connections
mongoose.connect(DB).then(() => {
    console.log("connection successful");
}).catch(e => { 
    console.log(e)
})

app.listen(PORT,"0.0.0.0", function () {
    console.log('connected  at port ' + PORT)
})