const { body } = require('express-validator')
const User = require('../models/User')

exports.registerValidators = [
	body('email', 'Некорректный email')
		.isEmail()
		.custom(async (value, {req}) => {
			try {
				const user = await User.findOne({ email: value })
				if (user) {
					return Promise.reject('Email занят')
				}
			} catch (e) {
				console.log(e)
			}
		})
		.normalizeEmail(),
	body('password', '/ПРИДУМАТЬ СООБЩЕНИЕ/')
		.isLength({ min: 6, max: 64 })
		.isAlphanumeric()
		.trim(),
	body('confirm')
		.custom((value, { req }) => {
			if (value !== req.body.password) {
				throw new Error('Пароли не совпадают')
			}
			return true
		})
		.trim()
]