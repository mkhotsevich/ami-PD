process.env.NODE_ENV = 'test';

const mongoose = require("mongoose");
const User = require('../models/User');

const chai = require('chai');
const chaiHttp = require('chai-http');
const app = require('../app');
const should = chai.should();

chai.use(chaiHttp);
describe('Users', () => {
	beforeEach((done) => {
		User.deleteMany({}, (err) => {
			done();
		});
	});
	describe('/POST User', () => {
		it('Должна пройти регистрация без ошибок', (done) => {
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
					res.body.should.have.property('message');
					done();
				});
		});
	});
});