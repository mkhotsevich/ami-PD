const { Router } = require('express')
const { validationResult } = require('express-validator')
const jwt = require('jsonwebtoken')
const nodemailer = require('nodemailer')
const sendgrid = require('nodemailer-sendgrid-transport')

const { registerValidators } = require('../utils/validators')
const User = require('../models/User')
const keys = require('../keys')
const regEmail = require('../emails/registration')

const router = Router()
const transporter = nodemailer.createTransport(sendgrid({ auth: { api_key: keys.SENDGRID_API_KEY } }))

// api/auth/login
router.post('/login', async (req, res) => {
	try {
		const { email, password } = req.body
		const candidate = await User.findOne({ email })

		if (candidate) {
			if (password === candidate.password) {
				const accessToken = jwt.sign({ userId: candidate._id }, keys.SECRET, { expiresIn: '30d' })
				return res.status(200).json({ accessToken, user: candidate })
			} else {
				return res.status(400).json({ message: 'Неверный пароль' })
			}
		} else {
			return res.status(400).json({ message: 'Пользователь с таким Email не найден' })
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

		const { email, password, name, surname, birthdate, weight, height, appleId, vkId } = req.body

		const user = new User({ email, password, name, surname, birthdate, weight, height, appleId, vkId })
		await user.save()

		const newUser = await User.findOne({ email })
		const accessToken = jwt.sign({ userId: newUser._id }, keys.SECRET, { expiresIn: '30d' })

		await transporter.sendMail(regEmail(email))

		res.status(201).json({ accessToken, user: newUser })
	} catch (e) {
		console.log(e)
		return res.status(500).json({ message: 'Что-то пошло не так, попробуйте позже' })
	}
})

module.exports = router