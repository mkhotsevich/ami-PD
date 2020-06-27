const { body } = require('express-validator')
const User = require('../models/User')

// TODO: Сделать валидаторы для регистрации
exports.registerValidators = [
	body('email', 'Некорректный email')
		.isEmail()
		.custom(async (value, {req}) => {
			try {
				const user = await User.findOne({ email: value })
				if (user) {
					return Promise.reject('Пользователь с таким Email уже существует')
				}
			} catch (e) {
				console.log(e)
			}
		})
		.normalizeEmail(),
]
