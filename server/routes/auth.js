const express = require("express");
const User = require("../models/user")
const authRouter = express.Router();
const bcrypt = require("bcryptjs")
const auth = require("../middlewares/auth");
const jwt = require("jsonwebtoken")
authRouter.post('/api/signup', async (req, res) => {
    const { name, email, password } = req.body;
    try {
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "User already existe" })
        }
        const hashedPassword = await bcrypt.hash(password, 8)
        let user = User({ name, email, password: hashedPassword });
        user = await user.save();
        res.send(user)
    } catch (e) {
        res.send(e);
    }

});

authRouter.post("/api/signin", async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email })

        if (!user) {
            res.status(400).send({ msg: "User not found" })
        }

        const isMatch = await bcrypt.compare(password, user.password);

        if (!isMatch) {
            res.send({ msg: "incorrect password" })
        }
        const token = jwt.sign({ "id": user._id }, "password Key");
        res.send({ token, ...user._doc })
    } catch (e) {
        res.status(500).json({ error: e.message })
    }
});

authRouter.post("/api/tokenIsValid", async (req, res) => {
    const token = req.header("x-auth-token");
    if (!token) return false;
    const verify = jwt.verify(token, 'password Key');
    if (!verify) return false;
    const user = await User.findById(verify.id);
    if (!user) return false;
    res.json(true)
})


authRouter.get("/api/", auth, async (req, res) => {
    const user = await User.findById(req.user);
     res.json({ ...user._doc, token: req.token }
    )
})
module.exports = authRouter;