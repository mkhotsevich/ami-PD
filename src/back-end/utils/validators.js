const { body } = require('express-validator')

exports.registerValidators = [
	body('email', 'Некорректный email')
		.isEmail()
		.custom(async (value, {req}) => {
			try {
				// Проверка на существующий email
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