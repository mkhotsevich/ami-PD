import React, { Fragment } from 'react'
import classes from './Register.module.css'
import Input from '../../components/UI/Input/Input'
import Button from '../../components/UI/Input/Button/Button'
import logo from '../../images/logo.svg'
import google from '../../images/google.svg'
import facebook from '../../images/facebook.svg'
import vk from '../../images/vk.svg'

const Register = () => {
	return (
		<Fragment>
			<div className={`row h-100`}>
				<div className={'col-12 col-sm-10 col-md-8 col-lg-5 mx-auto d-flex flex-column justify-content-center h-100'}>
					<div className={`${classes.Register} d-flex flex-column px-5 py-3 justify-content-between`}>
						<img src={logo} alt={'logo'} />
						<h1 className={'text-center'}>Регистрация</h1>
						<Input
							type={'text'}
							placeholder={'Email'}
						/>
						<Input
							type={'password'}
							placeholder={'Пароль'}
						/>
						<Input
							type={'password'}
							placeholder={'Повторите пароль'}
						/>
						<p className={'text-justify'}>
							Регистрируясь, вы принимаете наши Условия,
							Политику использования данных и Политику в отношении файлов cookie.
						</p>
						<Button
							type={'primary'}
						>
							Зарегестрироваться
							</Button>
						<hr />
						<Button
							type={'success'}
						>
							Уже есть аккаунт? Войти
						</Button>
						<div className={'d-flex justify-content-around'}>
							<img src={google} alt={'google'}/>
							<img src={facebook} alt={'facebook'}/>
							<img src={vk} alt={'vk'}/>
						</div>
					</div>
				</div>
			</div>
		</Fragment>
	)
}

export default Register