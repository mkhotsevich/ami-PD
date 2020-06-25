const { Router } = require('express')
const { validationResult } = require('express-validator')
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const { registerValidators } = require('../utils/validators')
const User = require('../models/User')
const keys = require('../keys')

const router = Router()

// /api/auth/login
router.post('/login', async (req, res) => {
	try {
		const { email, password } = req.body
		const candidate = await User.findOne({ email })

		if (candidate) {
			const areSame = await bcrypt.compare(password, candidate.password)
			if (areSame) {
				const token = jwt.sign(
					{ userId: candidate._id },
					keys.SECRET,
					{ expiresIn: '30d' }
				)
				return res.status(200).json({
					message: 'Успешно',
					token
				})
			} else {
				return res.status(400).json({
					message: 'Неверный пароль'
				})
			}
		} else {
			return res.status(400).json({
				message: 'Пользователь не найден'
			})
		}
	} catch (e) {
		console.log(e)
		return res.status(500).json({
			message: 'Server error'
		})
	}
})
router.get('/login', (req, res) => {
	res.send(JSON.stringify(req.session))
})
// /api/auth/register
router.post('/register', registerValidators, async (req, res) => {
	try {
		const { email, password } = req.body
		const errors = validationResult(req)
		if (!errors.isEmpty()) {
			return res.status(400).json({
				message: errors.array()[0].msg
			})
		}
		const hashedPassword = await bcrypt.hash(password, 10)
		const user = new User({
			email,
			password: hashedPassword
		})
		await user.save()
		return res.status(200).json({
			message: 'Успешно'
		})
	} catch (e) {
		console.log(e)
		return res.status(500).json({
			message: 'Server error'
		})
	}
})

// /api/auth/logout
router.post('/logout', async (req, res) => {
	
})


module.exports = router