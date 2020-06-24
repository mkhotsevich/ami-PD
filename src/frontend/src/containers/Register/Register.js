import React, { Fragment } from 'react'
import classes from './Register.module.css'
import Input from '../../components/UI/Input/Input'

const Register = () => {
	return (
		<Fragment>
			<div className={`row h-100`}>
				<div className={'col-5 mx-auto d-flex flex-column justify-content-center h-100'}>
					<div className={`${classes.Register} d-flex flex-column`}>
						<img />
						<h1 className={'text-center'}>Регистрация</h1>
						<Input/>
						<Input/>
					</div>
				</div>
			</div>
		</Fragment>
	)
}

export default Register