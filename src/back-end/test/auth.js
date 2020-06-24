process.env.NODE_ENV = 'test'

const mongoose = require("mongoose")
const chai = require('chai')
const chaiHttp = require('chai-http')
const bcrypt = require('bcryptjs')

const User = require('../models/User')
const app = require('../app')

const should = chai.should()

chai.use(chaiHttp)
describe('Users', () => {
	beforeEach((done) => {
		User.deleteMany({}, (err) => {
			done()
		})
	})
	describe('/POST auth/register', () => {
		it('Должна пройти регистрация с корректными данными', (done) => {
			const user = {
				email: 'xozewitc@yandex.ru',
				password: '12345678',
				confirm: '12345678'
			}
			chai.request(app)
				.post('/api/auth/register')
				.send(user)
				.end((err, res) => {
					res.should.have.status(200);
					done()
				})
		})
	})
	describe('/POST auth/login', () => {
		it('Должен произойти вход с корректными данными', (done) => {
			const user2 = {
				email: 'maxim@yandex.ru',
				password: '12345678'
			}
			const user = new User({
				email: 'maxim@yandex.ru',
				password: bcrypt.hashSync('12345678', 10)
			})
			user.save((err, user) => {
				chai.request(app)
					.post('/api/auth/login')
					.send(user2)
					.end((err, res) => {
						res.should.have.status(200);
						done()
					})
			})
		})
	})
})