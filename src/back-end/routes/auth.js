const { Router } = require('express')
const { registerValidators } = require('../utils/validators')
const { validationResult } = require('express-validator')
const router = Router()

// /api/auth/login
router.post('/login', async (req, res) => {
	try {
		req.session.isAuthenticated = true
		res.json(req.session)
	} catch (e) {
		console.log(e)
	}
})

// /api/auth/register
router.post('/register', registerValidators, async (req, res) => {
	try {
		const { email, password, confirm } = req.body

		const errors = validationResult(req)
		console.log(errors)
		if (!errors.isEmpty()) {
			// req.flash('registerError', errors.array()[0].msg)
			return res.status(422)
		}
	} catch (e) {
		console.log(e)
	}
})

// /api/auth/logout
router.post('/logout', async (req, res) => {
	req.session.destroy(() => {
		res.json(req.session)
	})
})


module.exports = router