process.env.NODE_ENV = 'test'

const mongoose = require("mongoose")
const chai = require('chai')
const chaiHttp = require('chai-http')
const bcrypt = require('bcryptjs')

const User = require('../models/User')
const app = require('../app')

const should = chai.should()

chai.use(chaiHttp)

describe('Auth', () => {
	beforeEach((done) => {
		User.deleteOne({}, (err) => {
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
					res.body.should.have.property('message').eql('Успешно')
					done()
				})
		})
	})
	describe('/POST auth/register', () => {
		it('Должна быть ошибка при некорректном email', (done) => {
			const user = {
				email: 'xozewitcyandex.ru',
				password: '12345678',
				confirm: '12345678'
			}
			chai.request(app)
				.post('/api/auth/register')
				.send(user)
				.end((err, res) => {
					res.should.have.status(400)
					res.body.should.have.property('message').eql('Некорректный email')
					done()
				})
		})
	})
	describe('/POST auth/register', () => {
		it('Должна быть ошибка при несовпадении паролей', (done) => {
			const user = {
				email: 'xozewitc@yandex.ru',
				password: '1235678',
				confirm: '12345678'
			}
			chai.request(app)
				.post('/api/auth/register')
				.send(user)
				.end((err, res) => {
					res.should.have.status(400)
					res.body.should.have.property('message').eql('Пароли не совпадают')
					done()
				})
		})
	})
	describe('/POST auth/register', () => {
		it('Должна быть ошибка при некорректном пароле', (done) => {
			const user = {
				email: 'xozewitc@yandex.ru',
				password: '123',
				confirm: '123'
			}
			chai.request(app)
				.post('/api/auth/register')
				.send(user)
				.end((err, res) => {
					res.should.have.status(400)
					res.body.should.have.property('message').eql('Некорректный пароль')
					done()
				})
		})
	})
	describe('/POST auth/register', () => {
		it('Должна быть ошибка при занятом email', (done) => {
			const user1 = new User({
				email: 'xozewitc@yandex.ru',
				password: '12345678',
				confirm: '12345678'
			})
			const user2 = {
				email: 'xozewitc@yandex.ru',
				password: '87654321',
				confirm: '87654321'
			}
			user1.save(() => {
				chai.request(app)
					.post('/api/auth/register')
					.send(user2)
					.end((err, res) => {
						res.should.have.status(400)
						res.body.should.have.property('message').eql('Email занят')
						done()
					})
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
						res.body.should.have.property('message').eql('Успешно')
						done()
					})
			})
		})
	})
	describe('/POST auth/login', () => {
		it('Должен произойти ошибка при входе с неверным паролем', (done) => {
			const user1 = new User({
				email: 'maxim@yandex.ru',
				password: bcrypt.hashSync('1234567', 10)
			})
			const user2 = {
				email: 'maxim@yandex.ru',
				password: '12345678'
			}
			user1.save((err, user) => {
				chai.request(app)
					.post('/api/auth/login')
					.send(user2)
					.end((err, res) => {
						res.should.have.status(400);
						res.body.should.have.property('message').eql('Неверный пароль')
						done()
					})
			})
		})
	})
	describe('/POST auth/login', () => {
		it('Должен произойти ошибка при входе с неверным email', (done) => {
			const user1 = new User({
				email: 'maxim@yandex.ru',
				password: bcrypt.hashSync('12345678', 10)
			})
			const user2 = {
				email: 'maxim1@yandex.ru',
				password: '12345678'
			}
			user1.save((err, user) => {
				chai.request(app)
					.post('/api/auth/login')
					.send(user2)
					.end((err, res) => {
						res.should.have.status(400);
						res.body.should.have.property('message').eql('Пользователь не найден')
						done()
					})
			})
		})
	})
})