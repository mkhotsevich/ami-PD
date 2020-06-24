const { Router } = require('express')
const { registerValidators } = require('../utils/validators')
const router = Router()

// /api/auth/login
router.post('/login', async (req, res) => {
	try {
		console.log(req.body)
	} catch (e) {
		console.log(e)
	}
})

// /api/auth/register
router.post('/register', registerValidators, async (req, res) => {
	try {
		const {email, password, confirm} = req.body
		console.log(email, password, confirm)
	} catch (e) {
		console.log(e)
	}
})


module.exports = router