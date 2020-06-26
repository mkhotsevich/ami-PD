const { Router } = require('express')
const { validationResult } = require('express-validator')
const jwt = require('jsonwebtoken')


const { registerValidators } = require('../utils/validators')
const User = require('../models/User')
const keys = require('../keys')

const router = Router()

// api/auth/login
router.post('/login', async (req, res) => {
	try {
		const { email, password } = req.body
		const candidate = await User.findOne({ email })

		if (candidate) {
			// FIXME: сделать сравнеение локоничнее
			const areSame = password === candidate.password ? true : false
			if (areSame) {
				const accessToken = jwt.sign({ userId: candidate._id }, keys.SECRET, { expiresIn: '30d' })
				return res.status(200).json({ accessToken, user: candidate })
			} else {
				return res.status(400).json({ message: 'Неверный пароль' })
			}
		} else {
			return res.status(400).json({ message: 'Пользователь не найден' })
		}
	} catch (e) {
		return res.status(500).json({ message: 'Что-то пошло не так, попробуйте позже' })
	}
})

// api/auth/register
router.post('/register', registerValidators, async (req, res) => {
	try {
		const errors = validationResult(req)
		if (!errors.isEmpty()) return res.status(400).json({ message: errors.array()[0].msg })

		const { email, password, name, surname, birthday, weight, height, appleId, vkId } = req.body

		const user = new User({ email, password, name, surname, birthday, weight, height, appleId, vkId })
		await user.save()

		const newUser = await User.findOne({ email })
		const accessToken = jwt.sign({ userId: newUser._id }, keys.SECRET, { expiresIn: '30d' })

		return res.status(201).json({ accessToken, user: newUser })
	} catch (e) {
		return res.status(500).json({ message: 'Что-то пошло не так, попробуйте позже' })
	}
})

module.exports = router