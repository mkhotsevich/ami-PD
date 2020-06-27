const keys = require("../keys")

// TODO: сделать шаблон письма
module.exports = function (email) {
	return {
		to: email,
		from: keys.OUR_EMAIL,
		subject: 'Аккаунт создан',
		html: `
		<h1>Тест письма</h1>
		`
	}
}