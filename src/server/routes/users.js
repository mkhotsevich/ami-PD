const { Router } = require('express')
const User = require('../models/User')
const auth = require('../middleware/auth.middleware')

const router = Router()


// /api/users
router.get('/', auth, async (req, res) => {
	try {
		const users = await User.find()
		res.status(200).json({ users })
		console.log(req.user)
	} catch (e) {
		return res.status(500).json({
			message: 'Server error'
		})
	}
})
router.get('/:id', async (req, res) => {
	try {

	} catch (e) {
		return res.status(500).json({
			message: 'Server error'
		})
	}
})

module.exports = router