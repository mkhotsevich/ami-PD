const { Router } = require('express')
const User = require('../models/User')
const auth = require('../middleware/auth.middleware')

const router = Router()


// /api/users
router.get('/:id', auth, async (req, res) => {
	try {
		const user = await User.findById(req.params.id, (err) => {
			if (err) return res.status(404).json({ message: "Пользователь не найден" })
		})

		if (!user) return res.status(404).json({ message: "Пользователь не найден" })

		return res.status(200).json({
			id: user._id,
			email: user.email,
			name: user.name,
			surname: user.surname,
			birthdate: user.birthdate,
			height: user.height,
			appleId: user.appleId,
			vkId: user.vkId
		})
	} catch (e) {
		console.log(e)
		return res.status(500).json({ message: 'Что-то пошло не так, попробуйте позже' })
	}
})
router.put('/:id', auth, async (req, res) => {
	try {
		const { email, name, surname, birthdate, height, appleId, vkId } = req.body

		const user = await User.findById(req.params.id, (err) => {
			if (err) return res.status(404).json({ message: "Пользователь не найден" })
		})

		if (!user) return res.status(404).json({ message: "Пользователь не найден" })

		user.email = email || user.email
		user.name = name || user.name
		user.surname = surname || user.surname
		user.birthdate = birthdate || user.birthdate
		user.height = height || user.height
		user.appleId = appleId || user.appleId
		user.vkId = vkId || user.vkId

		await user.save()

		return res.status(200).json({
			id: user._id,
			email: user.email,
			name: user.name,
			surname: user.surname,
			birthdate: user.birthdate,
			height: user.height,
			appleId: user.appleId,
			vkId: user.vkId
		})

	} catch (e) {
		console.log(e)
		return res.status(500).json({ message: 'Что-то пошло не так, попробуйте позже' })
	}
})

module.exports = router